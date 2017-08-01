package com.by.json;

import com.by.model.ParkingPayHistory;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by dinghjing on 2017/2/8.
 */
public class ParkingPayHistoryJson {
    private String createdTime;
    private String  inTime;
    private String  outTime;
    private Long member;
    private String carNumber;
    private String payAble;
    private  String payAmount;
    private String couponAmount;

    public ParkingPayHistoryJson(ParkingPayHistory parkingPayHistory) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.createdTime=format.format(parkingPayHistory.getCreatedTime().getTime());
        this.inTime = format.format(parkingPayHistory.getInTime().getTime());
        this.outTime = format.format(parkingPayHistory.getOutTime().getTime());
        this.carNumber = parkingPayHistory.getCarNumber();
        this.payAble = String.valueOf(parkingPayHistory.getPayAble());
        this.payAmount = String.valueOf(parkingPayHistory.getPayAmount());
        this.couponAmount = String.valueOf(parkingPayHistory.getCouponAmount());
    }

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
