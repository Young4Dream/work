package com.tsd.domain;

/**
 * 全局参数配置类
 * @author Administrator
 *
 */
public class OcsProfiles {

	//主键id
	private int id;
	
	//参数名 
	private String name;
	
	//参数值
	private String value;
	
	//配置时显示标题
	private String displayName;
	
	//是否可见 Y/N
	private String visible;
	
	//是否只读 Y/N
	private String readonly;
	
	//是否为密码 Y/N
	private String ispasswd;
	
	//正则表达式
	private String regex;
	
	//提示消息
	private String tips;
	
	//限制的最大输入字符长度
	private int maxlength;
	
	//是否为下拉框 Y/N
	private String isselect;
	
	//是否可为空 Y/N
	private String nullable;
	
	//下拉框中的信息
	private String dataDict;
	
	//如果是下拉框，下拉框改变后执行的onchange事件
	private String jsMethod;

	//分组内显示次序
	private int orderIndex;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public int getOrderIndex() {
		return orderIndex;
	}

	public void setOrderIndex(int orderIndex) {
		this.orderIndex = orderIndex;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getVisible() {
		return visible;
	}

	public void setVisible(String visible) {
		this.visible = visible;
	}

	public String getReadonly() {
		return readonly;
	}

	public void setReadonly(String readonly) {
		this.readonly = readonly;
	}

	public String getIspasswd() {
		return ispasswd;
	}

	public void setIspasswd(String ispasswd) {
		this.ispasswd = ispasswd;
	}

	public String getRegex() {
		return regex;
	}

	public void setRegex(String regex) {
		this.regex = regex;
	}

	public String getTips() {
		return tips;
	}

	public void setTips(String tips) {
		this.tips = tips;
	}

	public int getMaxlength() {
		return maxlength;
	}

	public void setMaxlength(int maxlength) {
		this.maxlength = maxlength;
	}

	public String getIsselect() {
		return isselect;
	}

	public void setIsselect(String isselect) {
		this.isselect = isselect;
	}

	public String getDataDict() {
		return dataDict;
	}

	public void setDataDict(String dataDict) {
		this.dataDict = dataDict;
	}

	public String getJsMethod() {
		return jsMethod;
	}

	public void setJsMethod(String jsMethod) {
		this.jsMethod = jsMethod;
	}

	public String getNullable() {
		return nullable;
	}

	public void setNullable(String nullable) {
		this.nullable = nullable;
	}
}
