package com.by.model;

import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "by_parking_detail")
public class ParkingDetail {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;
	
	@OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.ALL })
    @JoinColumn(name = "content_id")
	private ParkingDetailContent content;
	
	@Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_time")
    private Calendar createdTime;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_time")
    private Calendar updatedTime;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "updated_by")
    private String updatedBy;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public ParkingDetailContent getContent() {
		return content;
	}

	public void setContent(ParkingDetailContent content) {
		this.content = content;
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
    
    
}
