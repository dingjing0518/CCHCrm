package com.by.service;

import com.by.form.BaseExcelForm;
import com.by.json.ExcelJson;

import java.util.List;

/**
 * Created by dingjing on 2017/3/14.
 */
public interface ExcelService {
    List<ExcelJson> findAll(BaseExcelForm form);
}

