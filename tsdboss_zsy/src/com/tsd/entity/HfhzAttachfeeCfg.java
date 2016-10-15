package com.tsd.entity;

/**
 * HfhzAttachfeeCfg entity. @author MyEclipse Persistence Tools
 */

public class HfhzAttachfeeCfg implements java.io.Serializable {

	// Fields

	private String busitype;
	private int feecode;
	private int cfg_Code;
	private int day_From;
	private int day_End;
	private double rate;
	private String sql1;
	private String bz;
	private int xuhao;
	
	public String getBusitype() {
		return busitype;
	}
	public void setBusitype(String busitype) {
		this.busitype = busitype;
	}
	public int getFeecode() {
		return feecode;
	}
	public void setFeecode(int feecode) {
		this.feecode = feecode;
	}
	public int getCfg_Code() {
		return cfg_Code;
	}
	public void setCfg_Code(int cfg_Code) {
		this.cfg_Code = cfg_Code;
	}
	public int getDay_From() {
		return day_From;
	}
	public void setDay_From(int day_From) {
		this.day_From = day_From;
	}
	public int getDay_End() {
		return day_End;
	}
	public void setDay_End(int day_End) {
		this.day_End = day_End;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public String getSql1() {
		return sql1;
	}
	public void setSql1(String sql1) {
		this.sql1 = sql1;
	}
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}
	public int getXuhao() {
		return xuhao;
	}
	public void setXuhao(int xuhao) {
		this.xuhao = xuhao;
	}
	@Override
	public String toString() {
		return "HfhzAttachfeeCfg [busitype=" + busitype + ", feecode="
				+ feecode + ", cfg_Code=" + cfg_Code + ", day_From=" + day_From
				+ ", day_End=" + day_End + ", rate=" + rate + ", sql1=" + sql1
				+ ", bz=" + bz + ", xuhao=" + xuhao + "]";
	}


}