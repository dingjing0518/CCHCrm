package com.by.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.by.repository.TradingIncPerDayRepository;
import com.by.service.TradingIncPerDayService;

@Service
public class TradingIncPerDayServiceImpl implements TradingIncPerDayService {
	@Autowired
	private TradingIncPerDayRepository repository;

	@Override
	public List<Object[]> findByYearAndMonth(int year, int month) {
		return repository.findByYearAndMonth(year, month);
	}
	
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

	@Override
	public List<Integer> findAllValidYear() {
		return repository.findAllValidYear();
	}
	
}
