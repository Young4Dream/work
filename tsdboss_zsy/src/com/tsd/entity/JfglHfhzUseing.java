package com.tsd.entity;

import java.util.Date;
/**
 * 汇总过程被使用表
 * @author zxy
 */
public class JfglHfhzUseing {
    //工号
	private String userId;
	//汇总时间
	private Date hzTime;
	
	public JfglHfhzUseing() {
	}
	
	public JfglHfhzUseing(String userId, Date hzTime) {
		super();
		this.userId = userId;
		this.hzTime = hzTime;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getHzTime() {
		return hzTime;
	}
	public void setHzTime(Date hzTime) {
		this.hzTime = hzTime;
	}
}
