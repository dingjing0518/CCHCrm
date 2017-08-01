package com.by.service;

import java.util.List;

import com.by.json.DailyParkScoreUseJson;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.by.json.ScoreHistoryJson;
import com.by.model.Member;
import com.by.model.ScoreHistory;
import com.by.typeEnum.ScoreHistoryEnum;

public interface ScoreHistoryService {
	ScoreHistory save(ScoreHistory history);

	ScoreHistory save(Member member, int score, String reason, ScoreHistoryEnum type);
	
	ScoreHistory save(Member member, int score, String reason, ScoreHistoryEnum type, String remark, String tradeNo, String operator);

	Page<ScoreHistory> findByMember(Member member, Pageable pageable);

	Page<ScoreHistoryJson> findByMemberJson(Member member, Pageable pageable);

	List<ScoreHistory> findByMember(Member member);

	List<Object[]> findParkExchangeDepositeToday(Member member);

	void deleteByMember(Member member);

	void deleteAll();

	ScoreHistory findByType(ScoreHistoryEnum type);
}
