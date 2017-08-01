package com.by.service.impl;

import com.by.json.RestaurantCouponJson;
import com.by.model.RestaurantCoupon;
import com.by.repository.RestaurantCouponRepository;
import com.by.service.RestaurantCouponService;
import com.by.utils.LocalBeanUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by yvan on 2017/1/5.
 */
@Service
@Transactional
public class RestaurantCouponServiceImpl implements RestaurantCouponService {

    @Autowired
    RestaurantCouponRepository restaurantCouponRepository;

    @Override
    public Page<RestaurantCoupon> findAll(String name, Pageable pageable) {
        name = (null == name || name.equals("")) ? "%%" : "%" + name + "%";
        return restaurantCouponRepository.findByNameLikeOrderByCreatedTimeDesc(name, pageable);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<RestaurantCouponJson> findAllJson(String name, Pageable pageable) {
        Page<RestaurantCoupon> pages = findAll(name, pageable);
        List<RestaurantCouponJson> jsons = pages.getContent().stream().map(i -> i.toJson()).collect(Collectors.toList());
        return new PageImpl<>(jsons, pageable, pages.getTotalElements());
    }

    @Override
    public RestaurantCoupon findOne(Long id) {
        return restaurantCouponRepository.findOne(id);
    }

    @Override
    public RestaurantCoupon update(RestaurantCoupon restaurantCoupon) {
        RestaurantCoupon coupon = restaurantCouponRepository.findOne(restaurantCoupon.getId());
        BeanUtils.copyProperties(restaurantCoupon, coupon, LocalBeanUtils.getNullPropertyNames(restaurantCoupon));
        return coupon;
    }

    @Override
    public RestaurantCoupon save(RestaurantCoupon restaurantCoupon) {
        return restaurantCouponRepository.save(restaurantCoupon);
    }

    @Override
    public Long countByName(String name) {
        return restaurantCouponRepository.countByName(name);
    }

    @Override
    public RestaurantCoupon findByName(String name) {
        return restaurantCouponRepository.findByName(name);
    }

    @Override
    public Long countByPhone(String phone) {
        return restaurantCouponRepository.countByPhone(phone);
    }

    @Override
    public RestaurantCoupon findByPhone(String phone) {
        return restaurantCouponRepository.findByPhone(phone);
    }

}
