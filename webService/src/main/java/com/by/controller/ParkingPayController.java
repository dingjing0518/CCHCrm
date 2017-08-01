package com.by.controller;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.json.ParkingJson;
import com.by.json.ParkingPayHistoryJson;
import com.by.json.ParkingPayJson;
import com.by.model.Member;
import com.by.service.ParkingPayHistoryService;
import com.by.service.ParkingPayService;
import com.by.utils.FailBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * Created by yagamai on 15-12-9.
 */
@Controller
@RequestMapping("/api/parkingPay")
public class ParkingPayController {
    @Autowired
    private ParkingPayHistoryService service;

    //记录支付信息
    @RequestMapping(value = "/pay",method = RequestMethod.POST)
    @ResponseBody
    public Status pay(HttpServletRequest request,
                      @RequestBody @Valid ParkingJson json, BindingResult result) {
        Member member = (Member) request.getAttribute("member");
        if (result.hasErrors()) {
            return FailBuilder.buildFail(result);
        }
        json.setMember(member.getId());
        service.save(json);
        return new Status("success");
    }
    //查询用券金额
    @RequestMapping(value = "/CarNumbe",method = RequestMethod.POST)
    @ResponseBody
    public Status isOutCouponAmount(HttpServletRequest request,
                                    @RequestBody @Valid ParkingJson json, BindingResult result){
        Member member = (Member) request.getAttribute("member");
        if (result.hasErrors()) {
            return FailBuilder.buildFail(result);
        }
        return new Success<>(service.findByCarNumber(json.getCarNumber()));
    }
}
