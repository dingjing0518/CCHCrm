package com.by.service;

import java.util.List;

public interface GiftCouponInfoPerDayService {
	List<Object[]> findByYear();

	List<Object[]> findBySeason(int year);

	List<Object[]> findBySeasonAndMonth(int year, int season);

	List<Object[]> findByMonth(int year);

	List<Object[]> findByMonthAndDay(int year, int month);
}
