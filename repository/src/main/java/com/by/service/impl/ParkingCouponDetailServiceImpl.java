package com.by.service.impl;


import com.by.exception.NotEnoughScoreException;
import com.by.exception.NotFoundException;
import com.by.exception.NotValidException;
import com.by.json.ParkingCouponDetailJson;
import com.by.json.ParkingPayHistoryJson;
import com.by.model.*;
import com.by.repository.ParkingCouponDetailRepository;
import com.by.service.MemberService;
import com.by.service.ParkingCouponDetailService;
import com.by.service.ParkingCouponExchangeHistoryService;
import com.by.typeEnum.ScoreHistoryEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by dingjing on 2017/2/13.
 */
@Service
public class ParkingCouponDetailServiceImpl implements ParkingCouponDetailService {
    @Autowired
    private EntityManager em;
    @Autowired
    private MemberService memberService;
    @Value(value = "${parkingCoupon.reason}")
    private String reason;
    @Autowired
    private ParkingCouponDetailRepository repository;
    @Override
    public void exchangeCoupon(Member member, ParkingCoupon coupon, int total) {
        Member m = em.find(Member.class, member.getId());
        ParkingCoupon sourceCoupon = em.find(ParkingCoupon.class, coupon.getId());
        if (sourceCoupon == null)
            throw new NotFoundException();
        if (m.getScore() < total * sourceCoupon.getScore())
            throw new NotEnoughScoreException();
        if (sourceCoupon.isValid() && sourceCoupon.isEffective(Calendar.getInstance())) {
            memberService.minusScore(m, sourceCoupon.getScore() * total, reason, ScoreHistoryEnum.COUPONEXCHANGE,"","","System");
            save(m, sourceCoupon, total);
        } else {
            throw new NotValidException();
        }
    }

    @Override
    public ParkingCouponDetail save(Member member, ParkingCoupon pc, int total) {
        List<ParkingCouponDetail> parkingCouponDetails=findByMemberAndCoupon(member,pc);
        ParkingCouponDetail pcd=new ParkingCouponDetail();
        pcd.setCoupon(pc);
        pcd.setMember(member);
        pcd.setExchangeAmount(total);
        pcd.setExchangeTime(Calendar.getInstance());
        Calendar calendar=Calendar.getInstance();
        calendar.add(Calendar.DATE,31);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        calendar.getTime();
        pcd.setInvalidTime(calendar);
        return save(pcd);
    }

    @Override
    public ParkingCouponDetail save(ParkingCouponDetail parkingCouponDetail) {
        return repository.save(parkingCouponDetail);
    }

    @Override
    public List<ParkingCouponDetail> findByMemberAndCoupon(Member member, ParkingCoupon coupon) {
        return repository.findByMemberAndCoupon(member, coupon);
    }

    @Override
    public Page<ParkingCouponDetailJson> toJson(Page<ParkingCouponDetail> lists, Pageable pageable) {
        List<ParkingCouponDetailJson> results = lists.getContent().stream().map(i -> new ParkingCouponDetailJson(i))
                .collect(Collectors.toList());
        return new PageImpl<>(results, pageable, lists.getTotalElements());
    }

    @Override
    public Page<ParkingCouponDetail> findByMember(Member member, Pageable pageable) {
        return repository.findByMember(member,pageable);
    }

    @Override
    public List<ParkingCouponDetail> findByMember(Member member,Sort sort) {
        Calendar today = Calendar.getInstance();
        return repository.findByMember(member,sort).stream().filter(i -> {
            if (i.getCoupon().isValid() && i.getCoupon().isBeforeCouponEndTime(today)&&i.getInvalidTime().after(today))
                return true;
            return false;
        }).collect(Collectors.toList());
    }
}
