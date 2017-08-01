package com.by.json;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by yagamai on 15-12-7.
 */
public class ScoreHistoryJson {
    private Long id;
    private String createdTime;
    private int deposit;
    private String reason;
    private String operator;

    public ScoreHistoryJson() {
    }

    public ScoreHistoryJson(Long id, Calendar createdTime, int deposit, String reason, String operator) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.id = id;
        this.createdTime = format.format(createdTime.getTime());
        this.deposit = deposit;
        this.reason = reason;
        this.operator = operator;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }

    public int getDeposit() {
        return deposit;
    }

    public void setDeposit(int deposit) {
        this.deposit = deposit;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }
}
