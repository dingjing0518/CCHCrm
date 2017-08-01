package com.by.service.impl;

import com.by.form.BaseExcelForm;
import com.by.json.MemberExcelJson;
import com.by.service.MemberExcelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by dingjing on 2017/3/15.
 */
@Service
public class MemberExcelServiceImpl implements MemberExcelService {
    @Autowired
    JdbcTemplate jdbcTemplate;
    private static Logger log = LoggerFactory.getLogger(MemberExcelServiceImpl.class);
    @Override
    public List<MemberExcelJson> findAll(BaseExcelForm form) {
        log.error("beginTime:"+form.getBeginTime());
        log.error("endTime:"+form.getEndTime());
        StringBuffer sql = new StringBuffer();
        sql.append(" select a.name as memberId,a.score,b.ic as memberIc,a.created_time as createdTime ");
        sql.append(" from by_member a,by_member_detail b ");
        sql.append(" where a.detail_id=b.id and ");
        sql.append(" a.created_time <= ? and a.created_time >= ? order by a.created_time ");
        Object[] params = new Object[]{form.getEndTime(), form.getBeginTime()};
        List<MemberExcelJson> results = jdbcTemplate.query(sql.toString(), params, new BeanPropertyRowMapper<>((MemberExcelJson.class)));
        return results;
    }
}
