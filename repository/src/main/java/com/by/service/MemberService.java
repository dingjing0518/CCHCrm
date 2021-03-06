package com.by.service;

import com.by.form.AdminMemberForm;
import com.by.json.MemberJson;
import com.by.model.Card;
import com.by.model.Member;
import com.by.model.ScoreAddHistory;
import com.by.typeEnum.ScoreHistoryEnum;
import com.by.typeEnum.ValidEnum;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface MemberService {
	Member findOne(Long id);

	Member findOneCache(Long id);

	Optional<Member> findById(Long id);

	Member findByName(String name);

	Long countByName(String name);

	Member save(Member member);

	Member minusScore(Member member, int total, String reason, ScoreHistoryEnum type, String remark, String tradeNo, String operator);
	
	Member minusScoreAll(Member member, int total, String reason, ScoreHistoryEnum type, String remark, String tradeNo, String operator);

	Member addScore(Member member, int total, String reason, ScoreHistoryEnum type);
	
	Member addScore(Member member, int total, String reason, ScoreHistoryEnum type, String remark, String tradeNo, String operator);

	List<ScoreAddHistory> extractScoreHistory(List<ScoreAddHistory> allList, int total);

	Page<MemberJson> findAll(AdminMemberForm form, Pageable pageable, ValidEnum valid);

	Long countByCard(Card card);

	Member validateOrInValidate(Member member, String name);

	void deleteAll();

	Member update(Member member);

	Member refresh(Long id);
}
