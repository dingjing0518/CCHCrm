package com.by.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.model.VehicleEntrance;
import com.by.service.VehicleEntranceService;

@Controller
@RequestMapping("/parking")
public class VehicleEntranceController {
	@Autowired
	private VehicleEntranceService service;
	public static DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	private String parkingInfo(@RequestBody VehicleEntrance v) {
		try {
			Date d = format.parse(v.getTime());
			Calendar c = Calendar.getInstance();
			c.setTime(d);
			v.setEnterOrLeaveTime(c);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		service.save(v);
		return null;
	}
}
