package com.by.json;

import com.by.model.Activity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class ActivityJson {
    private int id;
    private String name;
    private String enrollBeginTime;
    private String enrollEndTime;

    public ActivityJson(Activity act) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.id = act.getId();
        this.name = act.getName();
        if (act.getEnrollBeginTime() != null)
            this.enrollBeginTime = format.format(act.getEnrollBeginTime().getTime());
        if (act.getEnrollEndTime() != null)
            this.enrollEndTime = format.format(act.getEnrollEndTime().getTime());
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEnrollBeginTime() {
        return enrollBeginTime;
    }

    public void setEnrollBeginTime(String enrollBeginTime) {
        this.enrollBeginTime = enrollBeginTime;
    }

	public String getEnrollEndTime() {
		return enrollEndTime;
	}

	public void setEnrollEndTime(String enrollEndTime) {
		this.enrollEndTime = enrollEndTime;
	}
}
