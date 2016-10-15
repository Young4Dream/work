/*****************************************************************
 * name: DataObj.java
 * author: 
 * version: 
 * description: 数据对象，用来存放数据库中表的一个字段的名称与值
 * modify: 2010-11-19 luoyulong 添加注释
 *****************************************************************/
package com.tsd.dao;

import com.tsd.service.util.HTMLFilter;
/**
 * 数据对象，用来存放数据库中一个字段的名称与值
 */
public class DataObj {
	private String dataName;
	private Object dataVal;

	/**
	 * 获得字段名称
	 * @return 字段名
	 */
	public String getDataName() {
		return dataName;
	}

	/**
	 * 设置字段名称
	 * @param dataName 要设置的字段名称
	 */
	public void setDataName(String dataName) {
		this.dataName = dataName.toLowerCase();// 强制转换成全小写的列名
	}

	/**
	 * 获取字段的值
	 * @return 字段值
	 */
	public Object getDataVal() {
		return dataVal == null ? "" : HTMLFilter.filter(dataVal.toString());// 过滤null为空白字符
	}

	/**
	 * 设置字段值
	 * @param dataVal 字段值
	 */
	public void setDataVal(Object dataVal) {
		this.dataVal = dataVal;
	}

}
