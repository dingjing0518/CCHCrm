package com.by.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.service.CardRuleCacheService;
import com.by.service.ShopRuleCacheService;
import com.by.service.model.Tuple2;

@Controller
@RequestMapping("/status")
public class TestController {
	@Autowired
	private ShopRuleCacheService shopRuleCacheService;
	@Autowired
	private CardRuleCacheService cardRuleCacheService;

//	@RequestMapping(value = "/shopRule/{id}", method = RequestMethod.GET)
//	@ResponseBody
//	public Tuple2<Double, Integer> shopRule(@PathVariable("id") int id) {
//		return shopRuleCacheService.getShopRateAndScore(id);
//	}
//
//	@RequestMapping(value = "/cardRule/{id}", method = RequestMethod.GET)
//	@ResponseBody
//	public Tuple2<Double, Integer> cardRule(@PathVariable("id") int id) {
//		return cardRuleCacheService.getCardRateAndScore(id);
//	}
}
