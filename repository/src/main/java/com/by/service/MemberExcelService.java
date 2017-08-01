package com.by.service;

import com.by.form.BaseExcelForm;
import com.by.json.MemberExcelJson;

import java.util.List;

/**
 * Created by dingjing on 2017/3/15.
 */
public interface MemberExcelService {
    List<MemberExcelJson> findAll(BaseExcelForm form);
}
