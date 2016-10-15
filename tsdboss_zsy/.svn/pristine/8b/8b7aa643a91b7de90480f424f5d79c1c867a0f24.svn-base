package com.tsd.domain;

import java.util.Date;

/**
 * 套餐主表
* <p>Title: PackageMain</p>
* <p>Description: create PackageMain</p>
* <p>Company: tsd</p> 
* @author yinyuelin
* @date Nov 20, 2015 / 5:47:32 PM
 */
public class PackageMain {

	//主键
	private int id;
	
	//套餐包名称
	private String packageName;
	
	//套餐包类型 关联联套餐计划类型字典表OCS_PACKAGE_TYPE_DICT中的ID字段
	private int packageType;
	
	private String packageTypeName;
	
	//套餐计划固定费
	private double packageFee;
	
	//费率套餐状态 1、创建 	2、已发布 3、下线
	private int packageStatus;
	
	//套餐包月费免费期数
	private int pagFreeNum;
	
	//赠送礼品
	private int gid;
	
	//创建时间
	private Date createTime;
	
	//修改时间
	private Date updateTime;
	
	//套餐描述
	private String remark;

	//运营商 1；电信；2：联通；3：内部
	private int operator;
	
	// 服务种类，如电话，宽带，专线
	private String serviceType;
	// 子服务种类，如专线又分为E1，EPON，光芯等
	private String subServiceType;
	
	public int getOperator() {
		return operator;
	}

	public void setOperator(int operator) {
		this.operator = operator;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public int getPackageType() {
		return packageType;
	}

	public void setPackageType(int packageType) {
		this.packageType = packageType;
	}

	public double getPackageFee() {
		return packageFee;
	}

	public void setPackageFee(double packageFee) {
		this.packageFee = packageFee;
	}

	public int getPackageStatus() {
		return packageStatus;
	}

	public void setPackageStatus(int packageStatus) {
		this.packageStatus = packageStatus;
	}

	public int getPagFreeNum() {
		return pagFreeNum;
	}

	public void setPagFreeNum(int pagFreeNum) {
		this.pagFreeNum = pagFreeNum;
	}

	public int getGid() {
		return gid;
	}

	public void setGid(int gid) {
		this.gid = gid;
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

	public String getPackageTypeName() {
		return packageTypeName;
	}

	public void setPackageTypeName(String packageTypeName) {
		this.packageTypeName = packageTypeName;
	}
	
	public String getServiceType() {
		return this.serviceType;
	}
	
	public void setServiceType(String val) {
		this.serviceType = val;
	}
	
	public String getSubServiceType() {
		return this.subServiceType;
	}
	
	public void setSubServiceType(String val) {
		this.subServiceType = val;
	}
}
