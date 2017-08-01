package com.by.controller;

import com.by.exception.Fail;
import com.by.exception.NotFoundException;
import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.*;
import com.by.model.Member;
import com.by.model.ParkingCoupon;
import com.by.model.ParkingCouponDetail;
import com.by.model.ParkingCouponMember;
import com.by.service.MemberService;
import com.by.service.ParkingCouponDetailService;
import com.by.service.ParkingCouponMemberService;
import com.by.service.ParkingCouponService;
import com.by.utils.FailBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

/**
 * Created by yagamai on 15-12-3.
 */
@Controller
@RequestMapping(value = "/api/parkingCoupons")
public class ParkingCouponController implements UtilContoller {
    private ParkingCouponService service;
    private MemberService memberService;
    private ShaPasswordEncoder passwordEncoder;
    private ParkingCouponMemberService parkingCouponMemberService;
    private MessageSource messageSource;
    private ParkingCouponDetailService parkingCouponDetailService;
    @Autowired
    public ParkingCouponController(ParkingCouponService parkingCouponService, ShaPasswordEncoder passwordEncoder,
                                   MemberService memberService, ParkingCouponMemberService parkingCouponMemberService,
                                   MessageSource messageSource,ParkingCouponDetailService parkingCouponDetailService) {
        this.service = parkingCouponService;
        this.memberService = memberService;
        this.passwordEncoder = passwordEncoder;
        this.parkingCouponMemberService = parkingCouponMemberService;
        this.messageSource = messageSource;
        this.parkingCouponDetailService=parkingCouponDetailService;
    }

    /*
     * @param exchangecouponjson id,password,total 兑换停车券---弃用
     */
    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public Status exchangeParkingCoupon(HttpServletRequest request, @Valid @RequestBody ExchangeCouponJson json,
                                        BindingResult result) {
        Member m = (Member) request.getAttribute("member");
        Member member = memberService.findOneCache(m.getId());
        validMember(member);
        if (member.getMemberDetail().getPassword() != null) {
            if (StringUtils.isEmpty(json.getPassword())) {
                return new Fail(messageSource.getMessage("password.need", new Object[]{}, Locale.CHINESE));
            }
        }
        if (!StringUtils.isEmpty(json.getPassword()) && member.getMemberDetail().getPassword() != null) {
            if (!passwordEncoder.encodePassword(json.getPassword(), null)
                    .equals(member.getMemberDetail().getPassword())) {
                return new Fail(messageSource.getMessage("password.notCorrect", new Object[]{}, Locale.CHINESE));
            }
        }
        if (result.hasErrors()) {
            return FailBuilder.buildFail(result);
        }
        ParkingCoupon coupon = new ParkingCoupon(json.getId());
        service.exchangeCoupon(member, coupon, json.getTotal());
        return new Status("success");
    }

    /*
     * @param usecouponjson total password license 使用停车券
     */
    @RequestMapping(method = RequestMethod.POST, value = "/delete")
    @ResponseBody
    public Status useCoupon(HttpServletRequest request, @RequestBody UseCouponJson json, BindingResult result) {
        Member m = (Member) request.getAttribute("member");
        Member member = memberService.findOneCache(m.getId());
        validMember(member);
        if (result.hasErrors()) {
            return FailBuilder.buildFail(result);
        }
        service.useCoupon(member, json.getTotal(), json.getLicense());
        return new Status("success");
    }

    // 可以兑换的停车券模板列表
    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public Status list(HttpServletRequest request) {
        Member member = (Member) request.getAttribute("member");
        member = memberService.findOneCache(member.getId());
        validMember(member);
        ParkingCoupon parkingCoupon = service.findActivate();
        if (parkingCoupon == null)
            return new Fail(messageSource.getMessage("coupon.empty", new Object[]{}, Locale.CHINA));
        return new Success<>(new CouponJson(parkingCoupon));
    }

    // 用户兑换到的停车券数量
    @RequestMapping(value = "/member", method = RequestMethod.GET)
    @ResponseBody
    public Status couponList(HttpServletRequest request) {
        Member m = (Member) request.getAttribute("member");
        Member member = memberService.findOneCache(m.getId());
        validMember(member);
        List<ParkingCouponMember> list = parkingCouponMemberService.findByMember(member,
                new Sort(Direction.DESC, "total"));
        List<ParkingCouponMemberJson> results = list.stream().map(i -> new ParkingCouponMemberJson(i))
                .collect(Collectors.toList());
        return new Success<>(results);
    }

    // 停车券详情
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Status detail(HttpServletRequest request, @PathVariable("id") int id) {
        ParkingCoupon coupon = service.findOneCache(id);
        Member m = (Member) request.getAttribute("member");
        Member member = memberService.findOneCache(m.getId());
        validMember(member);
        if (coupon == null)
            throw new NotFoundException();
        return new Success<>(new CouponTemplateJson(coupon));
    }
    /*
     * @param exchangecouponjson id,password,total
     */
    @RequestMapping(value ="/parkingCouponDetail",method = RequestMethod.POST)
    @ResponseBody
    public Status parkingCouponDetail(HttpServletRequest request, @Valid @RequestBody ExchangeCouponJson json,
                                      BindingResult result) {
        Member m = (Member) request.getAttribute("member");
        Member member = memberService.findOneCache(m.getId());
        validMember(member);
        if (member.getMemberDetail().getPassword() != null) {
            if (StringUtils.isEmpty(json.getPassword())) {
                return new Fail(messageSource.getMessage("password.need", new Object[]{}, Locale.CHINESE));
            }
        }
        if (!StringUtils.isEmpty(json.getPassword()) && member.getMemberDetail().getPassword() != null) {
            if (!passwordEncoder.encodePassword(json.getPassword(), null)
                    .equals(member.getMemberDetail().getPassword())) {
                return new Fail(messageSource.getMessage("password.notCorrect", new Object[]{}, Locale.CHINESE));
            }
        }
        if (result.hasErrors()) {
            return FailBuilder.buildFail(result);
        }
        ParkingCoupon coupon = new ParkingCoupon(json.getId());
        parkingCouponDetailService.exchangeCoupon(member, coupon, json.getTotal());
        return new Status("success");
    }
}
