package com.by.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.CouponJson;
import com.by.model.Member;
import com.by.service.CouponService;
import com.by.service.MemberService;

/**
 * Created by yagamai on 15-12-16.
 */
@Controller
@RequestMapping(value = "/api/coupons")
public class CouponController implements UtilContoller {
    @Autowired
    private CouponService couponService;
    @Autowired
    private MemberService memberService;

    // 可以兑换的优惠券
    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public Success<Page<CouponJson>> list(HttpServletRequest request,
                                          @RequestParam(value = "name", required = false) String name,
                                          @PageableDefault(page = 0, size = 10, sort = "couponEndTime", direction = Sort.Direction.ASC) Pageable pageable) {
        Member member = (Member) request.getAttribute("member");
        member = memberService.findOne(member.getId());
        validMember(member);
        if (!StringUtils.isEmpty(name))
            return new Success<>(couponService.findByNameLike(name, pageable));
        else
            return new Success<>(couponService.findAll(pageable));
    }

    // 兑换到的优惠券
    @RequestMapping(value = "/member", method = RequestMethod.GET)
    @ResponseBody
    public Status list(HttpServletRequest request,
                       @PageableDefault(page = 0, size = 10, direction = Sort.Direction.DESC) Pageable pageable) {
        Member member = (Member) request.getAttribute("member");
        member = memberService.findOne(member.getId());
        validMember(member);
        return new Success<>(couponService.findByMember(member, pageable));
    }
    
    // 可以兑换的优惠券-停车、礼品、店铺券分离
    @RequestMapping(value = "/{type}",method = RequestMethod.GET)
    @ResponseBody
    public Success<Page<CouponJson>> couponsByType(HttpServletRequest request,
    									  @PathVariable String type,
                                          @PageableDefault(page = 0, size = 10, sort = "couponEndTime", direction = Sort.Direction.ASC) Pageable pageable) {
        Member member = (Member) request.getAttribute("member");
        member = memberService.findOne(member.getId());
        validMember(member);
        return new Success<>(couponService.findAllByType(type, pageable));
    }
    
 // 兑换到的优惠券
    @RequestMapping(value = "/{type}/member", method = RequestMethod.GET)
    @ResponseBody
    public Status myCouponsByType(HttpServletRequest request,@PathVariable String type,
                       @PageableDefault(page = 0, size = 10, direction = Sort.Direction.DESC) Pageable pageable) {
        Member member = (Member) request.getAttribute("member");
        member = memberService.findOne(member.getId());
        validMember(member);
        return new Success<>(couponService.findByMemberAndType(member, type, pageable));
    }
}
