package com.by.repository;

import com.by.json.DailyParkScoreUseJson;
import com.by.model.Member;
import com.by.model.ScoreHistory;
import com.by.typeEnum.ScoreHistoryEnum;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.Calendar;
import java.util.List;

public interface ScoreHistoryRepository extends PagingAndSortingRepository<ScoreHistory, Long> {
    Page<ScoreHistory> findByMember(Member member, Pageable pageable);

    List<ScoreHistory> findByMember(Member member);

    void deleteByMember(Member member);

    @Query("select sum(t.deposit) as score, t.remark as license from ScoreHistory t where t.member = :member and t.createdTime >= :start and t.createdTime <= :end and t.type=6 group by t.member,t.remark")
    List<Object[]> findParkExchangeDepositeToday(@Param("member") Member member, @Param("start") Calendar start , @Param("end") Calendar end);

    ScoreHistory findByType(ScoreHistoryEnum type);
}
