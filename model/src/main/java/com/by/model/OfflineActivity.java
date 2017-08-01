package com.by.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "by_offline_activity")
public class OfflineActivity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private int status;

	/**
	 * 
	 * getter method
	 * 
	 * @return the id
	 * 
	 */

	public int getId() {
		return id;
	}

	/**
	 * 
	 * setter method
	 * 
	 * @param id
	 *            the id to set
	 * 
	 */

	public void setId(int id) {
		this.id = id;
	}

	/**
	 * 
	 * getter method
	 * 
	 * @return the status
	 * 
	 */

	public int getStatus() {
		return status;
	}

	/**
	 * 
	 * setter method
	 * 
	 * @param status
	 *            the status to set
	 * 
	 */

	public void setStatus(int status) {
		this.status = status;
	}

	/*
	 * 
	 * <p>Title: hashCode</p>
	 * 
	 * <p>Description: </p>
	 * 
	 * @return
	 * 
	 * @see java.lang.Object#hashCode()
	 * 
	 */

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + status;
		return result;
	}

	/*
	 * 
	 * <p>Title: equals</p>
	 * 
	 * <p>Description: </p>
	 * 
	 * @param obj
	 * 
	 * @return
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 * 
	 */

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OfflineActivity other = (OfflineActivity) obj;
		if (id != other.id)
			return false;
		if (status != other.status)
			return false;
		return true;
	}

}
