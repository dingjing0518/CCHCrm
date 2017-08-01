package com.by.service.impl;

import com.by.form.BaseExcelForm;
import com.by.json.MemberExcelJson;
import com.by.json.MemberScoreExcelJson;
import com.by.service.MemberScoreExcelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by dingjing on 2017/3/16.
 */
@Service
public class MemberScoreExcelServiceImpl implements MemberScoreExcelService {
    @Autowired
    JdbcTemplate jdbcTemplate;
    private static Logger log = LoggerFactory.getLogger(MemberScoreExcelServiceImpl.class);
    @Override
    public List<MemberScoreExcelJson> findAll(BaseExcelForm form) {
        log.error("beginTime:"+form.getBeginTime());
        log.error("endTime:"+form.getEndTime());
        StringBuffer sql = new StringBuffer();
        sql.append(" select memberno,category,shopName,createdTime,amount,code,score,e.operator as operator from (select a.created_time as createdTime, ");
        sql.append(" a.member_id as memberId,b.name as memberno,d.name as category, ");
        sql.append(" c.name as shopName,a.amount as amount,a.code as code,a.score as score ");
        sql.append(" from by_trading a, by_member b, by_shop c, by_category d ");
        sql.append(" where a.member_id = b.id and a.shop_id = c.id and c.first_category_id = d.id) t ");
        sql.append(" left join by_score_history e on t.memberId=e.member_id and t.createdTime=e.created_time ");
        sql.append(" and t.score=e.deposit where t.createdTime<=? and t.createdTime>=? order by t.createdTime; ");
        Object[] params = new Object[]{form.getEndTime(), form.getBeginTime()};
        List<MemberScoreExcelJson> results = jdbcTemplate.query(sql.toString(), params, new BeanPropertyRowMapper<>((MemberScoreExcelJson.class)));
        return results;
    }
}
