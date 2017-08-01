package com.by.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.by.repository.TradingAnalysisRepository;
import com.by.service.TradingAnalysisService;

@Service
public class TradingAnalysisServiceImpl implements TradingAnalysisService {

	@Autowired
	private TradingAnalysisRepository repository;

	@Override
	public List<Object[]> findByFloor(String startTime, String endTime){
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = sdf.parse(startTime);
			Date endDate = sdf.parse(endTime);
			Calendar startDay = Calendar.getInstance();
			startDay.setTime(startDate);
			Calendar endDay = Calendar.getInstance();
			endDay.setTime(endDate);
			return repository.findByFloor(startDay, endDay);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Object[]> findByFloorAndBrand(String startTime, String endTime, String floor) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = sdf.parse(startTime);
			Date endDate = sdf.parse(endTime);
			Calendar startDay = Calendar.getInstance();
			startDay.setTime(startDate);
			Calendar endDay = Calendar.getInstance();
			endDay.setTime(endDate);
			return repository.findByFloorAndBrand(startDay, endDay,floor);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<String> findByValidFloor() {
		return repository.findByValidFloor();
	}

}
