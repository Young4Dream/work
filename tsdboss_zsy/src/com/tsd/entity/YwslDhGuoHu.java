package com.tsd.entity;

import java.util.Date;

public class YwslDhGuoHu {

	private int ifguohu;
	private String kemu;
	private int hzyf;
	private String dh;
	private double btheji;
	private String oldhth;
	private String newhth;
	private int ghyf;
	private String operarea;
	private String operid;
	private Date opertime;
	
	public YwslDhGuoHu(){
		
	}
	
	public YwslDhGuoHu(int ifguohu, String kemu, int hzyf, String dh,
			double btheji, String oldhth, String newhth, int ghyf,
			String operarea, String operid, Date opertime) {
		super();
		this.ifguohu = ifguohu;
		this.kemu = kemu;
		this.hzyf = hzyf;
		this.dh = dh;
		this.btheji = btheji;
		this.oldhth = oldhth;
		this.newhth = newhth;
		this.ghyf = ghyf;
		this.operarea = operarea;
		this.operid = operid;
		this.opertime = opertime;
	}

	public int getIfguohu() {
		return ifguohu;
	}

	public void setIfguohu(int ifguohu) {
		this.ifguohu = ifguohu;
	}

	public String getKemu() {
		return kemu;
	}

	public void setKemu(String kemu) {
		this.kemu = kemu;
	}

	public int getHzyf() {
		return hzyf;
	}

	public void setHzyf(int hzyf) {
		this.hzyf = hzyf;
	}

	public String getDh() {
		return dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public double getBtheji() {
		return btheji;
	}

	public void setBtheji(double btheji) {
		this.btheji = btheji;
	}

	public String getOldhth() {
		return oldhth;
	}

	public void setOldhth(String oldhth) {
		this.oldhth = oldhth;
	}

	public String getNewhth() {
		return newhth;
	}

	public void setNewhth(String newhth) {
		this.newhth = newhth;
	}

	public int getGhyf() {
		return ghyf;
	}

	public void setGhyf(int ghyf) {
		this.ghyf = ghyf;
	}

	public String getOperarea() {
		return operarea;
	}

	public void setOperarea(String operarea) {
		this.operarea = operarea;
	}

	public String getOperid() {
		return operid;
	}

	public void setOperid(String operid) {
		this.operid = operid;
	}

	public Date getOpertime() {
		return opertime;
	}

	public void setOpertime(Date opertime) {
		this.opertime = opertime;
	}
	
	
	
}
