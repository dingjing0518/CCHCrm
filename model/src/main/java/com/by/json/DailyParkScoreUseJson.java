package com.by.json;

/**
 * @author carl
 */
public class DailyParkScoreUseJson {
	private String license;
	private int score;

	public DailyParkScoreUseJson() {

	}

	public DailyParkScoreUseJson(String license, int score) {
		super();
		this.license = license;
		this.score = score;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}
}
