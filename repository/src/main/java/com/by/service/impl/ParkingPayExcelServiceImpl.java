package com.by.service.impl;

import com.by.form.BaseExcelForm;
import com.by.json.ParkingPayExcelJson;
import com.by.service.ParkingPayExcelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by dingjing on 2017/3/17.
 */
@Service
public class ParkingPayExcelServiceImpl implements ParkingPayExcelService {
    @Autowired
    JdbcTemplate jdbcTemplate;
    private static Logger log = LoggerFactory.getLogger(ParkingPayExcelServiceImpl.class);
    @Override
    public List<ParkingPayExcelJson> findAll(BaseExcelForm form) {
        log.error("beginTime:"+form.getBeginTime());
        log.error("endTime:"+form.getEndTime());
        StringBuffer sql = new StringBuffer();
        sql.append(" select b.name,a.car_number as carNumber, a.in_time as inTime, a.created_time as createdTime,  ");
        sql.append(" a.pay_able as payAble, a.coupon_amount as couponAmount, a.pay_amount as payAmount from ");
        sql.append(" by_parking_pay_history a, by_member b where a.member_id = b.id ");
        sql.append(" and a.created_time <=? and a.created_time>=? ");
        Object[] params = new Object[]{form.getEndTime(), form.getBeginTime()};
        List<ParkingPayExcelJson> results = jdbcTemplate.query(sql.toString(), params, new BeanPropertyRowMapper<>((ParkingPayExcelJson.class)));
        return results;
    }
}
