package com.by.json;

import com.by.model.Card;

public class CardTypeJson {
	private int id;
	private String name;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public CardTypeJson() {
	}

	public CardTypeJson(Card card) {
		this.id = card.getId();
		this.name = card.getName();
	}
}
