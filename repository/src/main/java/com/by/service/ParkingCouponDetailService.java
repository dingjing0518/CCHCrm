package com.by.service;

import com.by.json.ParkingCouponDetailJson;
import com.by.model.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.List;

/**
 * Created by dingjing on 2017/2/13.
 */
public interface ParkingCouponDetailService {
    void exchangeCoupon(Member member, ParkingCoupon coupon, int total);
    ParkingCouponDetail save(Member member, ParkingCoupon pc, int total);
    ParkingCouponDetail save(ParkingCouponDetail parkingCouponDetail);
    List<ParkingCouponDetail> findByMemberAndCoupon(Member member, ParkingCoupon coupon);
    Page<ParkingCouponDetailJson> toJson(Page<ParkingCouponDetail> lists, Pageable pageable);
    Page<ParkingCouponDetail> findByMember(Member member, Pageable pageable);
    List<ParkingCouponDetail>findByMember(Member member,Sort sort);
}
