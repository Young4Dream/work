package com.tsd.domain;

import java.util.Date;

/**
 * 套餐业务表
* <p>Title: PackageBusiness</p>
* <p>Description: create PackageBusiness</p>
* <p>Company: tsd</p> 
* @author mingliang
* @date Nov 24, 2015 / 5:47:32 PM
 */
public class PackageBusiness {
	
	//主键
	private int id;
	
	//套餐业务类型名称
	private String pbName;

	//业务ID OCS_BUSINESS_DIC主键ID
	private int bid;

	//业务参数ID OCS_BUSINESS_CONFIG主键ID
	private int cid;

	//业务计费单位
	private int businessUnit;

	//业务计费单位显示中文
	private String businessUnitTmp;
	
	//业务计费单位数量
	private int businessNum;

	//业务计费单位显示值
	private String businessView;
	
	//费率成本
	private double costPrice;
	
	//状态
	private int status;
	
	//创建时间
	private Date createTime;
	
	//修改时间
	private Date updateTime;
	
	//备注
	private String remark;

	//业务类别
	private int bType;
	
	public int getBType() {
		return bType;
	}

	public void setBType(int type) {
		bType = type;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPbName() {
		return pbName;
	}

	public void setPbName(String pbName) {
		this.pbName = pbName;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getBusinessUnit() {
		return businessUnit;
	}

	public void setBusinessUnit(int businessUnit) {
		this.businessUnit = businessUnit;
	}

	public String getBusinessUnitTmp() {
		return businessUnitTmp;
	}

	public void setBusinessUnitTmp(String businessUnitTmp) {
		this.businessUnitTmp = businessUnitTmp;
	}

	public int getBusinessNum() {
		return businessNum;
	}

	public void setBusinessNum(int businessNum) {
		this.businessNum = businessNum;
	}

	public String getBusinessView() {
		return businessView;
	}

	public void setBusinessView(String businessView) {
		this.businessView = businessView;
	}

	public double getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(double costPrice) {
		this.costPrice = costPrice;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
