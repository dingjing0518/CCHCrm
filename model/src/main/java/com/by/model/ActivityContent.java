package com.by.model;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;

/**
 * Created by yagamai on 16-3-30.
 */
@Entity
@DiscriminatorValue("a")
public class ActivityContent extends Content {
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "content")
	private Activity activity;

	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}
}
