package com.by.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.exception.Fail;
import com.by.exception.MemberNotFoundException;
import com.by.exception.ShopNotExistException;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.CouponJson;
import com.by.json.ShopCouponUseJson;
import com.by.json.TradingRequestJson;
import com.by.model.Member;
import com.by.model.ShopCouponMember;
import com.by.model.Trading;
import com.by.service.MemberService;
import com.by.service.ShopCouponMemberService;
import com.by.service.TradingService;
import com.by.utils.WechatTemplateMsgUtil;

/**
 * Created by yagamai on 16-2-25.
 */
@Controller
@RequestMapping(value = "/poster")
public class HuiYinController {
	@Value("${key.poster}")
	private String posterKey;
	@Autowired
	private ShopCouponMemberService shopCouponMemberService;
	@Autowired
	private TradingService tradingService;
	@Autowired
	private MemberService memberService;
	
	private static final String KEY_REQUIRED= "非法请求，拒绝访问！";
	private static final String SHOP_REQUIRED= "店铺不存在！";
	private static final String MEMBER_REQUIRED= "会员不存在！";
	private static final String INVALID_COUPON= "此卡券无效！";

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Status trading(@RequestHeader(value = "posterKey", required = true) String key,
			@RequestBody TradingRequestJson json, HttpServletResponse response) {
		Trading trading = null;
		if (!key.equals(posterKey))
			return new Fail(KEY_REQUIRED);
		try {
			trading = tradingService.fromPoster(json);
		} catch(ShopNotExistException e) {
			return new Fail(SHOP_REQUIRED);
		} catch(MemberNotFoundException e) {
			return new Fail(MEMBER_REQUIRED);
		}
		
		//积分变化，发送微信模板消息（只针对于正常交易，不用做退货）
		if(!StringUtils.isEmpty(json.getMobile()) && trading.getScore()>0) {
			WechatTemplateMsgUtil.Verification verification = new WechatTemplateMsgUtil.Verification();
			verification.setMobile(json.getMobile());
			verification.setScore(trading.getScore());
			WechatTemplateMsgUtil.sendScoreMsg(verification, "a");
		}
		
		return new Success<>("success");
	}
	
	// 优惠券详情
	@RequestMapping(value = "/coupon", method = RequestMethod.GET)
	@ResponseBody
	public Status couponDtl(@RequestHeader(value = "posterKey", required = true) String key,
			@RequestParam("code") String code, @RequestParam("shopKey") String shopKey) {
		if (!key.equals(posterKey))
			return new Fail(KEY_REQUIRED);
		
		ShopCouponMember couponMember = shopCouponMemberService.findByCode(code);
		if(couponMember == null) {
			return new Fail(INVALID_COUPON);
		}
		CouponJson couponJson = couponMember.toCouponJson();
		List<CouponJson> list = new ArrayList<CouponJson>();
		list.add(couponJson);
		
		return new Success<>(new MemberCoupon(couponMember.getMember().getName(), list));
	}

	// 优惠券核销
	@RequestMapping(method = RequestMethod.PUT)
	@ResponseBody
	public Status useCoupon(@RequestHeader(value = "posterKey", required = true) String key,
			@RequestBody ShopCouponUseJson useCouponInfo) {
		if (!key.equals(posterKey))
			return new Fail(KEY_REQUIRED);
		String name = useCouponInfo.getMobile();
		String shopKey = useCouponInfo.getShopKey();
		Double profit = shopCouponMemberService.useCoupon(useCouponInfo.getCodes(), name, shopKey);
		
		//发送微信模板消息
		for(int i = 0; i < useCouponInfo.getCodes().length; i++) {
			WechatTemplateMsgUtil.Verification verification = new WechatTemplateMsgUtil.Verification();
			verification.setMobile(name);
			verification.setCode(useCouponInfo.getCodes()[i]);
			WechatTemplateMsgUtil.sendMsg(verification, "s");
		}
		
		ShopCouponMember scMember = shopCouponMemberService.findByCode(useCouponInfo.getCodes()[0]);
//		return new Success<>(profit);
		
		return new Success<>(scMember.getCoupon().getName());
	}

	@RequestMapping(value = "/member", method = RequestMethod.GET)
	@ResponseBody
	public Status find(@RequestHeader(value = "posterKey", required = true) String key,
			@RequestParam("mobile") String name, @RequestParam("shopKey") String shopKey) {
		if (!key.equals(posterKey))
			return new Fail(KEY_REQUIRED);
		Member member = memberService.findByName(name);
		if (member == null)
			return new Fail(MEMBER_REQUIRED);
		List<CouponJson> list = shopCouponMemberService.findByMemberAndShop(name, shopKey).stream()
				.map(i -> i.toCouponJson()).collect(Collectors.toList());
		return new Success<>(new MemberCoupon(name, list));
	}

	private class MemberCoupon {
		private String name;
		private List<CouponJson> lists;

		public MemberCoupon(String name, List<CouponJson> lists) {
			this.name = name;
			this.lists = lists;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public List<CouponJson> getLists() {
			return lists;
		}

		public void setLists(List<CouponJson> lists) {
			this.lists = lists;
		}
	}
}
