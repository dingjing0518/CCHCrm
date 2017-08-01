package com.by.model;

import javax.persistence.*;
import java.util.Calendar;

/**
 * Created by dingjing on 2017/2/13.
 */
@Entity
@Table(name = "by_parking_coupon_detail")
public class ParkingCouponDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "coupon_id")
    private ParkingCoupon coupon;

    //兑换时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="exchange_time")
    private Calendar exchangeTime;

    //过期时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="invalid_time")
    private Calendar invalidTime;

    //兑换数量
    @Column(name="exchange_amount")
    private Integer exchangeAmount;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public ParkingCoupon getCoupon() {
        return coupon;
    }

    public void setCoupon(ParkingCoupon coupon) {
        this.coupon = coupon;
    }

    public Calendar getExchangeTime() {
        return exchangeTime;
    }

    public void setExchangeTime(Calendar exchangeTime) {
        this.exchangeTime = exchangeTime;
    }

    public Calendar getInvalidTime() {
        return invalidTime;
    }

    public void setInvalidTime(Calendar invalidTime) {
        this.invalidTime = invalidTime;
    }

    public Integer getExchangeAmount() {
        return exchangeAmount;
    }

    public void setExchangeAmount(Integer exchangeAmount) {
        this.exchangeAmount = exchangeAmount;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ParkingCouponDetail that = (ParkingCouponDetail) o;

        if (id != that.id) return false;
        if (!member.equals(that.member)) return false;
        if (!coupon.equals(that.coupon)) return false;
        if (!exchangeTime.equals(that.exchangeTime)) return false;
        if (!invalidTime.equals(that.invalidTime)) return false;
        return exchangeAmount.equals(that.exchangeAmount);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + member.hashCode();
        result = 31 * result + coupon.hashCode();
        result = 31 * result + exchangeTime.hashCode();
        result = 31 * result + invalidTime.hashCode();
        result = 31 * result + exchangeAmount.hashCode();
        return result;
    }
}
