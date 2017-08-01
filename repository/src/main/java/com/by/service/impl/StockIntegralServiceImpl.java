package com.by.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.by.repository.StockIntegralRepository;
import com.by.service.StockIntegralService;
@Service
public class StockIntegralServiceImpl implements StockIntegralService {
	@Autowired
	private StockIntegralRepository repository;

	@Override
	public String findBy500() {
		
		return repository.findBy500();
	}

	@Override
	public String findBy1000() {
	
		return repository.findBy1000();
	}

	@Override
	public String findBy1400() {
		return repository.findBy1400();
	}

	@Override
	public String findBy1800() {
		return repository.findBy1800();
	}

	@Override
	public String findByOther() {
		return repository.findByOther();
	}

	@Override
	public String findTotal() {
		return repository.findTotal();
	}
}
