package com.by.repository;

import java.util.Calendar;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.by.model.Member;
import com.by.model.MemberCouponId;
import com.by.model.ParkingCoupon;
import com.by.model.ParkingCouponMember;
import com.by.typeEnum.ValidEnum;

public interface ParkingCouponMemberRepository extends PagingAndSortingRepository<ParkingCouponMember, MemberCouponId> {
    Page<ParkingCouponMember> findByMember(Member member, Pageable pageable);

    ParkingCouponMember findByMemberAndCoupon(Member member, ParkingCoupon coupon);

    List<ParkingCouponMember> findByMember(Member member, Sort sort);

    @Query("select p from ParkingCouponMember p where p.member=:member order by p.coupon.couponEndTime asc NULLS LAST")
    List<ParkingCouponMember> findByMember(@Param("member") Member member);
    
    @Query("select pc from ParkingCouponMember pc where pc.member=:member and pc.coupon.valid=:valid and ((:today<pc.coupon.couponEndTime) or (pc.coupon.couponEndTime is null)) order by pc.coupon.couponEndTime")
    Page<ParkingCouponMember> findByMemberAndValidPageable(@Param("member") Member member, @Param("valid") ValidEnum valid, @Param("today") Calendar today,Pageable pageable);
}
