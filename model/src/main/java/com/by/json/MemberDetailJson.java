package com.by.json;

import com.by.model.Member;
import com.by.model.MemberDetail;
import org.hibernate.validator.constraints.Length;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class MemberDetailJson {
	// 用户真实姓名
	@Length(max = 10)
	private String realName;

	// 住址
	@Length(max = 225)
	private String address;

	// 密码
	@Length(min = 6, max = 20)
	private String password;

	// 生日
	private Calendar birthday;

	private String birth;

	private int hasPassword = 0;
	
	private String ic;

	public MemberDetailJson() {
	}

	public MemberDetailJson(MemberDetail detail) {
		DateFormat formate = new SimpleDateFormat("yyyy-MM-dd");
		if (detail.getRealName() != null)
			this.realName = detail.getRealName();
		if (detail.getAddress() != null)
			this.address = detail.getAddress();
		if (detail.getBirthday() != null) {
			this.birth = formate.format(detail.getBirthday().getTime());
			this.birthday = detail.getBirthday();
		}
		if (detail.getPassword() != null) {
			this.password = detail.getPassword();
			hasPassword = 1;
		}
		this.ic = detail.getIc();

	}

	public MemberDetailJson(Member member) {
		this(member.getMemberDetail());
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Calendar getBirthday() {
		return birthday;
	}

	public void setBirthday(Calendar birthday) {
		this.birthday = birthday;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public int getHasPassword() {
		return hasPassword;
	}

	public void setHasPassword(int hasPassword) {
		this.hasPassword = hasPassword;
	}

	public String getIc() {
		return ic;
	}
	
	public void setIc(String ic) {
		this.ic = ic;
	}
	
	
}
