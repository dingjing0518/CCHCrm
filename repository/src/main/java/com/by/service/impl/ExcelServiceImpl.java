package com.by.service.impl;

import com.by.form.BaseExcelForm;
import com.by.json.ExcelJson;
import com.by.json.ShopRuleJson;
import com.by.service.ExcelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by dingjing on 2017/3/14.
 */
@Service
public class ExcelServiceImpl implements ExcelService{
    @Autowired
    JdbcTemplate jdbcTemplate;
    private static Logger log = LoggerFactory.getLogger(ExcelServiceImpl.class);
    @Override
    public List<ExcelJson> findAll(BaseExcelForm form) {
        log.error("beginTime:"+form.getBeginTime());
        log.error("endTime:"+form.getEndTime());
        StringBuffer sql = new StringBuffer();
        sql.append(" select a.name,a.score,a.created_time as createdTime ");
        sql.append(" from by_member a ");
        sql.append(" where a.created_time <= ? and a.created_time >= ? order by a.created_time ");

        Object[] params = new Object[]{form.getEndTime(), form.getBeginTime()};
        List<ExcelJson> results = jdbcTemplate.query(sql.toString(), params, new BeanPropertyRowMapper<>((ExcelJson.class)));
        return results;
    }
}
