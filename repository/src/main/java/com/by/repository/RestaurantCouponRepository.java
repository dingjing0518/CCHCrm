package com.by.repository;

import com.by.model.RejectedGoods;
import com.by.model.RestaurantCoupon;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by yvan on 2017/1/5.
 */
public interface RestaurantCouponRepository extends CrudRepository<RestaurantCoupon, Long> {
    Page<RestaurantCoupon> findByNameLikeOrderByCreatedTimeDesc(String name, Pageable pageable);

    Long countByName(String name);

    RestaurantCoupon findByName(String name);

    Long countByPhone(String phone);

    RestaurantCoupon findByPhone(String phone);
}
