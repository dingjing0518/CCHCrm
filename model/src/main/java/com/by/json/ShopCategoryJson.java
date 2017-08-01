package com.by.json;

import com.by.model.Shop;

import java.util.List;

/**
 * Created by dingjing on 2017/3/7.
 */
public class ShopCategoryJson {
    private String name;
    private List<Shop> shopList;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Shop> getShopList() {
        return shopList;
    }

    public void setShopList(List<Shop> shopList) {
        this.shopList = shopList;
    }

    @Override
    public String toString() {
        return "ShopCategoryJson{" +
                "name='" + name + '\'' +
                ", shopList=" + shopList +
                '}';
    }
}
