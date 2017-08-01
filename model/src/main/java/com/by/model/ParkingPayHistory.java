package com.by.model;

import javax.persistence.*;
import java.util.Calendar;

/**
 * Created by dingjing on 2017/2/8.
 */
@Entity
@Table(name ="by_parking_pay_history")
public class ParkingPayHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    //车牌号码
    @Column(name="car_number")
    private String carNumber;

    //创建时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_time")
    private Calendar createdTime;

    // 入场时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = " in_time")
    private Calendar  inTime;

    // 出场时间
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = " out_time")
    private Calendar  outTime;

    //应付金额
    @Column(name="pay_able")
    private Double payAble;

    //实付金额
    @Column(name="pay_amount")
    private  Double payAmount;

    //卡券抵用金额
    @Column(name="coupon_amount")
    private Double couponAmount;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public Calendar getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Calendar createdTime) {
        this.createdTime = createdTime;
    }

    public Calendar getInTime() {
        return inTime;
    }

    public void setInTime(Calendar inTime) {
        this.inTime = inTime;
    }

    public Calendar getOutTime() {
        return outTime;
    }

    public void setOutTime(Calendar outTime) {
        this.outTime = outTime;
    }

    public Double getPayAble() {
        return payAble;
    }

    public void setPayAble(Double payAble) {
        this.payAble = payAble;
    }

    public Double getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(Double payAmount) {
        this.payAmount = payAmount;
    }

    public Double getCouponAmount() {
        return couponAmount;
    }

    public void setCouponAmount(Double couponAmount) {
        this.couponAmount = couponAmount;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ParkingPayHistory that = (ParkingPayHistory) o;

        if (id != that.id) return false;
        if (!member.equals(that.member)) return false;
        if (!carNumber.equals(that.carNumber)) return false;
        if (!createdTime.equals(that.createdTime)) return false;
        if (!inTime.equals(that.inTime)) return false;
        if (!outTime.equals(that.outTime)) return false;
        if (!payAble.equals(that.payAble)) return false;
        if (!payAmount.equals(that.payAmount)) return false;
        return couponAmount.equals(that.couponAmount);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + member.hashCode();
        result = 31 * result + carNumber.hashCode();
        result = 31 * result + createdTime.hashCode();
        result = 31 * result + inTime.hashCode();
        result = 31 * result + outTime.hashCode();
        result = 31 * result + payAble.hashCode();
        result = 31 * result + payAmount.hashCode();
        result = 31 * result + couponAmount.hashCode();
        return result;
    }
}
