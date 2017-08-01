package com.by.service;

import java.util.List;

import com.by.json.ParkingDetailJson;
import com.by.model.ParkingDetail;

public interface ParkingDetailService {
	List<ParkingDetail> findAll();

	ParkingDetail findOne(int id);

	ParkingDetailJson save(ParkingDetail parkingDetail);

	ParkingDetailJson update(ParkingDetail parkingDetail);

    List<ParkingDetailJson> findAllJson();

    ParkingDetailJson findOneJson(int id);
}
