package com.by.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.service.ParkingDetailService;

@Controller
@RequestMapping("/parkingDetail")
public class ParkingDetailController {
	@Autowired
	private ParkingDetailService service;


	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Status detail(@PathVariable("id") int id) {
		return new Success<>(service.findOneJson(id));
	}
}
