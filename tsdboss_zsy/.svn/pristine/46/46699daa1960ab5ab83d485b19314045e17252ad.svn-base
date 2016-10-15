/*      						
 * Copyright 2015 Beijing T-star, Inc. All rights reserved.
 * 
 * History:
 * ------------------------------------------------------------------------------
 * Date    			|  		Who  			|  		What  
 * 2015-01-12		| 	 lihaitao 			| 	create the file                       
 */
package com.tsd.domain;

/**
 * 
 * 分页功能实体类
 * 
 * <p>
 * 	分页功能实体
 * </p> 
 * 
 * @author lihaitao
 * 
 */

public class PageObject{
	
	private int pageSize = 30; 		// 每页显示记录数
	
	private int currentPage = 1;	// 当前页码
	
	private int totalPage = 1;		// 总页数
	
	private int sumCloum = 0;		// 数据总数量
	
	private int offset = 0;			// 分页时需要偏移的数据总量(MySQL、PgSQL 等特殊数据库)

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getSumCloum() {
		return sumCloum;
	}

	public void setSumCloum(int sumCloum) {
		this.sumCloum = sumCloum;
		if(sumCloum > 0) {
			int totalPage = sumCloum/pageSize;
			this.setTotalPage(sumCloum % pageSize == 0 ? totalPage : totalPage + 1);
			this.getOffset();
		}
	}

	public int getOffset() {
		this.setOffset((currentPage-1)*pageSize);
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}
}
	
