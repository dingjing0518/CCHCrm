package com.by.json;

/**
 * @author user 活动券json
 */
public class ActivityCouponJson {
	private String status;
	private String gift;

	public ActivityCouponJson() {

	}

	public ActivityCouponJson(String status, String gift) {
		super();
		this.status = status;
		this.gift = gift;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getGift() {
		return gift;
	}

	public void setGift(String gift) {
		this.gift = gift;
	}

}
