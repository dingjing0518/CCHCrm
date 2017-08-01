package com.by.service;

import java.util.List;

public interface TradingIncPerDayService {
    List<Object[]> findByYearAndMonth(int year, int month);
    
    List<Object[]> findByYear();
    
    List<Object[]> findBySeason(int year);
    
    List<Object[]> findBySeasonAndMonth(int year, int season);
    
    List<Object[]> findByMonth(int year);
    
    List<Object[]> findByMonthAndDay(int year,int month);
    
    List<Integer> findAllValidYear();
}
