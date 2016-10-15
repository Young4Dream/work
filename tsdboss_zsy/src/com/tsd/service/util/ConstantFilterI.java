package com.tsd.service.util;

import java.util.List;


public interface ConstantFilterI {
	/**
	 * 一般过滤
	 * */
	public abstract String originalFilter(List tablelist);
	
	/**
	 * 两表关联过滤
	 * */
	public abstract String associationFilter(List tablelist,String params);
	
	/**
	 * 地址库
	 * */
	public abstract String addressFilter(List tablelist,String params);
	
	/**
	 * 部门过滤
	 * */
	public abstract String departmentFilter(List tablelist,String params);
}
