package com.by.model;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;

@Entity
@DiscriminatorValue("p")
public class ParkingDetailContent extends Content {
	@OneToOne(fetch = FetchType.LAZY, mappedBy = "content")
	private ParkingDetail detial;

	public ParkingDetail getDetial() {
		return detial;
	}

	public void setDetial(ParkingDetail detial) {
		this.detial = detial;
	}

}
