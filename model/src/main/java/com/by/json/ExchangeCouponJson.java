package com.by.json;

public class ExchangeCouponJson {
	//需要兑换的coupon id
	private int id;
	//密码
	private String password;
	//兑换数量
	private int total;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
}
