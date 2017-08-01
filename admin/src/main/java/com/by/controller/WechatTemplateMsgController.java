/**

 * @Title: WechatController.java

 * @Package com.by.controller

 * @Description: TODO

 * Copyright: Copyright (c) 2016 

 * Company:Joymap

 * 

 * @author Carl

 * @date 2016年5月17日 上午11:11:05

 * @version V1.0

 */



package com.by.controller;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.by.controller.AdminGiftCouponMemberController.Verification;
import com.by.model.GiftCouponMember;
import com.by.model.ShopCouponMember;
import com.by.service.GiftCouponMemberService;
import com.by.service.ShopCouponMemberService;
import com.by.utils.DateUtil;

@Controller
@RequestMapping("/msg")
public class WechatTemplateMsgController {
	
	@Autowired
	private GiftCouponMemberService giftCouponMemberService;
	
	@Autowired
	private ShopCouponMemberService shopCouponMemberService;
	
	/**
	 * 进行请求
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(method = RequestMethod.PUT,value = "/coupon/{type}")
	@ResponseBody
	public void sendMsg(@RequestBody Verification info,@PathVariable String type, HttpServletResponse response,ModelMap map) throws IOException {
		//获取卡券信息
		String mobile = info.getMobile();
		String code = info.getCode();
		String data = "{\"first\":{\"value\":\"#TITLE#\",\"color\":\"#c00\"},\"keyword1\":{\"value\":\"#COUPON_NAME#\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"#COUNT#张\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"#TIME#\",\"color\":\"#173177\"},\"remark\":{\"value\":\"#REMARK#\",\"color\":\"#173177\"}}";
		String title = "卡券核销成功！";
		String time = DateUtil.getDate(new Date(), DateUtil.DATE_TIME_FORMAT);
		switch(type) {
			case "g":
				GiftCouponMember giftCouponMember = giftCouponMemberService.findByCode(code);
				data = data.replace("#TITLE#", title);
				data = data.replace("#COUPON_NAME#", giftCouponMember.getCoupon().getName());
				data = data.replace("#COUNT#", "1");
				data = data.replace("#TIME#", time);
				data = data.replace("#REMARK#", "如有问题请联系服务台，或拨打客服电话021-31778100");
				break;
			case "s":
				ShopCouponMember shopCouponMember = shopCouponMemberService.findByCode(code);
				data = data.replace("#TITLE#", title);
				data = data.replace("#COUPON_NAME#", shopCouponMember.getCoupon().getName());
				data = data.replace("#COUNT#", "1");
				data = data.replace("#TIME#", time);
				data = data.replace("#REMARK#", "如有问题请联系服务台，或拨打客服电话021-31778100");
				break;
		}
		
		RestTemplate restTemplate = new RestTemplate(); 
		restTemplate.getMessageConverters()
        .add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		JSONObject param = new JSONObject();
		param.put("mobile", mobile);
		param.put("template_id", "dJBlJ1emi-9cNDVjrBrWBUNKxST_EVnJ-AFOoZ6Js8E");
//		String data = "{\"first\":{\"value\":\"您的停车券核销成功！\",\"color\":\"#c00\"},\"keyword1\":{\"value\":\"5元停车券\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"1张\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"2015-08-03 15:00:00\",\"color\":\"#173177\"},\"remark\":{\"value\":\"如有问题请联系服务台，或拨打客服电话400-820-6503\",\"color\":\"#173177\"}}";
		param.put("data",  data);
		String url="http://cch.joymap.cn/cch/index.php?s=/wechat/user/WxTmpInfo";

		// set headers
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<String> entity = new HttpEntity<String>(param.toString(), headers);

		// send request and parse result
		ResponseEntity<String> responseValue = restTemplate
		  .exchange(url, HttpMethod.POST, entity, String.class);
		if (responseValue.getStatusCode() == HttpStatus.OK) {
			JSONObject json = new JSONObject(responseValue.getBody());
			response.getWriter().println(json.get("msg"));
		}  else {
			JSONObject json = new JSONObject(responseValue.getBody());
			response.getWriter().println(json.get("msg"));
		}
	}
}