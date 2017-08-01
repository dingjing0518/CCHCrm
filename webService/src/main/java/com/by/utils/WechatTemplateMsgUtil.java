/**

 * @Title: WechatTemplateMsgUtil.java

 * @Package com.by.utils

 * @Description: TODO

 * Copyright: Copyright (c) 2016 

 * Company:Joymap

 * 

 * @author Carl

 * @date 2016年8月28日 上午10:45:53

 * @version V1.0

 */



package com.by.utils;

import java.nio.charset.Charset;
import java.util.Date;

import javax.annotation.PostConstruct;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.by.model.GiftCouponMember;
import com.by.model.Member;
import com.by.model.ShopCouponMember;
import com.by.service.GiftCouponMemberService;
import com.by.service.MemberService;
import com.by.service.ShopCouponMemberService;

/**

  * @ClassName: WechatTemplateMsgUtil

  * @Description: TODO

  * @author Comsys-Carl

  * @date 2016年8月28日 上午10:45:53

  *


  */
@Component
public class WechatTemplateMsgUtil {
	
	@Autowired
	private GiftCouponMemberService giftCouponService;
	public static GiftCouponMemberService giftCouponMemberService;
	
	@Autowired
	private  ShopCouponMemberService shopCouponService;
	public static ShopCouponMemberService shopCouponMemberService;
	
	@Autowired
	private MemberService mService;
	public static MemberService memberService;
	
	@PostConstruct
	public void init() {
		WechatTemplateMsgUtil.giftCouponMemberService  = giftCouponService;
		WechatTemplateMsgUtil.shopCouponMemberService = shopCouponService;
		WechatTemplateMsgUtil.memberService = mService;
	}
	
	//发送卡券核销模板消息
	public static void sendMsg(Verification info, String msgType) {
		//获取卡券信息
				String mobile = info.getMobile();
				String code = info.getCode();
				String data = "{\"first\":{\"value\":\"#TITLE#\",\"color\":\"#c00\"},\"keyword1\":{\"value\":\"#COUPON_NAME#\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"#COUNT#张\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"#TIME#\",\"color\":\"#173177\"},\"remark\":{\"value\":\"#REMARK#\",\"color\":\"#173177\"}}";
				String title = "卡券核销成功！";
				String time = DateUtil.getDate(new Date(), DateUtil.DATE_TIME_24HR_FORMAT);
				switch(msgType) {
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
//				String data = "{\"first\":{\"value\":\"您的停车券核销成功！\",\"color\":\"#c00\"},\"keyword1\":{\"value\":\"5元停车券\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"1张\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"2015-08-03 15:00:00\",\"color\":\"#173177\"},\"remark\":{\"value\":\"如有问题请联系服务台，或拨打客服电话400-820-6503\",\"color\":\"#173177\"}}";
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
				}  else {
					JSONObject json = new JSONObject(responseValue.getBody());
				}
	}
	
	//发送积分变动模板消息
	public static void sendScoreMsg(Verification info, String msgType) {
		String mobile = info.getMobile();
		Member m = memberService.findByName(mobile);
		String data = "{\"first\":{\"value\":\"#TITLE#\",\"color\":\"#c00\"},\"keyword1\":{\"value\":\"#RECEIVE_TIME#\",\"color\":\"#173177\"},\"keyword2\":{\"value\":\"#SCORE#\",\"color\":\"#173177\"},\"keyword3\":{\"value\":\"#RECEIVE_REASON#\",\"color\":\"#173177\"},\"keyword4\":{\"value\":\"#CURRENT_SCORE#\",\"color\":\"#173177\"},\"remark\":{\"value\":\"#REMARK#\",\"color\":\"#173177\"}}";
		String title = "积分变动提醒！";
		String time = DateUtil.getDate(new Date(), DateUtil.DATE_TIME_24HR_FORMAT);
		switch(msgType) {
			case "a":
				data = data.replace("#TITLE#", title);
				data = data.replace("#RECEIVE_TIME#", time);
				data = data.replace("#SCORE#", String.valueOf(info.getScore()));
				data = data.replace("#RECEIVE_REASON#", "消费");
				data = data.replace("#CURRENT_SCORE#", String.valueOf(m.getScore()));
				data = data.replace("#REMARK#", "如有问题请联系服务台，或拨打客服电话021-31778100");
				break;
			case "m":
				data = data.replace("#TITLE#", title);
				data = data.replace("#RECEIVE_TIME#", time);
				data = data.replace("#SCORE#", String.valueOf(info.getScore()));
				data = data.replace("#RECEIVE_REASON#", "人工积分");
				data = data.replace("#CURRENT_SCORE#", String.valueOf(m.getScore()));
				data = data.replace("#REMARK#", "如有问题请联系服务台，或拨打客服电话021-31778100");
				break;
			case "r":
				data = data.replace("#TITLE#", title);
				data = data.replace("#RECEIVE_TIME#", time);
				data = data.replace("#SCORE#", String.valueOf(info.getScore()));
				data = data.replace("#RECEIVE_REASON#", "退积分");
				data = data.replace("#CURRENT_SCORE#", String.valueOf(m.getScore()));
				data = data.replace("#REMARK#", "如有问题请联系服务台，或拨打客服电话021-31778100");
				break;
		}
		
		RestTemplate restTemplate = new RestTemplate(); 
		restTemplate.getMessageConverters()
        .add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		JSONObject param = new JSONObject();
		param.put("mobile", mobile);
		param.put("template_id", "XsaA_VjZ0wMSdXZOX46jMruJvKygNxoZlEhqDcpcFxY");
		param.put("data",  data);
		String url="http://crm.jq-taimall.com/cch/index.php?s=/wechat/user/WxTmpInfo";

		// set headers
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<String> entity = new HttpEntity<String>(param.toString(), headers);

		// send request and parse result
		ResponseEntity<String> responseValue = restTemplate
		  .exchange(url, HttpMethod.POST, entity, String.class);
		if (responseValue.getStatusCode() == HttpStatus.OK) {
			JSONObject json = new JSONObject(responseValue.getBody());
		}  else {
			JSONObject json = new JSONObject(responseValue.getBody());
		}
	}
	
	public static class Verification {
		private String mobile;
		private String code;
		private Integer score;

		public String getMobile() {
			return mobile;
		}

		public void setMobile(String mobile) {
			this.mobile = mobile;
		}

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}

		public Integer getScore() {
			return score;
		}

		public void setScore(Integer score) {
			this.score = score;
		}
			
	}
}
