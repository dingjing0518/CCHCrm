package com.by.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.by.model.Activity;
import com.by.model.Member;
import com.by.model.ShoppingMall;
import com.by.repository.ActivityRepository;
import com.by.service.ActivityService;
import com.by.typeEnum.ShowOnIndex;

@Service
@Transactional
public class ActivityServiceImpl implements ActivityService {
	@Autowired
	private ActivityRepository repository;

	@Override
	@Transactional(readOnly = true)
	public Page<Activity> findByMall(ShoppingMall mall, Pageable pageable) {
		return repository.findByMall(mall, pageable);
	}

	@Override
	@Transactional(readOnly = true)
	public Activity findOne(int id) {
		return repository.findOne(id);
	}

	@Override
	public Activity save(Activity act) {
		return repository.save(act);
	}

	@Override
	public Activity update(Activity act) {
		Activity a = repository.findOne(act.getId());
		a.setName(act.getName());
		a.getContent().setSummary(act.getContent().getSummary());
		a.setIsShowOnIndex(act.getIsShowOnIndex());
		return a;
	}

	@Override
	public List<Activity> findByMallAndIsShowOnIndex(ShoppingMall mall, ShowOnIndex showOnIndex) {
		Pageable pageable = new PageRequest(0, 4, Direction.DESC, "createdTime", "updatedTime");
		return repository.findByMallAndIsShowOnIndex(mall, showOnIndex, pageable);
	}

	// 报名
	@Override
	public Activity enroll(Activity act, Member m) {
		Activity a = repository.findOne(act.getId());
		a.getMembers().add(m);
		return a;
	}

}
