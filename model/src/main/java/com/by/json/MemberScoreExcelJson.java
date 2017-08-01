package com.by.json;

/**
 * Created by dingjing on 2017/3/16.
 */
public class MemberScoreExcelJson {
    //会员号
    private String memberno;
    //业态
    private String category;
    //交易店铺
    private String shopName;
    //交易时间
    private String createdTime;
    //交易金额
    private String amount;
    //小票号
    private String code;
    //获取积分
    private String score;
    //操作人
    private String operator;

    public String getMemberno() {
        return memberno==null?"":memberno;
    }

    public void setMemberno(String memberno) {
        this.memberno = memberno;
    }

    public String getCategory() {
        return category==null? "":category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getShopName() {
        return shopName==null? "":shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getCreatedTime() {
        return createdTime==null? "":createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }

    public String getAmount() {
        return amount==null? "":amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getCode() {
        return code==null? "":code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getScore() {
        return score==null? "":score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getOperator() {
        return operator==null? "":operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }
}
