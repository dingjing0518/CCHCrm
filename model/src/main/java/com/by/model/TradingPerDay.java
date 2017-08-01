package com.by.model;

import javax.persistence.*;
import java.util.Calendar;

/**
 * Created by yagamai on 16-3-15.
 */
@Entity
@Table(name = "by_batch_trading_per_day")
public class TradingPerDay {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@Column(name = "shop_key")
	private String shopKey;

	@Column(name = "shop_name")
	private String shopName;

	@Column(name = "floor")
	private String floor;

	@Temporal(TemporalType.DATE)
	@Column(name = "created_time")
	private Calendar createdTime;

	private int number;

	private float amount;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Calendar getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Calendar time) {
		this.createdTime = time;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public String getShopKey() {
		return shopKey;
	}

	public void setShopKey(String shopKey) {
		this.shopKey = shopKey;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getFloor() {
		return floor;
	}

	public void setFloor(String floor) {
		this.floor = floor;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Float.floatToIntBits(amount);
		result = prime * result + ((createdTime == null) ? 0 : createdTime.hashCode());
		result = prime * result + ((floor == null) ? 0 : floor.hashCode());
		result = prime * result + id;
		result = prime * result + number;
		result = prime * result + ((shopKey == null) ? 0 : shopKey.hashCode());
		result = prime * result + ((shopName == null) ? 0 : shopName.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TradingPerDay other = (TradingPerDay) obj;
		if (Float.floatToIntBits(amount) != Float.floatToIntBits(other.amount))
			return false;
		if (createdTime == null) {
			if (other.createdTime != null)
				return false;
		} else if (!createdTime.equals(other.createdTime))
			return false;
		if (floor == null) {
			if (other.floor != null)
				return false;
		} else if (!floor.equals(other.floor))
			return false;
		if (id != other.id)
			return false;
		if (number != other.number)
			return false;
		if (shopKey == null) {
			if (other.shopKey != null)
				return false;
		} else if (!shopKey.equals(other.shopKey))
			return false;
		if (shopName == null) {
			if (other.shopName != null)
				return false;
		} else if (!shopName.equals(other.shopName))
			return false;
		return true;
	}

	
}
