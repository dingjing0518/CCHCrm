package com.by.service.impl;

import com.by.exception.Status;
import com.by.exception.Success;
import com.by.form.BaseCouponForm;
import com.by.json.ShopRuleJson;
import com.by.model.Shop;
import com.by.model.ShopRule;
import com.by.repository.ShopRepository;
import com.by.repository.ShopRuleRepository;
import com.by.service.RuleService;
import com.by.service.ShopRuleService;
import com.by.typeEnum.ValidEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by yagamai on 15-12-22.
 */
@Service
@Transactional
public class ShopRuleServiceImpl implements ShopRuleService {
    @Autowired
    private EntityManager em;
    @Autowired
    private RuleService ruleService;
    @Autowired
    private ShopRuleRepository repository;

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Autowired
    ShopRepository shopRepository;

    @Override
    public Page<ShopRuleJson> findAll(BaseCouponForm form, Pageable pageable) {
        //准备查询参数
        String name = form.getName() == null ? "%%" : "%" + form.getName() + "%";
        String beginTime = getBeginCalendar(form.getBeginTime());
        String endTime = getEndCalendar(form.getEndTime());
        int index = pageable.getPageNumber() <= 0 ? 0 : (pageable.getPageNumber()) * 10;
        //分页查询
        StringBuffer sql = new StringBuffer();
        sql.append(" select b.id,c.name as shopName,b.name as ruleName,b.beginTime as beginTime,b.endTime as endTime, ");
        sql.append(" b.valid as valid ");
        sql.append(" from by_shop_rule a left join by_rule b on a.rule_id = b.id ");
        sql.append(" left join by_shop c on a.shop_id = c.id where b.type = 's' and c.name like ? ");
        sql.append(" and (b.beginTime <= ? and b.endTime >= ? or b.beginTime is null) order by c.name,b.beginTime desc limit ?,10 ");
        //查询总条数
        StringBuffer sqlCount = new StringBuffer();
        sqlCount.append(" select count(1) ");
        sqlCount.append(" from by_shop_rule a left join by_rule b on a.rule_id = b.id ");
        sqlCount.append(" left join by_shop c on a.shop_id = c.id where b.type = 's' and c.name like ? ");
        sqlCount.append(" and (b.beginTime <= ? and b.endTime >= ? or b.beginTime is null) order by c.name,b.beginTime desc ");
        Object[] params = new Object[]{name, endTime, beginTime, index};
        Object[] paramsCount = new Object[]{name, endTime, beginTime};
        Integer count = jdbcTemplate.queryForObject(sqlCount.toString(), paramsCount, (Integer.class));
        List<ShopRuleJson> results = jdbcTemplate.query(sql.toString(), params, new BeanPropertyRowMapper<>((ShopRuleJson.class)));
        results = results.stream().map(i -> i.toJson()).collect(Collectors.toList());
        return new PageImpl<>(results, pageable, count);
    }

    /**
     * 获取最大(年月日)的Calendar
     *
     * @param endTime
     * @return
     */
    public static String getEndCalendar(Calendar endTime) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null == endTime) {
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, 9999);
            calendar.set(Calendar.MONTH, calendar.getActualMaximum(Calendar.MONTH));
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            endTime = calendar;
        }
        return simpleDateFormat.format(endTime.getTime());
    }

    /**
     * 获取最小(年月日)的Calendar
     *
     * @param beginTime
     * @return
     */
    public static String getBeginCalendar(Calendar beginTime) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null == beginTime) {
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, calendar.getActualMinimum(Calendar.YEAR));
            calendar.set(Calendar.MONTH, calendar.getActualMinimum(Calendar.MONTH));
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
            beginTime = calendar;
        }
        return simpleDateFormat.format(beginTime.getTime());
    }

    @Override
    @Transactional(readOnly = true)
    public ShopRule findOne(int id) {
        return repository.findOne(id);
    }

    @Override
    public ShopRule update(ShopRule r) {
        ShopRule rule = repository.findOne(r.getId());
        rule.setName(r.getName());
        rule.setBeginTime(r.getBeginTime());
        rule.setEndTime(r.getEndTime());
        rule.setRate(r.getRate());
        rule.setScore(r.getScore());
        rule.setShops(r.getShops());
        rule.setUpdatedBy(r.getUpdatedBy());
        if (r.getScore() == null)
            r.setScore(0);
        if (r.getRate() == null)
            r.setRate(0.0);
        return rule;
    }

    @Override
    public ShopRule save(ShopRule r) {
        r.setValid(ValidEnum.VALID);
        if (r.getScore() == null)
            r.setScore(0);
        if (r.getRate() == null)
            r.setRate(0.0);
        return repository.save(r);
    }

    @Override
    public Status valid(int id) {
        ShopRule r = repository.findOne(id);
        if (r.getValid().equals(ValidEnum.INVALID)) {
            //长期有效规则
            if (r.getBeginTime() == null && r.getEndTime() == null) {
                r.setValid(ValidEnum.VALID);
            } else {
                // 未到生效期的以及在生效范围内的可以被开启或关闭
                Calendar today = Calendar.getInstance();
                if (r.getBeginTime().before(today) && r.getEndTime().after(today))
                    r.setValid(ValidEnum.VALID);
                if (r.getBeginTime().after(today) && r.getEndTime().after(today))
                    r.setValid(ValidEnum.VALID);
            }
        } else
            r.setValid(ValidEnum.INVALID);
        return new Success<String>("success");
    }
}
