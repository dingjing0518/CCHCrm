package com.by.json;

import com.by.model.RestaurantCoupon;
import org.springframework.beans.BeanUtils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 * Created by yvan on 2017/1/5.
 */
public class RestaurantCouponJson {
    private Long id;
    private String name;
    private String time;
    private String summary;

    public RestaurantCouponJson(RestaurantCoupon restaurantCoupon) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        BeanUtils.copyProperties(restaurantCoupon, this);
        if (restaurantCoupon.getTime() != null)
            this.time = format.format(restaurantCoupon.getTime().getTime());
    }

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

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }
}
