/**

 * @Title: ActivityController.java

 * @Package com.by.controller

 * @Description: TODO

 * Copyright: Copyright (c) 2016 

 * Company:Joymap

 * 

 * @author Carl

 * @date 2016年12月8日 下午2:19:58

 * @version V1.0

 */

package com.by.controller;

import static com.by.SpringExtension.SpringExtProvider;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.by.json.ActivityScoreJson;
import com.by.json.ExchangeCouponJson;
import com.by.model.*;
import com.by.service.ScoreHistoryService;
import com.by.typeEnum.ScoreHistoryEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.by.exception.Fail;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.ActivityCouponJson;
import com.by.json.ShopCouponJson;
import com.by.message.ShopCouponMessage;
import com.by.service.MemberService;
import com.by.service.OfflineActivityCouponService;
import com.by.service.ShopCouponMemberService;

import akka.actor.ActorRef;
import akka.actor.ActorSystem;
import akka.actor.Inbox;
import scala.concurrent.duration.Duration;

/**
 * 
 * @ClassName: ActivityController
 * 
 * @Description: TODO
 * 
 * @author Joymap-Carl
 * 
 * @date 2016年12月8日 下午2:19:58
 *
 * 
 */
@Controller
@RequestMapping(value = "/api/OfflineActivity")
public class OfflineActivityController implements UtilContoller {
	private ActorSystem system;
	private ActorRef ref;
	private final static int ON_LINE = 2;
	private final static int OFF_LINE = 3;
	private final static int GOOD = 4;

	private final static int ONLINE_GIFTONE_ID = 94;
	private final static int ONLINE_GIFTTWO_ID = 95;
	private final static int ONLINE_GIFTTHREE_ID = 96;

	private final static String RECEIVED = "2";
	private final static String RECEIVE = "3";
	private final static String OUT_OF_STOCK = "4";

	private final static String NO_GOOD = "0";
	private final static String ONLINE_GIFTONE = "1";
	private final static String ONLINE_GIFTTWO = "2";
	private final static String ONLINE_GIFTTHREE = "3";
	private final static String OFFLINE_GIFT = "4";
	private final static String GOOD_GIFT = "5";

	@Autowired
	private OfflineActivityCouponService service;
	@Autowired
	private ShopCouponMemberService scmService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ScoreHistoryService scoreHistoryService;

	/**
	 * 
	 * 
	 * 
	 * 创建一个新的实例 OfflineActivityController.
	 * 
	 * <p>
	 * Title:
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param system
	 * @param ref
	 * 
	 */

	@Autowired
	public OfflineActivityController(ApplicationContext ctx, ActorSystem system) {
		this.system = ctx.getBean(ActorSystem.class);
		this.ref = system.actorOf(SpringExtProvider.get(system).props("ActivityCouponActor"), "activityCouponActor");
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Status get(@PathVariable("id") int id, HttpServletRequest request) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);

		List<ShopCoupon> shopCoupons = service.findValidCouponByActivity(id, 1);

		List<ShopCoupon> shopCouponList = new ArrayList<ShopCoupon>();
		for (ShopCoupon sc : shopCoupons) {
			// 只记录有库存的店铺券
			if (!outOfStorage(sc, 1)) {
				shopCouponList.add(sc);
			}
		}

		if (shopCouponList != null && shopCouponList.size() > 0) {
			ShopCoupon sc = getRandomShopCoupon(shopCouponList);
			ShopCouponJson shopCouponJson = new ShopCouponJson(sc);

			// 发放卡券
			ShopCouponMessage message = new ShopCouponMessage(sc, member, 1);

			final Inbox inbox = Inbox.create(system);
			inbox.send(ref, message);
			try {
				String code = (String) inbox.receive(Duration.create(5, TimeUnit.SECONDS));
				if (code.equals("success"))
					return new Success<>(shopCouponJson);
				return new Fail(code);
			} catch (TimeoutException e) {
				e.printStackTrace();
				return new Fail("E002");
			}
		} else {
			// 卡券库存不足
			return new Fail("E001");
		}

	}

	/**
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/zc/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Status getZc(@PathVariable("id") int id, HttpServletRequest request) {
		int count = 0;
		ShopCoupon shopCoupon = null;
		if (id == ON_LINE) {
			Member member = (Member) request.getAttribute("member");
			member = memberService.findOneCache(member.getId());
			validMember(member);

			List<ShopCoupon> shopCoupons = service.findValidCouponByActivity(id, 1);
			// 活动未开启
			if (shopCoupons == null || shopCoupons.size() == 0) {
				return new Success<>(new ActivityCouponJson(OUT_OF_STOCK, NO_GOOD));
			}
			// 判断有无领过券
			for (ShopCoupon sc : shopCoupons) {
				
				List<ShopCouponMember> shopCouponMembers = scmService.findByCouponAndMember(sc, member);
				if (shopCouponMembers != null && shopCouponMembers.size() > 0) {
					count = sc.getId();
					break;
				}
			}

			if (count == ONLINE_GIFTONE_ID) {
				return new Success<>(new ActivityCouponJson(RECEIVED, ONLINE_GIFTONE));
			} else if (count == ONLINE_GIFTTWO_ID) {
				return new Success<>(new ActivityCouponJson(RECEIVED, ONLINE_GIFTTWO));
			} else if (count == ONLINE_GIFTTHREE_ID) {
				return new Success<>(new ActivityCouponJson(RECEIVED, ONLINE_GIFTTHREE));
			}

			List<ShopCoupon> shopCouponList = new ArrayList<ShopCoupon>();
			for (ShopCoupon sc : shopCoupons) {
				// 只记录有库存的店铺券
				if (!outOfStorage(sc, 1)) {
					shopCouponList.add(sc);
				}
			}
			if (shopCouponList != null && shopCouponList.size() > 0) {
				// 未领过有库存的
				shopCoupon = getRandomShopCoupon(shopCouponList);
				// 发放卡券
				ShopCouponMessage message = new ShopCouponMessage(shopCoupon, member, 1);

				final Inbox inbox = Inbox.create(system);
				inbox.send(ref, message);
				try {
					String code = (String) inbox.receive(Duration.create(5, TimeUnit.SECONDS));
					if (code.equals("success")) {
						if (shopCoupon.getId() == ONLINE_GIFTONE_ID) {
							return new Success<>(new ActivityCouponJson(RECEIVE, ONLINE_GIFTONE));
						} else if (shopCoupon.getId() == ONLINE_GIFTTWO_ID) {
							return new Success<>(new ActivityCouponJson(RECEIVE, ONLINE_GIFTTWO));
						} else if (shopCoupon.getId() == ONLINE_GIFTTHREE_ID) {
							return new Success<>(new ActivityCouponJson(RECEIVE, ONLINE_GIFTTHREE));
						}
					}
				} catch (TimeoutException e) {
					e.printStackTrace();
					if (shopCoupon.getId() == ONLINE_GIFTONE_ID) {
						return new Success<>(new ActivityCouponJson(RECEIVED, ONLINE_GIFTONE));
					} else if (shopCoupon.getId() == ONLINE_GIFTTWO_ID) {
						return new Success<>(new ActivityCouponJson(RECEIVED, ONLINE_GIFTTWO));
					} else if (shopCoupon.getId() == ONLINE_GIFTTHREE_ID) {
						return new Success<>(new ActivityCouponJson(RECEIVED, ONLINE_GIFTTHREE));
					}
				}
			} else {
				// 卡券库存不足
				return new Success<>(new ActivityCouponJson(OUT_OF_STOCK, NO_GOOD));
			}
		} else if (id == OFF_LINE) {
			Member member = (Member) request.getAttribute("member");
			member = memberService.findOneCache(member.getId());
			validMember(member);
			List<ShopCoupon> shopCoupons = service.findValidCouponByActivity(id, 1);
			// 活动未开启
			if (shopCoupons == null || shopCoupons.size() == 0) {
				return new Success<>(new ActivityCouponJson(OUT_OF_STOCK, NO_GOOD));
			}

			shopCoupon = shopCoupons.get(0);
			// 发放卡券
			ShopCouponMessage message = new ShopCouponMessage(shopCoupon, member, 1);
			final Inbox inbox = Inbox.create(system);
			inbox.send(ref, message);
			try {
				String code = (String) inbox.receive(Duration.create(5, TimeUnit.SECONDS));
				if (code.equals("success"))
					return new Success<>(new ActivityCouponJson(RECEIVE, OFFLINE_GIFT));
				return new Success<>(new ActivityCouponJson(RECEIVED, OFFLINE_GIFT));
			} catch (TimeoutException e) {
				e.printStackTrace();

				return new Success<>(new ActivityCouponJson(RECEIVED, OFFLINE_GIFT));
			}
		} else if (id == GOOD) {
			Member member = (Member) request.getAttribute("member");
			member = memberService.findOneCache(member.getId());
			validMember(member);
			List<ShopCoupon> shopCoupons = service.findValidCouponByActivity(id, 1);
			// 活动未开启
			if (shopCoupons == null || shopCoupons.size() == 0) {
				return new Success<>(new ActivityCouponJson(OUT_OF_STOCK, NO_GOOD));
			}
			// 已领取
			List<ShopCouponMember> shopCouponMembers = scmService.findByCouponAndMember(shopCoupons.get(0), member);
			if (shopCouponMembers != null && shopCouponMembers.size() > 0) {
				return new Success<>(new ActivityCouponJson(RECEIVED, GOOD_GIFT));
			}
			// 未领取
			List<ShopCoupon> shopCouponList = new ArrayList<ShopCoupon>();
			for (ShopCoupon sc : shopCoupons) {
				// 只记录有库存的店铺券
				if (!outOfStorage(sc, 1)) {
					shopCouponList.add(sc);
				}
			}
			if (shopCouponList != null && shopCouponList.size() > 0) {
				// 有库存
				shopCoupon = shopCoupons.get(0);
				// 发放卡券
				ShopCouponMessage message = new ShopCouponMessage(shopCoupon, member, 1);
				final Inbox inbox = Inbox.create(system);
				inbox.send(ref, message);
				try {
					String code = (String) inbox.receive(Duration.create(5, TimeUnit.SECONDS));
					if (code.equals("success"))
						return new Success<>(new ActivityCouponJson(RECEIVE, GOOD_GIFT));
					return new Success<>(new ActivityCouponJson(RECEIVED, GOOD_GIFT));
				} catch (TimeoutException e) {
					e.printStackTrace();
					return new Success<>(new ActivityCouponJson(RECEIVED, GOOD_GIFT));
				}
			} else {
				// 没库存
				return new Success<>(new ActivityCouponJson(OUT_OF_STOCK, NO_GOOD));
			}
		}
		return null;
	}
	@RequestMapping(value = "/answer", method = RequestMethod.POST)
	@ResponseBody
	public Status addScore( HttpServletRequest request,@Valid @RequestBody ActivityScoreJson json) {
		ScoreHistoryEnum type = null;
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);
		List<ScoreHistory> scoreHistorys=scoreHistoryService.findByMember(member);
		if(null!=scoreHistorys&&scoreHistorys.size()>0){
			for(ScoreHistory ScoreHistory:scoreHistorys){
				if(ScoreHistory.getType()== ScoreHistoryEnum.ANSWERADDSCORE){
					type=ScoreHistory.getType();
					break;
				}
			}
			if(type==ScoreHistoryEnum.ANSWERADDSCORE){
				json.setScore(1);
				return new Success<>(json);
			}else{
				memberService.addScore(member,json.getScore(),"答题积分",ScoreHistoryEnum.ANSWERADDSCORE,"","","System");
				json.setScore(0);
				return new Success<>(json);
			}
		}else{
			memberService.addScore(member,json.getScore(),"答题积分",ScoreHistoryEnum.ANSWERADDSCORE,"","","System");
			json.setScore(0);
			return new Success<>(json);
		}
	}

	/**
	 * 
	 * 
	 * outOfStorage(判断是否超出库存)
	 *
	 * 
	 * 
	 * @Title: outOfStorage
	 * 
	 * @Description: TODO
	 * 
	 * @param @param coupon @param @param count @param @return 设定文件
	 * 
	 * @return boolean 返回类型
	 * 
	 * @throws
	 */
	private boolean outOfStorage(ShopCoupon coupon, int count) {
		Long total = scmService.countByCoupon(coupon);
		if (total == null)
			total = new Long(0);
		return total.intValue() == coupon.getTotal() || total.intValue() + count > coupon.getTotal();
	}

	/**
	 * 
	 * 
	 * getRandomShopCoupon(随机获取一张店铺券)
	 *
	 * 
	 * 
	 * @Title: getRandomShopCoupon
	 * 
	 * @Description: TODO
	 * 
	 * @param @param shopCoupons @param @return 设定文件
	 * 
	 * @return ShopCoupon 返回类型
	 * 
	 * @throws
	 */
	private ShopCoupon getRandomShopCoupon(List<ShopCoupon> shopCoupons) {
		Random r = new Random();
		return shopCoupons.get(r.nextInt(shopCoupons.size()));
	}

}
