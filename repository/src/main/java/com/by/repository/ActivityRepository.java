package com.by.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import com.by.model.Activity;
import com.by.model.ShoppingMall;
import com.by.typeEnum.ShowOnIndex;

public interface ActivityRepository extends CrudRepository<Activity, Integer> {
	Page<Activity> findByMall(ShoppingMall mall,Pageable pageable);

	List<Activity> findByMallAndIsShowOnIndex(ShoppingMall mall,ShowOnIndex showOnIndex,Pageable pageable);
}
