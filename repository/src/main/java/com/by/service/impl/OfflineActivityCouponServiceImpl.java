package com.by.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.by.model.ShopCoupon;
import com.by.repository.OfflineActivityCouponRepository;
import com.by.service.OfflineActivityCouponService;

@Service
@Transactional
public class OfflineActivityCouponServiceImpl implements OfflineActivityCouponService {
	@Autowired
	private OfflineActivityCouponRepository repository;
	
	@Override
	public List<ShopCoupon> findValidCouponByActivity(int activityId, int status) {
		return repository.findValidCouponByActivity(activityId, status);
	}
	
	
}
