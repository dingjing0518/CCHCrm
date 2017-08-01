package com.by.model;

import com.by.json.RestaurantCouponJson;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.util.Calendar;

/**
 * Created by yvan on 2017/1/5.
 */
@Entity
@Table(name = "by_restaurant_coupon")
public class RestaurantCoupon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotEmpty
    private String name;

    private String phone;

    private String summary;

    @Temporal(TemporalType.TIMESTAMP)
    private Calendar time;


    @Column(name = "img_href")
    private String imgHref;

    @CreatedDate
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_time", updatable = false)
    private Calendar createdTime;


    @LastModifiedDate
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "update_time")
    private Calendar updatedTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public Calendar getTime() {
        return time;
    }

    public String getImgHref() {
        return imgHref;
    }

    public void setImgHref(String imgHref) {
        this.imgHref = imgHref;
    }

    public void setTime(Calendar time) {
        this.time = time;
    }

    public Calendar getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Calendar createdTime) {
        this.createdTime = createdTime;
    }

    public Calendar getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(Calendar updatedTime) {
        this.updatedTime = updatedTime;
    }

    public RestaurantCouponJson toJson() {
        return new RestaurantCouponJson(this);
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
