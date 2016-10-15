package com.tsd.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * InsteadoffeeHz entity. @author MyEclipse Persistence Tools
 */

public class InsteadoffeeHz implements java.io.Serializable {

	// Fields

	private String dh;
	private int itemid;
	private String hth;
	private String insteadhth;
	private Double fee;
	private int rate;
	private String operid;
	private Date bdate;
	private String insteaddh;

	// Constructors

	/** default constructor */
	public InsteadoffeeHz() {
	}

	/** minimal constructor */
	public InsteadoffeeHz(String dh, int itemid, String hth, String insteadhth,
			Double fee, int rate) {
		this.dh = dh;
		this.itemid = itemid;
		this.hth = hth;
		this.insteadhth = insteadhth;
		this.fee = fee;
		this.rate = rate;
	}

	/** full constructor */
	public InsteadoffeeHz(String dh, int itemid, String hth, String insteadhth,
			Double fee, int rate, String operid, Date bdate, String insteaddh) {
		this.dh = dh;
		this.itemid = itemid;
		this.hth = hth;
		this.insteadhth = insteadhth;
		this.fee = fee;
		this.rate = rate;
		this.operid = operid;
		this.bdate = bdate;
		this.insteaddh = insteaddh;
	}

	// Property accessors

	public String getHth() {
		return this.hth;
	}

	public void setHth(String hth) {
		this.hth = hth;
	}

	public String getInsteadhth() {
		return this.insteadhth;
	}

	public void setInsteadhth(String insteadhth) {
		this.insteadhth = insteadhth;
	}

	public Double getFee() {
		return this.fee;
	}

	public void setFee(Double fee) {
		this.fee = fee;
	}

	public int getRate() {
		return this.rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public String getOperid() {
		return this.operid;
	}

	public void setOperid(String operid) {
		this.operid = operid;
	}

	public Date getBdate() {
		return this.bdate;
	}

	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}

	public String getInsteaddh() {
		return this.insteaddh;
	}

	public void setInsteaddh(String insteaddh) {
		this.insteaddh = insteaddh;
	}

	public String getDh() {
		return dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public int getItemid() {
		return itemid;
	}

	public void setItemid(int itemid) {
		this.itemid = itemid;
	}

	@Override
	public String toString() {
		return "InsteadoffeeHz [dh=" + dh + ", itemid=" + itemid + ", hth="
				+ hth + ", insteadhth=" + insteadhth + ", fee=" + fee
				+ ", rate=" + rate + ", operid=" + operid + ", bdate=" + bdate
				+ ", insteaddh=" + insteaddh + "]";
	}

}