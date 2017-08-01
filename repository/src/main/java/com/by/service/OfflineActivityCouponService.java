package com.by.service;

import java.util.List;

import com.by.model.ShopCoupon;

public interface OfflineActivityCouponService {
	List<ShopCoupon> findValidCouponByActivity(int activityId,int status);
		
}
