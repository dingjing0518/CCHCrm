package com.by.service;

import com.by.json.RestaurantCouponJson;
import com.by.json.ShopJson;
import com.by.model.RestaurantCoupon;
import com.by.model.Shop;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Created by yvan on 2017/1/5.
 */
public interface RestaurantCouponService {
    Page<RestaurantCoupon> findAll(String name, Pageable pageable);

    Page<RestaurantCouponJson> findAllJson(String name, Pageable pageable);

    RestaurantCoupon findOne(Long id);

    RestaurantCoupon update(RestaurantCoupon restaurantCoupon);

    RestaurantCoupon save(RestaurantCoupon restaurantCoupon);

    Long countByName(String name);

    RestaurantCoupon findByName(String name);

    Long countByPhone(String phone);

    RestaurantCoupon findByPhone(String phone);
}
