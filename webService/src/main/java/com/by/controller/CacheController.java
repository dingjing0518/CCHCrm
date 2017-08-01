package com.by.controller;

import com.by.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/cache")
public class CacheController {
	@Autowired
	private ParkingCouponService service;
	@Autowired
	private MemberService memberService;
	@Autowired
	private GiftCouponService giftCouponService;
	@Autowired
	private ShopCouponService shopCouponService;
	@Autowired
	private ShopRuleCacheService shopRuleCacheService;
	@Autowired
	private CardRuleCacheService cardRuleCacheService;
	@Autowired
	private ShopService shopService;
	@Autowired
	private MemberHelperService memberHelperService;
	@RequestMapping(value = "/parking", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshPakringActivate() {
		service.refresh();
	}

	@RequestMapping(value = "/parking/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshPakringCoupon(@PathVariable("id") int id) {
		service.refreshOne(id);
	}

	@RequestMapping(value = "/member/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshMember(@PathVariable("id") Long id) {
		memberService.refresh(id);
	}

	@RequestMapping(value = "/giftCoupon/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshGiftCoupon(@PathVariable("id") int id) {
		giftCouponService.refresh(id);
	}

	@RequestMapping(value = "/cardRule/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshCardRule(@PathVariable("id") int id) {
		cardRuleCacheService.refreshCache(id);
	}

	@RequestMapping(value = "/shopRule/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshShopRule(@PathVariable("id") int id) {
		shopRuleCacheService.refreshCache(id);
		shopService.refresh(new Sort(Sort.Direction.ASC, "name"));
	}

	@RequestMapping(value = "/shopCoupon/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshShopCoupon(@PathVariable("id") int id) {
		shopCouponService.refresh(id);
	}

	@RequestMapping(value = "/help/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public void refreshHelp(@PathVariable("id") int id) {
		memberHelperService.refresh(id);
	}
}
