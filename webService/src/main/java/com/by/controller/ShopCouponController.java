package com.by.controller;

import static com.by.SpringExtension.SpringExtProvider;

import java.util.List;
import java.util.Locale;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.actor.ShopCouponActor;
import com.by.exception.Fail;
import com.by.exception.NotFoundException;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.CouponTemplateJson;
import com.by.json.ExchangeCouponJson;
import com.by.json.ShopCouponJson;
import com.by.message.ShopCouponMessage;
import com.by.model.Member;
import com.by.model.ShopCoupon;
import com.by.service.MemberService;
import com.by.service.ShopCouponService;
import com.by.typeEnum.ValidEnum;
import com.by.utils.FailBuilder;

import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Inbox;
import scala.concurrent.duration.Duration;

/**
 * Created by yagamai on 15-12-8.
 */
@Controller
@RequestMapping(value = "/api/shopCoupons")
public class ShopCouponController implements UtilContoller {
	private ActorSystem system;
	private ActorRef ref;
	private ShopCouponService shopCouponService;
	private MemberService memberService;
	private ShaPasswordEncoder passwordEncoder;
	private MessageSource messageSource;

	@Autowired
	public ShopCouponController(ApplicationContext ctx, ActorSystem system, ShopCouponService shopCouponService,
			ShaPasswordEncoder passwordEncoder, MemberService memberService, MessageSource messageSource) {
		this.system = ctx.getBean(ActorSystem.class);
		this.ref = system.actorOf(SpringExtProvider.get(system).props("ShopCouponActor"), "shopCouponActor");
		
		this.shopCouponService = shopCouponService;
		this.memberService = memberService;
		this.messageSource = messageSource;
		this.passwordEncoder = passwordEncoder;
	}

	// 可以兑换的卡券列表
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public Status list(HttpServletRequest request,
			@PageableDefault(page = 0, size = 10, sort = "couponEndTime", direction = Direction.DESC) Pageable pageable) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);
		Page<ShopCoupon> coupons = shopCouponService.findByValid(ValidEnum.VALID, pageable);
		List<ShopCouponJson> results = coupons.getContent().stream().map(i -> {
			ShopCouponJson json = new ShopCouponJson(i);
			json.setShopName(i.getShop().getName());
			return json;
		}).collect(Collectors.toList());
		return new Success<>(new PageImpl<>(results, pageable, coupons.getTotalElements()));
	}

	// 兑换卡券
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Status exchangeCoupon(HttpServletRequest request, @Valid @RequestBody ExchangeCouponJson json,
			BindingResult result) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);
		if (result.hasErrors()) {
			return FailBuilder.buildFail(result);
		}

		if (member.getMemberDetail().getPassword() != null) {
			if (StringUtils.isEmpty(json.getPassword())) {
				return new Fail(messageSource.getMessage("password.need", new Object[] {}, Locale.CHINESE));
			}
		}
		if (!StringUtils.isEmpty(json.getPassword()) && member.getMemberDetail().getPassword() != null) {
			if (!passwordEncoder.encodePassword(json.getPassword(), null)
					.equals(member.getMemberDetail().getPassword())) {
				return new Fail(messageSource.getMessage("password.notCorrect", new Object[] {}, Locale.CHINESE));
			}
		}
		ShopCoupon sc = new ShopCoupon();
		sc.setId(json.getId());
		ShopCouponMessage message = new ShopCouponMessage(sc, member, json.getTotal());

		final Inbox inbox = Inbox.create(system);
		inbox.send(ref, message);
		try {
			String code = (String) inbox.receive(Duration.create(2, TimeUnit.SECONDS));
			if (code.equals("success"))
				return new Success<String>("success");
			return new Fail(code);
		} catch (TimeoutException e) {
			e.printStackTrace();
		}
		return new Fail("system error");
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Status detail(@PathVariable("id") int id) {
		ShopCoupon shopCoupon = shopCouponService.findOneCache(id);
		if (shopCoupon == null)
			throw new NotFoundException();
		return new Success<>(new CouponTemplateJson(shopCoupon));
	}

}
