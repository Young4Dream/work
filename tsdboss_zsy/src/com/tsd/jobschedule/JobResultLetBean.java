package com.tsd.jobschedule;
/**
 * 工单结果Bean，用于保存每项业务类型工单信息
 * @author Administrator
 *
 */
public class JobResultLetBean {
	/**
	 * 默认构造函数，初始化变量
	 */
	public JobResultLetBean()
	{
		this._total = 0;
		this._new = 0;
		this._untreat = 0;
		this._operid = "";
	}
	/**
	 * 总工单数目
	 */
	private int _total;
	/**
	 * 新工单数目
	 */
	private int _new;
	/**
	 * 未处理工单数目 
	 */
	private int _untreat;
	/**
	 * 可处理工单工号
	 */
	private String _operid;
	/**
	 * 增加总工单数目
	 * @param added
	 */
	public void addTotal(int added)
	{
		this._total += added;
	}
	/**
	 * 增加新工单数目
	 * @param added
	 */
	public void addNew(int added)
	{
		this._new += added;
		this._total += added;
	}
	/**
	 * 增加未处理工单数目
	 * @param added
	 */
	public void addUntreat(int added)
	{
		this._untreat += added;
		this._total += added;
	}
	/**
	 * 增加可处理工号
	 * @param operid
	 */
	public void addOperid(String operid)
	{
		this._operid += operid;
	}
	/**
	 * 获取JSon字符串形式的工单结果
	 * @return
	 */
	public String getResult()
	{
		return "{'new':" + String.valueOf(this._new) + ",'untreat':" + String.valueOf(this._untreat) + ",'total':" + String.valueOf(this._total) + ",'operid':'" + this._operid + "'}";
	}
}
