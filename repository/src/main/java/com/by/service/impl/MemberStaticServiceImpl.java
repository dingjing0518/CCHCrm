package com.by.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.by.exception.MemberNotFoundException;
import com.by.json.CardTypeJson;
import com.by.model.Card;
import com.by.model.Member;
import com.by.model.MemberStatics;
import com.by.service.CardService;
import com.by.service.MemberService;
import com.by.service.MemberStaticsService;
import com.by.service.TradingService;

/**
 * Created by yagamai on 15-12-25.
 */
@Service
@Transactional
public class MemberStaticServiceImpl implements MemberStaticsService {
	@Autowired
	private TradingService tradingService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private CardService cardService;

	@Override
	@Transactional(readOnly = true)
	public MemberStatics findOne(Member m) {
		Member member = memberService.findOne(m.getId());
		List<Card> cardList = cardService.findAllCache().stream().collect(Collectors.toList());
		List<CardTypeJson> cardTypeListJson = new ArrayList<CardTypeJson>();
		for (Card card : cardList) {
			cardTypeListJson.add(new CardTypeJson(card));
		}
		if (member == null)
			throw new MemberNotFoundException();
		Long amount = tradingService.sumAmountByMember(member);
		Long count = tradingService.countByMember(member);
		MemberStatics statics = new MemberStatics();
		if (amount != null)
			statics.setAmount(amount);
		else
			statics.setAmount(0);
		if (count != null)
			statics.setCount(count.intValue());
		else
			statics.setCount(0);
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		statics.setCreatedTime(format.format(member.getCreatedTime().getTime()));
		statics.setAvailableScore(member.getScore());
		statics.setSumScore(member.getSumScore());
		statics.setCardName(member.getCard().getName());
		statics.setCardId(member.getCard().getId());
		statics.setCardTypeList(cardTypeListJson);
		return statics;
	}
}
