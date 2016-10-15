package com.tsd.entity;

import java.util.Date;

/**
 * HfintimeHz entity. @author MyEclipse Persistence Tools
 */

public class HfintimeHz implements java.io.Serializable {

	// Fields

	private String dh;
	private String feeType;
	private int dhid;
	private int startmonth;
	private int endmonth;
	private Date startdate;
	private Date enddate;
	private int id_1;
	private String operid;
	private Date opertime;

	// Constructors

	/** default constructor */
	public HfintimeHz() {
	}

	/** minimal constructor */
	public HfintimeHz(String dh, String feeType, int dhid, int startmonth,
			int endmonth, Date opertime) {
		this.dh = dh;
		this.feeType = feeType;
		this.dhid = dhid;
		this.startmonth = startmonth;
		this.endmonth = endmonth;
		this.opertime = opertime;
	}

	/** full constructor */
	public HfintimeHz(String dh, String feeType, int dhid, int startmonth,
			int endmonth, Date startdate, Date enddate, int id_1,
			String operid, Date opertime) {
		this.dh = dh;
		this.feeType = feeType;
		this.dhid = dhid;
		this.startmonth = startmonth;
		this.endmonth = endmonth;
		this.startdate = startdate;
		this.enddate = enddate;
		this.id_1 = id_1;
		this.operid = operid;
		this.opertime = opertime;
	}

	// Property accessors
	public int getDhid() {
		return this.dhid;
	}

	public void setDhid(int dhid) {
		this.dhid = dhid;
	}

	public int getStartmonth() {
		return this.startmonth;
	}

	public void setStartmonth(int startmonth) {
		this.startmonth = startmonth;
	}

	public int getEndmonth() {
		return this.endmonth;
	}

	public void setEndmonth(int endmonth) {
		this.endmonth = endmonth;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public int getId_1() {
		return this.id_1;
	}

	public void setId_1(int id_1) {
		this.id_1 = id_1;
	}

	public String getOperid() {
		return this.operid;
	}

	public void setOperid(String operid) {
		this.operid = operid;
	}

	public Date getOpertime() {
		return this.opertime;
	}

	public void setOpertime(Date opertime) {
		this.opertime = opertime;
	}

	public String getDh() {
		return dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public String getFeeType() {
		return feeType;
	}

	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}

	@Override
	public String toString() {
		return "HfintimeHz [dh=" + dh + ", feeType=" + feeType + ", dhid="
				+ dhid + ", startmonth=" + startmonth + ", endmonth="
				+ endmonth + ", startdate=" + startdate + ", enddate="
				+ enddate + ", id_1=" + id_1 + ", operid=" + operid
				+ ", opertime=" + opertime + "]";
	}

}