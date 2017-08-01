package com.by.controller;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.DailyParkScoreUseJson;
import com.by.json.LicenseJson;
import com.by.json.ParkingConfirmJson;
import com.by.model.License;
import com.by.model.Member;
import com.by.model.VehicleEntrance;
import com.by.service.*;
import com.by.typeEnum.ScoreHistoryEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Created by yagamai on 16-2-5.
 */
@Controller
@RequestMapping("/api/parking")
public class ParkingController implements UtilContoller {
	@Autowired
	private ParkingCouponMemberService parkingCouponMemberService;
	@Autowired
	private ParkingCouponDetailService parkingCouponDetailService;
	@Autowired
	private ScoreHistoryService scoreHistoryService;
	@Autowired
	private ParkingPayHistoryService parkingPayHistoryService;
	@Autowired
	private MemberService memberService;

	@Autowired
	private ParkingCouponService parkingCouponService;
	private static Logger log = LoggerFactory.getLogger(ParkingController.class);

	@RequestMapping(value = "/{carNum}",method = RequestMethod.GET)
	@ResponseBody
	public Status list(HttpServletRequest request, @PathVariable("carNum") String carNum) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);
		member = memberService.findOne(member.getId());

		int dailyParkScoreUse = 0;
		List<Object[]> dailyParkScoreUseJsonList = scoreHistoryService.findParkExchangeDepositeToday(member);
		for (Object[] dailyParkScoreUseJson:
				dailyParkScoreUseJsonList) {
			if(carNum.equalsIgnoreCase((String)dailyParkScoreUseJson[1])) {
				dailyParkScoreUse = Integer.parseInt(String.valueOf(dailyParkScoreUseJson[0]));
				break;
			}
		}

		return new Success<>(new ParkingInfo(member.getScore(), dailyParkScoreUse));
//		//当天有效的卡券
//		List<ParkingCouponDetail> parkingCouponDetails=parkingCouponDetailService.findByMember(member,new Sort(Sort.Direction.ASC,"invalidTime"));
//		//车牌当天用券信息
//		Object[] data = null;
//		List<ParkCouponUseToday> parkCouponUseTodays=new ArrayList<ParkCouponUseToday>();
//		ParkCouponUseToday parkCouponUseToday=new ParkCouponUseToday();
//		List<Object[]> lists=parkingPayHistoryService.findByCarNameAndMemberAndToday(member);
//		for(int i=0;i<lists.size();i++){
//			data=lists.get(i);
//			if((Integer)(data[0])/5<4){
//				parkCouponUseToday.setCount((Integer)(data[0])/5);
//				parkCouponUseToday.setLicense((String) data[1]);
//				parkCouponUseTodays.add(parkCouponUseToday);
//			};
//
//		}
//		Optional<Integer> totalOp = parkingCouponDetails.stream().map(i -> i.getExchangeAmount()).reduce((i, s) -> i + s);
//		ParkingCoupon coupon = parkingCouponService.findActivate();
//		int score = member.getScore();
//		List<String> licenses = member.getLicenses().stream().map(i -> i.getName()).collect(Collectors.toList());
//
//		//返回会员支付车牌当天使用的卡券数量清单
//
//
//		return new Success<>(new ParkingInfo(totalOp, coupon.getAmount(), score, coupon.getId(), coupon.getScore(), licenses,parkCouponUseTodays));
	}

	@RequestMapping(value = "/license",method = RequestMethod.GET)
	@ResponseBody
	public Status licenseList(HttpServletRequest request) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOneCache(member.getId());
		validMember(member);
		member = memberService.findOne(member.getId());
		List<String> licenses = member.getLicenses().stream().map(i -> i.getName()).collect(Collectors.toList());

		return new Success<>(new ParkingInfo(licenses));
	}

	@RequestMapping(method = RequestMethod.PUT)
	@ResponseBody
	public Status parkHistory(HttpServletRequest request,@RequestBody LicenseJson json) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOne(member.getId());

		String param = json.getLicenseName().toUpperCase();

		License license = new License();

		List<License> licenseList = new ArrayList<License>();
		List<License> originalLicenses = member.getLicenses();

		if(originalLicenses != null && originalLicenses.size() > 0) {
			licenseList = originalLicenses;
			if(!originalLicenses.contains(new License(param))) {
				license.setName(param);
				licenseList.add(license);
			}
		} else {
			license.setName(param);
			licenseList.add(license);
		}

		member.setLicenses(licenseList);

		memberService.save(member);

		return new Success<>(param);
	}

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Status parking(@RequestBody VehicleEntrance info) {
		// todo
		return null;
	}


	@RequestMapping(value = "/exchange",method = RequestMethod.POST)
	@ResponseBody
	public Status parkHistory(HttpServletRequest request,@RequestBody DailyParkScoreUseJson json) {
		Member member = (Member) request.getAttribute("member");
		member = memberService.findOne(member.getId());
		memberService.minusScore(member,json.getScore(),"停车券兑换", ScoreHistoryEnum.PARKINGEXCHANGE, json.getLicense().toUpperCase(),"","System");
		return new Success<>("success");
	}

	@RequestMapping(value="/parkConfirm", method = RequestMethod.PUT)
	@ResponseBody
	@Transactional
	public Status parkConfirm(HttpServletRequest request, @RequestBody ParkingConfirmJson json) {

		Member member = (Member) request.getAttribute("member");
		member = memberService.findOne(member.getId());

		//积分兑换停车费
		memberService.minusScore(member,json.getScore(),"停车券兑换", ScoreHistoryEnum.PARKINGEXCHANGE, json.getCarNumber().toUpperCase(),"","System");

		//绑定车牌
		String param = json.getCarNumber().toUpperCase();

		License license = new License();

		List<License> licenseList = new ArrayList<License>();
		List<License> originalLicenses = member.getLicenses();

		if(originalLicenses != null && originalLicenses.size() > 0) {
			licenseList = originalLicenses;
			if(!originalLicenses.contains(new License(param))) {
				license.setName(param);
				licenseList.add(license);
			}
		} else {
			license.setName(param);
			licenseList.add(license);
		}
		member.setLicenses(licenseList);
		memberService.save(member);

		//记录缴费信息
		json.setMember(member.getId());
		parkingPayHistoryService.save(json);

		return new Success<>("success");
	}

	private class ParkingInfo {
		// 停车券张数
		private int total;
		// 应缴停车费
		private double charge;
		// 可用积分
		private int score;
		// 停车券Id
		private int id;
		// 停车券积分
		private int couponScore;
		private List<String> licenses;
		private int dailyParkScoreUse;

		public ParkingInfo() {
		}

		public ParkingInfo(Optional<Integer> total, double charge, int score, int id, int couponScore,
				List<String> licenses) {
			if (total.isPresent())
				this.total = total.get();
			else
				this.total = 0;
			this.charge = charge;
			this.score = score;
			this.id = id;
			this.couponScore = couponScore;
			this.licenses = licenses;
		}

		public ParkingInfo(List<String> licenses) {
			this.licenses = licenses;
		}

		public ParkingInfo(int score, int dailyParkScoreUse) {
			this.score = score;
			this.dailyParkScoreUse = dailyParkScoreUse;
		}

		public int getTotal() {
			return total;
		}

		public void setTotal(int total) {
			this.total = total;
		}

		public double getCharge() {
			return charge;
		}

		public void setCharge(double charge) {
			this.charge = charge;
		}

		public int getScore() {
			return score;
		}

		public void setScore(int score) {
			this.score = score;
		}

		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public int getCouponScore() {
			return couponScore;
		}

		public void setCouponScore(int couponScore) {
			this.couponScore = couponScore;
		}

		public List<String> getLicenses() {
			return licenses;
		}

		public void setLicenses(List<String> licenses) {
			this.licenses = licenses;
		}

		public int getDailyParkScoreUse() {
			return dailyParkScoreUse;
		}

		public void setDailyParkScoreUse(int dailyParkScoreUse) {
			this.dailyParkScoreUse = dailyParkScoreUse;
		}
	}

	/**
	 * 车辆当天使用停车券结果
	 */
	private class ParkCouponUseToday {
		private String license;
		private int count;

		public String getLicense() {
			return license;
		}

		public void setLicense(String license) {
			this.license = license;
		}

		public int getCount() {
			return count;
		}

		public void setCount(int count) {
			this.count = count;
		}
	}

}
