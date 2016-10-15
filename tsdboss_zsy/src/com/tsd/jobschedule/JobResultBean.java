package com.tsd.jobschedule;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class JobResultBean {

	/**
	 * 默认构造函数，初始化变量
	 */
	public JobResultBean()
	{
		this._result = new HashMap<String,JobResultLetBean>();
	}
	/**
	 * 工单结果
	 */
	private Map _result;
	/**
	 * 
	 * @param key
	 */
	public void initResult(String key)
	{
		Object obj = this._result.get(key);
		if(null==obj)
			this._result.put(key, new JobResultLetBean());
	}
	/**
	 * 增加工单记录
	 * @param added
	 */
	public void addResult(String key,int newjob,int untreatjob,String operid)
	{
		this.initResult(key);
		JobResultLetBean dist = (JobResultLetBean)this._result.get(key);
		dist.addNew(newjob);
		dist.addUntreat(untreatjob);
		dist.addOperid(operid);
		
	}
	/**
	 * 获取工单结果,JSon格式
	 * @return
	 */
	public String getResult()
	{
		String res = "{";
		Iterator iterator = this._result.keySet().iterator();		
		while(iterator.hasNext())
		{
			Object obj = iterator.next();
			res += ",'" + String.valueOf(obj) + "':" + ((JobResultLetBean)this._result.get(obj)).getResult();
		}
		res = res.replaceFirst(",", "") + "}";
		return res;
	}
}
