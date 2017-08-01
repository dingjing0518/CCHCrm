package com.by.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.by.json.ParkingDetailJson;
import com.by.model.ParkingDetail;
import com.by.repository.ParkingDetailRepository;
import com.by.service.ParkingDetailService;
import com.google.common.collect.Lists;
@Service
@Transactional
public class ParkingDetailServiceImpl implements ParkingDetailService {
	@Autowired
	private ParkingDetailRepository repository;
	@Override
	@Transactional(readOnly = true)
	public List<ParkingDetail> findAll() {
		return Lists.newArrayList(repository.findAll());
	}

	@Override
	@Transactional(readOnly = true)
	public ParkingDetail findOne(int id) {
		return repository.findOne(id);
	}

	@Override
	public ParkingDetailJson save(ParkingDetail parkingDetail) {
		ParkingDetail detail = repository.save(parkingDetail);
		ParkingDetailJson json = new ParkingDetailJson();
		json.setContent(detail.getContent().getSummary());
		json.setId(detail.getId());
		json.setTitle(detail.getTitle());
		return json;
	}

	@Override
	public ParkingDetailJson update(ParkingDetail parkingDetail) {
		ParkingDetail detail = repository.findOne(parkingDetail.getId());
		detail.setContent(parkingDetail.getContent());
		ParkingDetailJson json = new ParkingDetailJson();
		json.setContent(detail.getContent().getSummary());
		json.setId(detail.getId());
		json.setTitle(detail.getTitle());
		return json;
	}

	@Override
	public List<ParkingDetailJson> findAllJson() {
		return findAll().stream().map(i -> {
			ParkingDetailJson json = new ParkingDetailJson();
			json.setId(i.getId());
			json.setTitle(i.getTitle());
			return json;
		}).collect(Collectors.toList());
	}

	@Override
	public ParkingDetailJson findOneJson(int id) {
		ParkingDetail detail = findOne(id);
		if (detail != null) {
			ParkingDetailJson json = new ParkingDetailJson();
			json.setContent(detail.getContent().getSummary());
			json.setId(detail.getId());
			json.setTitle(detail.getTitle());
			return json;
		}
		return null;
	}

}
