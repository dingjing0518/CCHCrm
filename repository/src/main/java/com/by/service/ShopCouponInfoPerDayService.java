package com.by.service;

import java.util.List;

/**
 * Created by yagamai on 16-3-18.
 */
public interface ShopCouponInfoPerDayService {
//	List<Object[]> findByYearAndMonth(int year, int month);

	List<Object[]> findByYear();

	List<Object[]> findBySeason(int year);

	List<Object[]> findBySeasonAndMonth(int year, int season);

	List<Object[]> findByMonth(int year);

	List<Object[]> findByMonthAndDay(int year, int month);

//	List<Integer> findAllValidYear();
}
