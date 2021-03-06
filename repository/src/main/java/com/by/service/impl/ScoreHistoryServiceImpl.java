package com.by.service.impl;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import com.by.json.DailyParkScoreUseJson;
import com.by.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.by.json.ScoreHistoryJson;
import com.by.model.Member;
import com.by.model.ScoreHistory;
import com.by.repository.ScoreHistoryRepository;
import com.by.service.ScoreHistoryService;
import com.by.typeEnum.ScoreHistoryEnum;

@Service
@Transactional
public class ScoreHistoryServiceImpl implements ScoreHistoryService {
    @Autowired
    private ScoreHistoryRepository repository;

    @Override
    public ScoreHistory save(ScoreHistory history) {
        return repository.save(history);
    }

    @Override
    public ScoreHistory save(Member member, int score, String reason,ScoreHistoryEnum type) {
        ScoreHistory history = new ScoreHistory();
        history.setMember(member);
        history.setDeposit(score);
        history.setReason(reason);
        history.setType(type);
        return repository.save(history);
    }
    
    @Override
       public ScoreHistory save(Member member, int score, String reason,ScoreHistoryEnum type, String remark, String tradeNo, String operator) {
        ScoreHistory history = new ScoreHistory();
        history.setMember(member);
        history.setDeposit(score);
        history.setReason(reason);
        history.setType(type);
        history.setRemark(remark);
        history.setTradeno(tradeNo);
        history.setOperator(operator);
        return repository.save(history);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ScoreHistory> findByMember(Member member, Pageable pageable) {
        return repository.findByMember(member, pageable);
    }

    @Override
    public Page<ScoreHistoryJson> findByMemberJson(Member member, Pageable pageable) {
        Page<ScoreHistory> histories = repository.findByMember(member, pageable);
        List<ScoreHistoryJson> json = histories.getContent().stream().map(i -> {
            return new ScoreHistoryJson(i.getId(), i.getCreatedTime(), i.getDeposit(), i.getReason(), i.getOperator());
        }).collect(Collectors.toList());
        return new PageImpl<ScoreHistoryJson>(json, pageable, histories.getTotalElements());
    }

    @Override
    public List<ScoreHistory> findByMember(Member member) {
        return repository.findByMember(member);
    }

    @Override
    public void deleteByMember(Member member) {
        repository.deleteByMember(member);
    }

    @Override
    public void deleteAll() {
        repository.deleteAll();
    }

    @Override
    public ScoreHistory findByType(ScoreHistoryEnum type) {
        return repository.findByType(type);
    }


    @Override
    public List<Object[]> findParkExchangeDepositeToday(Member member) {
        return repository.findParkExchangeDepositeToday(member, DateUtil.getDateStartCalendar(new Date()), DateUtil.getDateEndCalendar(new Date()));
    }
}
