package com.tsd.entity;

import java.util.Date;

/**
 * HfhzLog entity. @author MyEclipse Persistence Tools
 */

public class HfhzLog implements java.io.Serializable {

	// Fields

	private Date lgTime;
	private String lgProc;
	private String lgDesc;
	private String lgUserid;
	private String lgSystem;
	
	public HfhzLog(){
		
	}
	public HfhzLog(String lgDesc, String lgProc, String lgUserid,
			String lgSystem) {
		super();
		this.lgDesc = lgDesc;
		this.lgProc = lgProc;
		this.lgUserid = lgUserid;
		this.lgSystem = lgSystem;
	}
	public Date getLgTime() {
		return lgTime;
	}
	public void setLgTime(Date lgTime) {
		this.lgTime = lgTime;
	}
	public String getLgDesc() {
		return lgDesc;
	}
	public void setLgDesc(String lgDesc) {
		this.lgDesc = lgDesc;
	}
	public String getLgProc() {
		return lgProc;
	}
	public void setLgProc(String lgProc) {
		this.lgProc = lgProc;
	}
	public String getLgUserid() {
		return lgUserid;
	}
	public void setLgUserid(String lgUserid) {
		this.lgUserid = lgUserid;
	}
	public String getLgSystem() {
		return lgSystem;
	}
	public void setLgSystem(String lgSystem) {
		this.lgSystem = lgSystem;
	}

	
}