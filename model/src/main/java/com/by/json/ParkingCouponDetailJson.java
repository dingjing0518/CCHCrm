package com.by.json;

import com.by.model.ParkingCouponDetail;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * Created by dingjing on 2017/2/16.
 */
public class ParkingCouponDetailJson {
    private String exchangeTime;
    private String exchangeAmount;
    private String couponName;

    public ParkingCouponDetailJson(ParkingCouponDetail parkingCouponDetail) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.exchangeTime = format.format(parkingCouponDetail.getExchangeTime().getTime());
        this.exchangeAmount = String.valueOf(parkingCouponDetail.getExchangeAmount());
        this.couponName = parkingCouponDetail.getCoupon().getName();
    }

    public String getExchangeTime() {
        return exchangeTime;
    }

    public void setExchangeTime(String exchangeTime) {
        this.exchangeTime = exchangeTime;
    }

    public String getExchangeAmount() {
        return exchangeAmount;
    }

    public void setExchangeAmount(String exchangeAmount) {
        this.exchangeAmount = exchangeAmount;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ParkingCouponDetailJson that = (ParkingCouponDetailJson) o;

        if (!exchangeTime.equals(that.exchangeTime)) return false;
        if (!exchangeAmount.equals(that.exchangeAmount)) return false;
        return couponName.equals(that.couponName);

    }

    @Override
    public int hashCode() {
        int result = exchangeTime.hashCode();
        result = 31 * result + exchangeAmount.hashCode();
        result = 31 * result + couponName.hashCode();
        return result;
    }
}
