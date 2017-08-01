package com.by.service.impl;

import com.by.repository.GiftCouponInfoPerDayRepository;
import com.by.service.GiftCouponInfoPerDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class GiftCouponInfoPerDayServiceImpl implements GiftCouponInfoPerDayService {
    @Autowired
    private GiftCouponInfoPerDayRepository repository;

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
