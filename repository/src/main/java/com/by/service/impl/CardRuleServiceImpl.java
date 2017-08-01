package com.by.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;

import com.by.form.BaseCouponForm;
import com.by.json.CardRuleJson;
import com.by.json.ShopRuleJson;
import com.by.repository.CardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CachePut;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.by.json.RuleJson;
import com.by.model.Card;
import com.by.model.CardRule;
import com.by.model.RuleCategory;
import com.by.repository.CardRuleRepository;
import com.by.service.CardRuleService;
import com.by.service.RuleService;
import com.by.typeEnum.ValidEnum;

/**
 * Created by yagamai on 15-12-15.
 */
@Service
@Transactional
public class CardRuleServiceImpl implements CardRuleService {
    @Autowired
    private CardRuleRepository repository;
    @Autowired
    private CardRepository cardRepository;
    @Autowired
    private EntityManager em;
    @Autowired
    private RuleService ruleService;
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public List<CardRule> findByRuleCategoryAndCardAndValid(RuleCategory category, Card card, ValidEnum valid) {
        return repository.findByRuleCategoryAndCardAndValid(category, card, ValidEnum.VALID);
    }

    @Override
    public List<CardRule> findByRuleCategoryAndCard(RuleCategory category, Card card) {
        return repository.findByRuleCategoryAndCard(category, card);
    }

    @Override
    public CardRule save(CardRule rule) {
        return repository.save(rule);
    }

    @Override
    public CardRule findOne(int id) {
        return repository.findOne(id);
    }

    @Override
    @CachePut(value = "rule", key = "#cardRule.id")
    public CardRule update(CardRule cardRule) {
        CardRule rule = repository.findOne(cardRule.getId());
        rule.setCard(cardRule.getCard());
        rule.setName(cardRule.getName());
        rule.setBeginTime(cardRule.getBeginTime());
        rule.setEndTime(cardRule.getEndTime());
        rule.setUpdatedBy(cardRule.getUpdatedBy());
        rule.setRate(cardRule.getRate());
        rule.setScore(cardRule.getScore());
        return rule;
    }

    @Override
    public CardRule valid(int id) {
        CardRule r = repository.findOne(id);
        vaildRuleUpdate(r);
        return r;
    }

    private void vaildRuleUpdate(CardRule r) {
        if (r.getValid().equals(ValidEnum.INVALID)) {
            //长期有效规则设定
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
    }

    @Override
    public Page<CardRuleJson> findAll(BaseCouponForm form, Pageable pageable) {
        //准备查询参数
        String name = form.getName() == null ? "%%" : "%" + form.getName() + "%";
        String cardName = form.getSecondName() == null ? "%%" : "%" + form.getSecondName() + "%";
        Calendar beginTime = getBeginCalendar(form.getBeginTime());
        Calendar endTime = getEndCalendar(form.getEndTime());

        int index = pageable.getPageNumber() <= 0 ? 0 : (pageable.getPageNumber()) * 10;
        //分页查询
        StringBuffer sql = new StringBuffer();
        sql.append(" select a.id,b.name as cardName,a.name as ruleName, ");
        sql.append(" b.valid as valid, ");
        sql.append(" a.beginTime,a.endTime from by_rule a left join by_card b on a.card_id = b.id ");
        sql.append(" where a.type = 'c' and  a.name like ? and b.name like ? and (a.beginTime <= ? ");
        sql.append(" and a.endTime >= ? or a.beginTime is null or b.name is null) ");
        sql.append(" order by b.name,a.beginTime desc limit ?,10 ");
        //查询总条数
        StringBuffer sqlCount = new StringBuffer();
        sqlCount.append(" select count(1) ");
        sqlCount.append(" from by_rule a left join by_card b on a.card_id = b.id ");
        sqlCount.append(" where a.type = 'c' and a.name like ? and b.name like ? and (a.beginTime <= ? ");
        sqlCount.append(" and a.endTime >= ? or a.beginTime is null or b.name is null) ");
        Object[] params = new Object[]{name, cardName, endTime, beginTime, index};
        Object[] paramsCount = new Object[]{name, cardName, endTime, beginTime};
        Integer count = jdbcTemplate.queryForObject(sqlCount.toString(), paramsCount, (Integer.class));
        List<CardRuleJson> results = jdbcTemplate.query(sql.toString(), params, new BeanPropertyRowMapper<>((CardRuleJson.class)));
        results = results.stream().map(i -> i.toJson()).collect(Collectors.toList());
        return new PageImpl<>(results, pageable, count);
    }

    /**
     * 获取最大(年月日)的Calendar
     *
     * @param endTime
     * @return
     */
    public static Calendar getEndCalendar(Calendar endTime) {
        if (null == endTime) {
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, 9999);
            calendar.set(Calendar.MONTH, calendar.getActualMaximum(Calendar.MONTH));
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            endTime = calendar;
        }
        return endTime;
    }

    /**
     * 获取最小(年月日)的Calendar
     *
     * @param beginTime
     * @return
     */
    public static Calendar getBeginCalendar(Calendar beginTime) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (null == beginTime) {
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, calendar.getActualMinimum(Calendar.YEAR));
            calendar.set(Calendar.MONTH, calendar.getActualMinimum(Calendar.MONTH));
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
            beginTime = calendar;
        }
        return beginTime;
    }

    @Override
    public Long countByName(String name) {
        return repository.countByName(name);
    }

    @Override
    public CardRule findByName(String name) {
        return repository.findByName(name);
    }
}
