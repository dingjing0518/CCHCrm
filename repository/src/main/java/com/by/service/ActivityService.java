package com.by.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.by.model.Activity;
import com.by.model.Member;
import com.by.model.ShoppingMall;
import com.by.typeEnum.ShowOnIndex;

public interface ActivityService {
	Page<Activity> findByMall(ShoppingMall mall, Pageable pageable);

	Activity findOne(int id);

	Activity save(Activity act);

	Activity update(Activity act);
	
	Activity enroll(Activity act,Member m);
	
	List<Activity> findByMallAndIsShowOnIndex(ShoppingMall mall,ShowOnIndex showOnIndex);
}
