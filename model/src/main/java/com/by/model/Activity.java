package com.by.model;

import javax.persistence.*;

import com.by.typeEnum.ShowOnIndex;

import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

@Entity
@Table(name = "by_activity")
public class Activity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@Column(name = "cover_img")
	private String coverImg;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "start_time")
	private Calendar startTime;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "end_time")
	private Calendar endTime;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "enroll_begin_time")
	private Calendar enrollBeginTime;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "enroll_end_time")
	private Calendar enrollEndTime;

	@OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinColumn(name = "content_id")
	private ActivityContent content;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "by_activity_member", joinColumns = @JoinColumn(name = "activity_id"), inverseJoinColumns = @JoinColumn(name = "member_id"))
	private List<Member> members = new LinkedList<>();

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "mall_id")
	private ShoppingMall mall;

	@Enumerated
	@Column(name = "is_show_on_index")
	private ShowOnIndex isShowOnIndex;

	@Column(name = "created_by")
	private String createdBy;

	@Column(name = "updated_by")
	private String updatedBy;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_time")
	private Calendar createdTime;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "updated_time")
	private Calendar updatedTime;

	public Activity() {
	}

	public Activity(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCoverImg() {
		return coverImg;
	}

	public void setCoverImg(String coverImg) {
		this.coverImg = coverImg;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Calendar getStartTime() {
		return startTime;
	}

	public void setStartTime(Calendar startTime) {
		this.startTime = startTime;
	}

	public Calendar getEndTime() {
		return endTime;
	}

	public void setEndTime(Calendar endTime) {
		this.endTime = endTime;
	}

	public ActivityContent getContent() {
		return content;
	}

	public void setContent(ActivityContent content) {
		this.content = content;
	}

	public List<Member> getMembers() {
		return members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}

	public Calendar getEnrollBeginTime() {
		return enrollBeginTime;
	}

	public void setEnrollBeginTime(Calendar enrollBeginTime) {
		this.enrollBeginTime = enrollBeginTime;
	}

	public Calendar getEnrollEndTime() {
		return enrollEndTime;
	}

	public void setEnrollEndTime(Calendar enrollEndTime) {
		this.enrollEndTime = enrollEndTime;
	}

	public ShoppingMall getMall() {
		return mall;
	}

	public void setMall(ShoppingMall mall) {
		this.mall = mall;
	}

	public ShowOnIndex getIsShowOnIndex() {
		return isShowOnIndex;
	}

	public void setIsShowOnIndex(ShowOnIndex isShowOnIndex) {
		this.isShowOnIndex = isShowOnIndex;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
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

	@PrePersist
	private void prePersist() {
		this.createdTime = Calendar.getInstance();
		if (isShowOnIndex == null)
			this.isShowOnIndex = ShowOnIndex.NOTSHOWONINDEX;
	}

	@PreUpdate
	private void preUpdate() {
		this.updatedTime = Calendar.getInstance();
		if (isShowOnIndex == null)
			this.isShowOnIndex = ShowOnIndex.NOTSHOWONINDEX;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || getClass() != o.getClass())
			return false;

		Activity activity = (Activity) o;

		return id == activity.id;

	}

	@Override
	public int hashCode() {
		return id;
	}
}
