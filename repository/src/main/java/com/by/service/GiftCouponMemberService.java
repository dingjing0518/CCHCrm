package com.by.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.by.json.CouponMemberJson;
import com.by.model.GiftCoupon;
import com.by.model.GiftCouponMember;
import com.by.model.Member;
import com.by.typeEnum.ValidEnum;

/**
 * Created by yagamai on 15-12-3.
 */
public interface GiftCouponMemberService {
	GiftCouponMember useCoupon(String code, Member member);

	void exchangeCoupon(GiftCoupon coupon, Member member, int total);

	List<GiftCouponMember> findByCouponAndMember(GiftCoupon coupon, Member member);
	
	GiftCouponMember findByCode(String code);
	
	GiftCouponMember findByCodeAndValid(String code);

	Long sumTotalGroupByCoupon(GiftCoupon coupon);

	Page<CouponMemberJson> findByMember(Member member, Pageable pageable);

	Page<CouponMemberJson> findByMember(String mobile, Pageable pageable);

	GiftCouponMember useCoupon(String code, String name);
}
