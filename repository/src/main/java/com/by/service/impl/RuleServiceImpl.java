package com.by.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import com.by.json.ShopRuleJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.by.form.BaseCouponForm;
import com.by.model.Rule;
import com.by.repository.RuleRepository;
import com.by.service.RuleService;
import com.by.typeEnum.CouponAdminStateEnum;
import com.by.typeEnum.ValidEnum;

/**
 * Created by yagamai on 15-11-26.
 */
@Service
@Transactional
public class RuleServiceImpl implements RuleService {
	@Autowired
	private RuleRepository repository;
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Override
	@CachePut({ "ruleCard" })
	public Rule save(Rule rule) {
		return repository.save(rule);
	}

	@Override
	@CacheEvict({ "ruleCard" })
	public Rule update(Rule rule) {
		Rule source = repository.findOne(rule.getId());
		source.setBeginTime(rule.getBeginTime());
		return source;
	}
	public Page<ShopRuleJson> findAll(BaseCouponForm form, Pageable pageable) {
		//准备查询参数
		String name = form.getName() == null ? "%%" : "%" + form.getName() + "%";
		String beginTime = getBeginCalendar(form.getBeginTime());
		String endTime = getEndCalendar(form.getEndTime());
		int index = pageable.getPageNumber() <= 0 ? 0 : (pageable.getPageNumber()) * 10;
		//分页查询
		StringBuffer sql = new StringBuffer();
		sql.append(" select a.id,a.name as ruleName,a.beginTime as beginTime,a.endTime as endTime, ");
		sql.append(" a.valid as valid ");
		sql.append(" from by_rule a ");
		sql.append(" where a.type = 's' and a.name like ? ");
		sql.append(" and (a.beginTime <= ? and a.endTime >= ? or a.beginTime is null) order by a.name,a.beginTime desc limit ?,10 ");
		//查询总条数
		StringBuffer sqlCount = new StringBuffer();
		sqlCount.append(" select count(1) ");
		sqlCount.append(" from by_rule a ");
		sqlCount.append(" where a.type = 's' and a.name like ? ");
		sqlCount.append(" and (a.beginTime <= ? and a.endTime >= ? or a.beginTime is null) order by a.name,a.beginTime desc ");
		Object[] params = new Object[]{name, endTime, beginTime, index};
		Object[] paramsCount = new Object[]{name, endTime, beginTime};
		Integer count = jdbcTemplate.queryForObject(sqlCount.toString(), paramsCount, (Integer.class));
		List<ShopRuleJson> results = jdbcTemplate.query(sql.toString(), params, new BeanPropertyRowMapper<>((ShopRuleJson.class)));
		results = results.stream().map(i -> i.toJson()).collect(Collectors.toList());
		return new PageImpl<>(results, pageable, count);
	}
	@Override
	public <T extends Rule> List<Predicate> getPredicateList(BaseCouponForm form, Root<T> root, CriteriaBuilder cb) {
		List<Predicate> criteria = new ArrayList<>();
		if (form.getState() != null) {
			Calendar today = Calendar.getInstance();
			if (form.getState().equals(CouponAdminStateEnum.CLOSED)) {
				criteria.add(cb.equal(root.get("valid"), ValidEnum.INVALID));
			} else if (form.getState().equals(CouponAdminStateEnum.NOEXPIRE)) {
				criteria.add(cb.greaterThan(root.get("beginTime"), today));
				criteria.add(cb.and(cb.equal(root.get("valid"), ValidEnum.VALID)));
			} else if (form.getState().equals(CouponAdminStateEnum.USING)) {
				criteria.add(cb.or(
						cb.and(cb.lessThanOrEqualTo(root.get("beginTime"), today),
								cb.greaterThanOrEqualTo(root.get("endTime"), today)),
						cb.and(cb.isNull(root.get("beginTime"))), cb.isNull(root.get("endTime"))));
				criteria.add(cb.and(cb.equal(root.get("valid"), ValidEnum.VALID)));
			} else if (form.getState().equals(CouponAdminStateEnum.EXPIRE)) {
				criteria.add(cb.lessThan(root.get("endTime"), today));
				criteria.add(cb.and(cb.notEqual(root.get("valid"), ValidEnum.INVALID)));
			}
		}
		if (form.getBeginTime() != null) {
			criteria.add(cb.or(cb.greaterThanOrEqualTo(root.get("beginTime"), form.getBeginTime()),
					cb.isNull(root.get("endTime"))));
		}
		if (form.getEndTime() != null) {
			criteria.add(cb.or(cb.lessThanOrEqualTo(root.get("beginTime"), form.getEndTime()),
					cb.isNull(root.get("endTime"))));
		}
		return criteria;
	}

	@Override
	@Transactional(readOnly = true)
	public Long countByName(String name) {
		return repository.countByName(name);
	}

	@Override
	@Transactional(readOnly = true)
	public Rule findByName(String name) {
		return repository.findByName(name);
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

}
