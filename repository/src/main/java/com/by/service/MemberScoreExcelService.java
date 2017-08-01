package com.by.service;


import com.by.form.BaseExcelForm;
import com.by.json.MemberScoreExcelJson;

import java.util.List;

/**
 * Created by dingjing on 2017/3/16.
 */
public interface MemberScoreExcelService {
    List<MemberScoreExcelJson> findAll(BaseExcelForm form);
}
