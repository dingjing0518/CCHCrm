package com.by.model;

import com.by.json.ShopJson;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Calendar;
import java.util.List;

/**
 * Created by yagamai on 15-11-23.
 */
@Entity
@Table(name = "by_shop")
public class Shop {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@NotNull
	@NotEmpty(message = "{NotEmpty.shop.name}")
	private String name;

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "by_shop_menu", joinColumns = @JoinColumn(name = "shop_id"), inverseJoinColumns = @JoinColumn(name = "menu_id"))
	private List<Menu> menus;

	@NotNull
	@Column(name = "shop_key")
	private String shopKey;

	@OneToMany(mappedBy = "shop", fetch = FetchType.LAZY)
	private List<ShopCoupon> coupons;

	@ManyToMany(mappedBy = "shops", fetch = FetchType.LAZY)
	private List<ShopRule> rules;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_time")
	private Calendar createdTime;

	@Column(name = "created_by")
	private String createdBy;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "updated_time")
	private Calendar updatedTime;

	@Column(name = "updated_by")
	private String updatedBy;

	@Column(name = "img_href")
	private String imgHref;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "first_category_id")
	private ShopCategory firstCategory;

	@OneToOne
	@JoinColumn(name = "second_category_id")
	private ShopCategory secondCategory;

	@ManyToOne
	@JoinColumn(name = "floor_id")
	private Floor floor;

	private String address;

	private String phone;
	
	private Integer status;
	
	@Column(name = "business_hour")
	private String BusinessHour;

	public Shop() {
	}

	public Shop(int id) {
		this.id = id;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}

	public String getShopKey() {
		return shopKey;
	}

	public void setShopKey(String shopKey) {
		this.shopKey = shopKey;
	}

	public List<ShopCoupon> getCoupons() {
		return coupons;
	}

	public void setCoupons(List<ShopCoupon> coupons) {
		this.coupons = coupons;
	}

	public Calendar getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Calendar createdTime) {
		this.createdTime = createdTime;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Calendar getUpdatedTime() {
		return updatedTime;
	}

	public void setUpdatedTime(Calendar updatedTime) {
		this.updatedTime = updatedTime;
	}

	public String getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public List<ShopRule> getRules() {
		return rules;
	}

	public void setRules(List<ShopRule> rules) {
		this.rules = rules;
	}

	public String getImgHref() {
		return imgHref;
	}

	public void setImgHref(String imgHref) {
		this.imgHref = imgHref;
	}

	public ShopJson toJson() {
		return new ShopJson(this);
	}

	public ShopCategory getFirstCategory() {
		return firstCategory;
	}

	public void setFirstCategory(ShopCategory firstCategory) {
		this.firstCategory = firstCategory;
	}

	public ShopCategory getSecondCategory() {
		return secondCategory;
	}

	public void setSecondCategory(ShopCategory secondCategory) {
		this.secondCategory = secondCategory;
	}

	public Floor getFloor() {
		return floor;
	}

	public void setFloor(Floor floor) {
		this.floor = floor;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBusinessHour() {
		return BusinessHour;
	}
	
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public void setBusinessHour(String businessHour) {
		BusinessHour = businessHour;
	}

	@PrePersist
	private void prePersist() {
		this.createdTime = Calendar.getInstance();
		if (this.updatedTime == null)
			this.updatedTime = Calendar.getInstance();
	}

	@PreUpdate
	private void preUpdate() {
		this.updatedTime = Calendar.getInstance();
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || getClass() != o.getClass())
			return false;

		Shop shop = (Shop) o;

		return id == shop.id;

	}

	@Override
	public int hashCode() {
		return id;
	}
}
