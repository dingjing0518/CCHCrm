package com.by.model;

import java.util.List;

import com.by.json.CardTypeJson;

/**
 * Created by yagamai on 15-12-25.
 */
public class MemberStatics {
	private int cardId;
	private String cardName;
	private String createdTime;
	private double amount;
	private int count;
	private int sumScore;
	private int availableScore;
	private List<CardTypeJson> cardTypeList;

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(String createdTime) {
		this.createdTime = createdTime;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getSumScore() {
		return sumScore;
	}

	public void setSumScore(int sumScore) {
		this.sumScore = sumScore;
	}

	public int getAvailableScore() {
		return availableScore;
	}

	public void setAvailableScore(int availableScore) {
		this.availableScore = availableScore;
	}

	public int getCardId() {
		return cardId;
	}

	public void setCardId(int cardId) {
		this.cardId = cardId;
	}

	/**
	
	 * getter method
	
	 * @return the cardTypeList
	
	 */
	
	public List<CardTypeJson> getCardTypeList() {
		return cardTypeList;
	}

	/**
	
	 * setter method
	
	 * @param cardTypeList the cardTypeList to set
	
	 */
	
	public void setCardTypeList(List<CardTypeJson> cardTypeList) {
		this.cardTypeList = cardTypeList;
	}

	

}
