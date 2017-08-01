package com.by.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.by.model.Activity;
import com.by.model.ShopCoupon;

public interface OfflineActivityCouponRepository extends CrudRepository<Activity, Integer> {

	@Query("select t.coupon from OfflineActivityCoupon t where t.offlineActivity.id=:activityId and t.offlineActivity.status=:status and t.coupon.valid=1")
	List<ShopCoupon> findValidCouponByActivity(@Param("activityId") int activityId,@Param("status") int status);
	
}
