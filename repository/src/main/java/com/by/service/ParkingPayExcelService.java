package com.by.service;

import com.by.form.BaseExcelForm;
import com.by.json.ParkingPayExcelJson;

import java.util.List;

/**
 * Created by dingjing on 2017/3/17.
 */
public interface ParkingPayExcelService {
    List<ParkingPayExcelJson> findAll(BaseExcelForm form);
}
