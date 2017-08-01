package com.by.json;

import java.beans.BeanInfo;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by yvan on 2017/1/16.
 */
public class ShopRuleJson {
    private int id;
    private String shopName;
    private String ruleName;
    private String status;
    private String beginTime;
    private String endTime;
    private String cssClass;
    private Integer valid;


    private static final String PATTERN_TIME = "yyyy-MM-dd HH:mm:ss";
    private static final String PATTERN_DATE = "yyyy-MM-dd";

    /**
     * 格式化输出时间
     *
     * @return
     * @throws ParseException
     */
    public ShopRuleJson toJson() {
        if (null == beginTime && null == endTime ) {
            cssClass = "text-success";
            status = "使用中";
            beginTime = "长期有效";
            endTime = "长期有效";
        } else if (null != beginTime  && null != endTime ) {
            if (beforeToday(beginTime) && afterToday(endTime)) {
                cssClass = "text-success";
                status = "使用中";
            } else if (afterToday(beginTime)) {
                cssClass = "text-primary";
                status = "未生效";
            } else if (beforeToday(endTime)) {
                cssClass = "text-muted";
                status = "已过期";
            }
            try {
                SimpleDateFormat in = new SimpleDateFormat(PATTERN_TIME);
                SimpleDateFormat out = new SimpleDateFormat(PATTERN_DATE);
                beginTime = out.format(in.parse(beginTime));
                endTime = out.format(in.parse(endTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if (valid == 0) {
            cssClass = "text-danger";
            status = "已关闭";
        }
        return this;
    }

    private boolean beforeToday(String time) {
        SimpleDateFormat sdf = new SimpleDateFormat(PATTERN_TIME);
        try {
            Date beginDate = sdf.parse(time);
            return beginDate.before(new Date());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean afterToday(String time) {
        SimpleDateFormat sdf = new SimpleDateFormat(PATTERN_TIME);
        try {
            Date beginDate = sdf.parse(time);
            return beginDate.after(new Date());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Integer getValid() {
        return valid;
    }

    public void setValid(Integer valid) {
        this.valid = valid;
    }

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getRuleName() {
        return ruleName;
    }

    public void setRuleName(String ruleName) {
        this.ruleName = ruleName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
