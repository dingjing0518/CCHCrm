package com.by.repository;

import com.by.model.Member;
import com.by.model.ParkingCoupon;
import com.by.model.ParkingCouponDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by dingjing on 2017/2/13.
 */
public interface ParkingCouponDetailRepository extends PagingAndSortingRepository<ParkingCouponDetail, Integer> {
    List<ParkingCouponDetail> findByMemberAndCoupon(Member member, ParkingCoupon coupon);
    Page<ParkingCouponDetail> findByMember(Member member, Pageable pageable);
    List<ParkingCouponDetail> findByMember(Member member, Sort sort);
}
