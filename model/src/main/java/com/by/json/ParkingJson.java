package com.by.json;

import com.by.model.ParkingPayHistory;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * Created by dingjing on 2017/2/15.
 */
public class ParkingJson {
    private String createdTime;
    private String  inTime;
    private String  outTime;
    private Long member;
    private String carNumber;
    private String payAble;
    private  String payAmount;
    private String couponAmount;


    public String getInTime() {
        return inTime;
    }

    public void setInTime(String inTime) {
        this.inTime = inTime;
    }

    public String getOutTime() {
        return outTime;
    }

    public void setOutTime(String outTime) {
        this.outTime = outTime;
    }

    public Long getMember() {
        return member;
    }

    public void setMember(Long member) {
        this.member = member;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getPayAble() {
        return payAble;
    }

    public void setPayAble(String payAble) {
        this.payAble = payAble;
    }

    public String getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(String payAmount) {
        this.payAmount = payAmount;
    }

    public String getCouponAmount() {
        return couponAmount;
    }

    public void setCouponAmount(String couponAmount) {
        this.couponAmount = couponAmount;
    }

    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }
}
