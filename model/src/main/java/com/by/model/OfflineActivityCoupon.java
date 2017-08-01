/**

 * @Title: OfflineActivityCoupon.java

 * @Package com.by.model

 * @Description: TODO

 * Copyright: Copyright (c) 2016 

 * Company:Joymap

 * 

 * @author Carl

 * @date 2016年12月12日 上午10:59:30

 * @version V1.0

 */

package com.by.model;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 
 * @ClassName: OfflineActivityCoupon
 * 
 * @Description: TODO
 * 
 * @author Joymap-Carl
 * 
 * @date 2016年12月12日 上午10:59:30
 *
 * 
 * 
 * 
 */
@Entity
@Table(name = "by_offline_activity_coupon")
public class OfflineActivityCoupon {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "activity_id")
	private OfflineActivity offlineActivity;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "shop_coupon_id")
	private ShopCoupon coupon;

	/**
	 * 
	 * getter method
	 * 
	 * @return the id
	 * 
	 */

	public int getId() {
		return id;
	}

	/**
	 * 
	 * setter method
	 * 
	 * @param id
	 *            the id to set
	 * 
	 */

	public void setId(int id) {
		this.id = id;
	}

	/**
	 * 
	 * getter method
	 * 
	 * @return the offlineActivity
	 * 
	 */

	public OfflineActivity getOfflineActivity() {
		return offlineActivity;
	}

	/**
	 * 
	 * setter method
	 * 
	 * @param offlineActivity
	 *            the offlineActivity to set
	 * 
	 */

	public void setOfflineActivity(OfflineActivity offlineActivity) {
		this.offlineActivity = offlineActivity;
	}

	/**
	 * 
	 * getter method
	 * 
	 * @return the coupon
	 * 
	 */

	public ShopCoupon getCoupon() {
		return coupon;
	}

	/**
	 * 
	 * setter method
	 * 
	 * @param coupon
	 *            the coupon to set
	 * 
	 */

	public void setCoupon(ShopCoupon coupon) {
		this.coupon = coupon;
	}

}
