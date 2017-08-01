package com.by.service;

import com.by.form.BaseCouponForm;
import com.by.json.ShopRuleJson;
import com.by.model.Rule;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

/**
 * Created by yagamai on 15-11-26.
 */
public interface RuleService {
	Page<ShopRuleJson> findAll(BaseCouponForm form, Pageable pageable);

	Rule save(Rule rule);

	Rule update(Rule rule);

	Long countByName(String name);

	Rule findByName(String name);

	<T extends Rule> List<Predicate> getPredicateList(BaseCouponForm form, Root<T> root, CriteriaBuilder cb);
}
