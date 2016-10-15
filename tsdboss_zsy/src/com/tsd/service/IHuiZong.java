package com.tsd.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.tsd.entity.AttachfeeHthHz;
import com.tsd.entity.AttachfeeTemp;
import com.tsd.entity.Butieitem;
import com.tsd.entity.Bymx;
import com.tsd.entity.FreeGrade;
import com.tsd.entity.HfhzAttachfeeCfg;
import com.tsd.entity.HthdangHz;
import com.tsd.entity.HthhfHzTmp;
import com.tsd.entity.HuizongHf;
import com.tsd.entity.HuizongTmp;
import com.tsd.entity.KemuDef;
import com.tsd.entity.Mxmonth;
import com.tsd.entity.OtherDhedit;
import com.tsd.entity.Teljob;
import com.tsd.entity.Yhlb;

/**
 * 汇总接口,用于定义汇总过程中用到的所有方法
 * @author donglei 2015-10-22
 *
 */
public interface IHuiZong {
	
	/**
	 * 获取数据库时间
	 * @return Date
	 */
	Date getDbTime();
	
	/**
	 * 检查是否有其他人正在汇总
	 * @param userId 用户id
	 * @param dbSysTime 数据库系统时间
	 * @return boolean true无人在用 false在使用
	 */
	boolean checkUsing(String userId,Date dbSysTime);
	
	/**
	 * 检查是否存在汇总的起止时间
	 * @param conn			数据库连接
	 * @return mxmonth
	 */
	Mxmonth checkStartAndEndTime(String hzyf) throws Exception;
	
	/**
	 * 清除90以前做拆机标志的电话 
	 * @param conn			数据库连接
	 */
	void cleanDhByTag() throws Exception;
	
	/**
	 * 检查是否汇总工单费用配置
	 * @return boolean Y为汇总
	 */
	boolean isTrue(String sql);
	
	/**
	 * 根据汇总时间获取合同号档数据
	 * @param conn
	 * @param dbSysTime
	 * @return List<HthdangHz>
	 */
	List<HthdangHz> getHthdangHzList(String hzyf, String hthLimit, boolean timematch) throws Exception;
	
	/**
	 * 根据汇总时间获取合同号月租数据
	 * @param conn
	 * @param dbSysTime
	 * @return List<AttachfeeHthHz>
	 */
	List<AttachfeeHthHz> getAttachfeeHthHzList(Mxmonth mxmonth,
			String hthLimit,boolean timematch) throws Exception;
    
	/**
	 * 根据汇总时间段,初始化基本HuizongTmp数据
	 * @param conn
	 * @param dbSysTime
	 * @param mxmonth
	 * @return List<HuizongTmp>
	 */
	List<HuizongTmp> getHuizongTmpList(Mxmonth mxmonth,String hthLimit,  
			boolean timematch) throws Exception;
	
	/**
	 * 根据汇总时间段,初始化基本AttachfeeTemp数据
	 * @param conn
	 * @param mxmonth
	 * @return
	 */
	List<AttachfeeTemp> getAttachfeeTempList(Mxmonth mxmonth,
			String hthLimit,boolean timematch) throws Exception;
	
	/**
	 * 汇总用户月租数据
	 * @param hzyf			汇总月份
	 * @param hthLimit		合同号或者用户类型
	 * @param realTimeCall	用于判断是单用户理解结算还是集中汇总
	 * @param yhDangHz		用户基本汇总信息
	 * @param conn  		数据库连接
	 * @param attachFeeHz	
	 * @return
	 */
	Map<Object,HuizongTmp> hzUserAttachFee(Mxmonth mxmonth,
			Map<Object,HuizongTmp> huizongTmpMap, List<AttachfeeTemp> attachfeeTemplist,
			List<HfhzAttachfeeCfg> hfhzattachfeecfglist,Map<Object,HthdangHz> hthdangHzMap,
			List<String> tjbzlist,Map<Object,Yhlb> yhlbmap,Date dbSysTime) throws Exception;
	/**
	 * 汇总合同号月租数据
	 * @param huizongTmpMap
	 * @param attachfeehthhzlist
	 * @param hthdangHzMap
	 * @return Map<Object,HuizongTmp>
	 * @throws Exception
	 */
	Map<Object,HuizongTmp> hzHthAttachFee(Map<Object,HuizongTmp> huizongTmpMap, 
			List<AttachfeeHthHz> attachfeehthhzlist,Map<Object,HthdangHz> hthdangHzMap) throws Exception;
	/**
	 * 获取月租控制表数据
	 * @return List<HfhzAttachfeeCfg>
	 * @throws Exception
	 */
	List<HfhzAttachfeeCfg> getHfhzAttachfeeCfgList() throws Exception;
	
	/**
	 * 获取当月完工的工单表数据
	 * @param conn
	 * @param hzyf
	 * @return List<Teljob>
	 * @throws Exception
	 */
	List<Teljob> getTeljobList (String hzyf,String hthLimit) throws Exception;
	
	/**
	 * 汇总工单表中装、移、购机费用(中石油项目定制)
	 * @param huizongTmpMap
	 * @param teljobList
	 * @return
	 * @throws Exception
	 */
	Map<Object,HuizongTmp> hzUserTeljobFee(Map<Object,HuizongTmp> huizongTmpMap,
			List<Teljob> teljobList) throws Exception;
	
	
	/**
	 * 导入外部数据 
	 * @param yhDangHz		用户基本汇总信息
	 * @param huizongTmp    汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	Map<Object,HuizongTmp> importExternalData(Map<Object, HuizongTmp> huizongTmpMap, List<OtherDhedit> otherDheditList)throws Exception ;
	
	/**
	 * 按科目归类费用
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	List<HuizongTmp> groupByKemu(Map<Object, HuizongTmp> huizongTmpMap,List<KemuDef> kemus, Map<Object,Yhlb> yhlbmap, Map<Object,HthdangHz> hthdangHzMap) throws Exception;
	
	/**
	 * 中石油定制，处理装机，移机，拆机等费用
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	void zsyToZjYjCj(HuizongTmp huizongTmp, String hzyf)throws Exception;
	
	/**
	 * 计算话费合计
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	void calculateTotalBill(HuizongTmp huizongTmp,Map<Object,Yhlb> yhlbmap,Map<Object,HthdangHz> hthdangHzMap);
	
	/**
	 * 按合同号统计 Huizong->Hthhf_Hz
	 * @param huizongTmps 	汇总临时数据
	 * @param mxmonth 		汇总时间设置
	 * @param hthdangHzMap 	合同号档信息map
	 * @param conn			数据库连接
	 * @return 合同号汇总list
	 * @throws Exception
	 */
	public List<HthhfHzTmp> groupByHth(List<HuizongTmp> huizongTmps,Mxmonth mxmonth,
			Map<Object,HthdangHz> hthdangHzMap, Map<Object,FreeGrade> freeGradeMap,
			List<Butieitem> butieitemList, List<HthhfHzTmp> hthhfHzPreList,String hzyfmm)throws Exception;
	
	/**
	 * 生成最终汇总数据，并插入到汇总表中
	 * @param huizongTmp	汇总临时数据
	 * @param hthHzTmp		合同号汇总临时数据
	 * @param conn  		数据库连接
	 */
	void createFinalData(String hthLimit,List<HuizongTmp> huizongTmps, List<HthhfHzTmp> hthHzTmps,List<Bymx> bymxs,int hzyf) throws Exception;
    /**
     * 获取停机标志组类型数据
     * @param conn
     * @return List<String>
     * @throws Exception
     */
	List<String> getTjbzGroupList() throws Exception;

	/**
	 * 获取用户类别表数据
	 * @param conn
	 * @return List<String>
	 * @throws Exception
	 */
	List<Yhlb> getYhlbList() throws Exception;
    
	/**
	 * 获取汇总表中前期已经汇总完成的话费
	 * @param conn
	 * @param hzyf
	 * @return List<HuizongHf>
	 * @throws Exception
	 */
	List<HuizongHf> getHuizongHfList(String hzyf,String hthLimit,boolean monthMatch) throws Exception;
	
	/**
	 * 汇总用户话费
	 * @param huizongHfList
	 * @param huizongTmpMap
	 * @return Map<Object,HuizongTmp>
	 */
	Map<Object,HuizongTmp> hzUserHF(List<HuizongHf> huizongHfList,Map<Object,HuizongTmp> huizongTmpMap);
	
	/**
	 * 获取减免项目定义表数据
	 * @param conn
	 * @return List<Butieitem>
	 * @throws Exception
	 */
	List<Butieitem> getbutieitemList() throws Exception;
	
	/**
	 * 获取减免类别表数据
	 * @param conn
	 * @return List<FreeGrade>
	 * @throws Exception
	 */
	List<FreeGrade> getfreeGradeList () throws Exception;
	
	/**
	 * 获取上个月汇总用的补贴结余
	 * @param conn
	 * @param hzyf
	 * @param hthLimit
	 * @return List<HuizongTmp>
	 * @throws Exception
	 */
	List<HuizongTmp> gethuizongPreList (int hzyf,String hthLimit) throws Exception;
	
	/**
	 * 计算电话费减免
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	List<HuizongTmp> calculateBillRelief(List<HuizongTmp> huizongTmpList,List<Butieitem> butieitemList,
			Map<Object,FreeGrade> freeGradeMap,List<HuizongTmp> huizongPreList,String hzyfdd ) throws Exception;
	
	/**
	 * 获取上个月合同号汇总表用的补贴结余
	 * @param conn
	 * @param prehzyf
	 * @param hthLimit
	 * @return List<HthhfHzTmp>
	 * @throws Exception
	 */
	List<HthhfHzTmp> geththhfHzPreList (int hzyf,String hthLimit) throws Exception;
	
	/**
	 * 计算合同号话费减免
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	HthhfHzTmp hthCalculateBillRelief(HthhfHzTmp hthhfHzTmp, Map<Object,FreeGrade> freeGradeMap,
			List<Butieitem> butieitemList, List<HthhfHzTmp> hthhfHzPreList, String hzyfmm) throws Exception;
	
	/**
	 * 获取包月明细数据
	 * @return
	 * @throws Exception
	 */
	public List<Bymx> getBymxList() throws Exception;
	
	/**
	 * 获取科目定义数据
	 * @return
	 * @throws Exception
	 */
	public List<KemuDef> getKemuDefList() throws Exception;
	
	/**
	 * 清除汇总占用表
	 * @throws Exception
	 */
	public void truncateUsingTable();
	
	/**
	 * 获取外部数据OtherDH_Edit 并且按照dhid分组统计费用，返回以dhid为key的map
	 * @param yhdangHzMap
	 * @param hzyf
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<OtherDhedit> getOtherDheditList(int hzyf) throws Exception;
	
	/**
	 * list转map通用方法
	 * @param list
	 * @param key
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public <T> Map<Object,T> listToMap(List<T> list, String key) throws IllegalArgumentException, IllegalAccessException;
}
