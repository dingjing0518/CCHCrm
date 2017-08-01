package com.by.json;

/**
 * Created by dingjing on 2017/3/17.
 */
public class ParkingPayExcelJson {
    //会员号
    private String name;
    //车牌
    private String carNumber;
    //入场时间
    private String inTime;
    //支付时间
    private String createdTime;
    //应付金额
    private String payAble;
    //积分抵扣金额
    private String couponAmount;
    //实付金额
    private String payAmount;

    public String getName() {
        return name==null?"":name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCarNumber() {
        return carNumber==null?"":carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getInTime() {
        return inTime==null?"":inTime;
    }

    public void setInTime(String inTime) {
        this.inTime = inTime;
    }

    public String getCreatedTime() {
        return createdTime==null?"":createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }

    public String getPayAble() {
        return payAble==null?"":payAble;
    }

    public void setPayAble(String payAble) {
        this.payAble = payAble;
    }

    public String getCouponAmount() {
        return couponAmount==null?"":couponAmount;
    }

    public void setCouponAmount(String couponAmount) {
        this.couponAmount = couponAmount;
    }

    public String getPayAmount() {
        return payAmount==null?"":payAmount;
    }

    public void setPayAmount(String payAmount) {
        this.payAmount = payAmount;
    }
}
