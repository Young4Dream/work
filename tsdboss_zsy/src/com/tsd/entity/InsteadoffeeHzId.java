package com.tsd.entity;

import java.math.BigDecimal;

/**
 * InsteadoffeeHzId entity. @author MyEclipse Persistence Tools
 */

public class InsteadoffeeHzId implements java.io.Serializable {

	// Fields

	private String dh;
	private BigDecimal itemid;

	// Constructors

	/** default constructor */
	public InsteadoffeeHzId() {
	}

	/** full constructor */
	public InsteadoffeeHzId(String dh, BigDecimal itemid) {
		this.dh = dh;
		this.itemid = itemid;
	}

	// Property accessors

	public String getDh() {
		return this.dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public BigDecimal getItemid() {
		return this.itemid;
	}

	public void setItemid(BigDecimal itemid) {
		this.itemid = itemid;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof InsteadoffeeHzId))
			return false;
		InsteadoffeeHzId castOther = (InsteadoffeeHzId) other;

		return ((this.getDh() == castOther.getDh()) || (this.getDh() != null
				&& castOther.getDh() != null && this.getDh().equals(
				castOther.getDh())))
				&& ((this.getItemid() == castOther.getItemid()) || (this
						.getItemid() != null && castOther.getItemid() != null && this
						.getItemid().equals(castOther.getItemid())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + (getDh() == null ? 0 : this.getDh().hashCode());
		result = 37 * result
				+ (getItemid() == null ? 0 : this.getItemid().hashCode());
		return result;
	}

}