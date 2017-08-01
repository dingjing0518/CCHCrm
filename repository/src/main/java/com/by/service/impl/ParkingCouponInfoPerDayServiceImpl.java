package com.by.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.by.repository.ParkingCouponInfoPerDayRepository;
import com.by.service.ParkingCouponInfoPerDayService;

/**
 * Created by yagamai on 16-3-17.
 */
@Service
@Transactional
public class ParkingCouponInfoPerDayServiceImpl implements ParkingCouponInfoPerDayService {
	
	@Autowired
    private ParkingCouponInfoPerDayRepository repository;

    @Override
	public List<Object[]> findByYear() {
		return repository.findByYear();
	}

	@Override
	public List<Object[]> findBySeason(int year) {
		return repository.findBySeason(year);
	}
	
	@Override
	public List<Object[]> findBySeasonAndMonth(int year, int season) {
		return repository.findBySeasonAndMonth(year,season);
	}

	@Override
	public List<Object[]> findByMonth(int year) {
		return repository.findByMonth(year);
	}

	@Override
	public List<Object[]> findByMonthAndDay(int year, int month) {
		return repository.findByMonthAndDay(year, month);
	}

}
