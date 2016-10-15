package com.tsd.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;



import com.tsd.dao.DataObj;
import com.tsd.dao.ExecuteSqlData;
import com.tsd.service.dto.TsdMap;

/**
 * @author youhongyu
 * 2010-8-11 14:36:21
 * 
 * 读取常量表信息放到静态变量中
 */
public class LoadAllDataDict {
	
	//存放常量表的静态变量
	public static Map<String, String> tableMap = new HashMap<String, String>();
	//存放访问配置文件信息
	public static Map<String, Map> propConstant = new HashMap<String, Map>();
	
	/**
	 * spring实例化该bean时，需要的无参数构造函数
	 * */
	public LoadAllDataDict() {
		super();
	}

	
	/**
	 * 将所有表的信息加载到静态变量中
	 * */
	public void loadAll() {
		System.out.println("开始初始化[加载所有常量表]");
		try {
			setInfo();//配置常量表信息
			loadAllTable();//加载所有常量表信息到内存
		} catch (Exception e) {
			System.out.println("[加载所有常量表]初始化发生错误，初始化失败");
			e.printStackTrace();
		}
		System.out.println("[加载所有常量表]初始化完毕");

	}
	
	/**
	 * 加载所有常量表信息
	 * */	
	private void loadAllTable(){
		//获取存放常量表配置信息Map集合的所有key
		Set keySet = propConstant.keySet();
		//通过迭代器，分别取出Set中的元素
		Iterator ikey = keySet.iterator();
		while(ikey.hasNext()){
			//根据key对应常量表的配置信息
			Map tableInfo = LoadAllDataDict.propConstant.get(ikey.next());
			//System.out.println(">>>>>>>>>>>>>>>>"+tableInfo.get("ds"));
			
			//改参数目前没有使用，是为了一会和servlet请求同步而加的
			List<TsdMap> params = new ArrayList<TsdMap>();
			
			//根据常量表的配置信息，取出常理表数据放到内存中
			ExecuteSqlData executeSqlData = new ExecuteSqlData();
			String sHtml = executeSqlData.exeSqlData(tableInfo, params);
			tableMap.put((String) tableInfo.get("tsdpk"), sHtml);
		}
	}

	
	/**
	 * 加载单个常量表信息
	 * @throws Exception 
	 * */
	public void loadOneTable(String keyname) throws SQLException {
				
		//根据key对应常量表的配置信息
		Map tableInfo = (Map)LoadAllDataDict.propConstant.get(keyname);
		//判断传入key值在常量表配置集合中是否存在
		if(tableInfo==null){
			
		}else{
			//根据常量表的配置信息，取出常理表数据放到内存中
			List<TsdMap> params = new ArrayList<TsdMap>();
			ExecuteSqlData executeSqlData = new ExecuteSqlData();
			String sHtml = executeSqlData.exeSqlData(tableInfo, params);
			tableMap.put((String) tableInfo.get("tsdpk"), sHtml);
		}
	}	
	
	
	/**
	 * 配置常量表信息
	 * @param ds:数据源
	 * @param tsdcf：配置文件名
	 * @param tsdoper：查询方式
	 * @param tsdpk：查询语句key
	 * propConstant.put("FINAL.Dhgn", Dhgn); 的key值应与tsdpk，以便于前台调用
	 * */
	private void setInfo(){	
		
		//Dhgn 电话功能
		Map<String, String> Dhgn = new HashMap<String, String>();
		Dhgn.put("ds", "tsdBilling");
		Dhgn.put("tsdcf", "business");
		Dhgn.put("tsdoper", "query");
		Dhgn.put("tsdpk", "FINAL.Dhgn");
		Dhgn.put("tsdType", "select");
		propConstant.put("FINAL.Dhgn", Dhgn);
		
		//Dhlx 电话类型
		Map<String, String> Dhlx = new HashMap<String, String>();
		Dhlx.put("ds", "tsdBilling");
		Dhlx.put("tsdcf", "business");
		Dhlx.put("tsdoper", "query");
		Dhlx.put("tsdpk", "FINAL.Dhlx");
		Dhlx.put("tsdType", "select");
		propConstant.put("FINAL.Dhlx", Dhlx);		
		
		//Area_Ywsl 业务区域定义
		Map<String, String> area_ywslInfo = new HashMap<String, String>();
		area_ywslInfo.put("ds", "tsdBilling");
		area_ywslInfo.put("tsdcf", "business");
		area_ywslInfo.put("tsdoper", "query");
		area_ywslInfo.put("tsdpk", "FINAL.area_ywsl");
		area_ywslInfo.put("tsdType", "select");
		propConstant.put("FINAL.area_ywsl", area_ywslInfo);
		
		//Asys_Area 话费营收点定义
		Map<String, String> asys_areaInfo = new HashMap<String, String>();
		asys_areaInfo.put("ds", "tsdBilling");
		asys_areaInfo.put("tsdcf", "business");
		asys_areaInfo.put("tsdoper", "query");
		asys_areaInfo.put("tsdpk", "FINAL.asys_area");
		asys_areaInfo.put("tsdType", "select");
		propConstant.put("FINAL.asys_area", asys_areaInfo);
		
		/*********************************************
		//sys_address 地址库
		Map<String, String> sys_addressInfo = new HashMap<String, String>();
		sys_addressInfo.put("ds", "tsdBilling");
		sys_addressInfo.put("tsdcf", "business");
		sys_addressInfo.put("tsdoper", "query");
		sys_addressInfo.put("tsdpk", "FINAL.sys_address");
		propConstant.put("FINAL.sys_address", sys_addressInfo);	
		***************************************************/
		
		//Department 部门定义
//		Map<String, String> departmentInfo = new HashMap<String, String>();
//		departmentInfo.put("ds", "tsdBilling");
//		departmentInfo.put("tsdcf", "business");
//		departmentInfo.put("tsdoper", "query");
//		departmentInfo.put("tsdpk", "FINAL.department");
//		propConstant.put("FINAL.department", departmentInfo);
     
		/*
		Map<String, String> testInfo = new HashMap<String, String>();
		testInfo.put("ds", "broadband");
		testInfo.put("tsdcf", "mysql");
		testInfo.put("tsdoper", "query");
		testInfo.put("tsdpk", "FINAL.test");
		propConstant.put("FINAL.test", testInfo);		
		*/
		/*
		Map<String, String> emp_auditInfo = new HashMap<String, String>();
		emp_auditInfo.put("ds", "tsdBilling");
		emp_auditInfo.put("tsdcf", "postgresql");
		emp_auditInfo.put("tsdoper", "query");
		emp_auditInfo.put("tsdpk", "FINAL.emp_audit");
		propConstant.put("FINAL.emp_audit", emp_auditInfo);	
		*/
		

		/**
				 * 
				 * Mingto兔后来添加的
		*/		 
		//用户类别
		Map<String, String> yhlb = new HashMap<String, String>();
		yhlb.put("ds", "tsdBilling");
		yhlb.put("tsdcf", "business");
		yhlb.put("tsdoper", "query");
		yhlb.put("tsdpk", "FINAL.yhlb");
		yhlb.put("tsdType", "select");
		propConstant.put("FINAL.yhlb", yhlb);
				
				
		//用户性质
		Map<String, String> yhxz = new HashMap<String, String>();
		yhxz.put("ds", "tsdBilling");
		yhxz.put("tsdcf", "business");
		yhxz.put("tsdoper", "query");
		yhxz.put("tsdpk", "FINAL.yhxz");
		yhxz.put("tsdType", "select");
		propConstant.put("FINAL.yhxz", yhxz);

		//滞纳金标志
		Map<String, String> ZnjBz = new HashMap<String, String>();
		ZnjBz.put("ds", "tsdBilling");
		ZnjBz.put("tsdcf", "business");
		ZnjBz.put("tsdoper", "query");
		ZnjBz.put("tsdpk", "FINAL.ZnjBz");
		ZnjBz.put("tsdType", "select");
		propConstant.put("FINAL.ZnjBz", ZnjBz);
				
		//付费策略
		Map<String, String> CallPayType = new HashMap<String, String>();
		CallPayType.put("ds", "tsdBilling");
		CallPayType.put("tsdcf", "business");
		CallPayType.put("tsdoper", "query");
		CallPayType.put("tsdpk", "FINAL.CallPayType");
		CallPayType.put("tsdType", "select");
		propConstant.put("FINAL.CallPayType", CallPayType);
				
		//催缴策略
		Map<String, String> CallPay_Shedule_Base = new HashMap<String, String>();
		CallPay_Shedule_Base.put("ds", "tsdBilling");
		CallPay_Shedule_Base.put("tsdcf", "business");
		CallPay_Shedule_Base.put("tsdoper", "query");
		CallPay_Shedule_Base.put("tsdpk", "FINAL.CallPay_Shedule_Base");
		CallPay_Shedule_Base.put("tsdType", "select");
		propConstant.put("FINAL.CallPay_Shedule_Base", CallPay_Shedule_Base);
				
		//调级策略 
		Map<String, String> Hwjb_Shedule_Base = new HashMap<String, String>();
		Hwjb_Shedule_Base.put("ds", "tsdBilling");
		Hwjb_Shedule_Base.put("tsdcf", "business");
		Hwjb_Shedule_Base.put("tsdoper", "query");
		Hwjb_Shedule_Base.put("tsdpk", "FINAL.Hwjb_Shedule_Base");
		Hwjb_Shedule_Base.put("tsdType", "select");
		propConstant.put("FINAL.Hwjb_Shedule_Base", Hwjb_Shedule_Base);
				
				
		//补贴类别 
		Map<String, String> Free_Grade = new HashMap<String, String>();
		Free_Grade.put("ds", "tsdBilling");
		Free_Grade.put("tsdcf", "business");
		Free_Grade.put("tsdoper", "query");
		Free_Grade.put("tsdpk", "FINAL.Free_Grade");
		Free_Grade.put("tsdType", "select");
		propConstant.put("FINAL.Free_Grade", Free_Grade);
				
		//用户类别只有yhlb字段的 FINAL.yhlb_text
		Map<String, String> yhlb_text = new HashMap<String, String>();
		yhlb_text.put("ds", "tsdBilling");
		yhlb_text.put("tsdcf", "business");
		yhlb_text.put("tsdoper", "query");
		yhlb_text.put("tsdpk", "FINAL.yhlb_text");
		yhlb_text.put("tsdType", "select");
		propConstant.put("FINAL.yhlb_text", yhlb_text);
		
		//计费类别 
		Map<String, String> Charge_Type = new HashMap<String, String>();
		Charge_Type.put("ds", "tsdBilling");
		Charge_Type.put("tsdcf", "business");
		Charge_Type.put("tsdoper", "query");
		Charge_Type.put("tsdpk", "FINAL.Charge_Type");
		Charge_Type.put("tsdType", "select");
		propConstant.put("FINAL.Charge_Type", Charge_Type);
				
		//费用名称 
		Map<String, String> attachprice = new HashMap<String, String>();
		attachprice.put("ds", "tsdBilling");
		attachprice.put("tsdcf", "business");
		attachprice.put("tsdoper", "query");
		attachprice.put("tsdpk", "FINAL.attachprice");
		attachprice.put("tsdType", "select");
		propConstant.put("FINAL.attachprice", attachprice);

				
		//套餐组 
		Map<String, String> monthfeegroup = new HashMap<String, String>();
		monthfeegroup.put("ds", "tsdBilling");
		monthfeegroup.put("tsdcf", "business");
		monthfeegroup.put("tsdoper", "query");
		monthfeegroup.put("tsdpk", "FINAL.monthfeegroup");
		monthfeegroup.put("tsdType", "select");
		propConstant.put("FINAL.monthfeegroup", monthfeegroup);
				

			
		//客户类型
		Map<String, String> custtype = new HashMap<String, String>();
		custtype.put("ds", "tsdBilling");
		custtype.put("tsdcf", "business");
		custtype.put("tsdoper", "query");
		custtype.put("tsdpk", "FINAL.custtype");
		custtype.put("tsdType", "select");
		propConstant.put("FINAL.custtype", custtype);
		
		//信誉等级
		Map<String, String> creditgrade = new HashMap<String, String>();
		creditgrade.put("ds", "tsdBilling");
		creditgrade.put("tsdcf", "business");
		creditgrade.put("tsdoper", "query");
		creditgrade.put("tsdpk", "FINAL.creditgrade");
		creditgrade.put("tsdType", "select");
		propConstant.put("FINAL.creditgrade", creditgrade);
		
		//行业类型
		Map<String, String> tradetype = new HashMap<String, String>();
		tradetype.put("ds", "tsdBilling");
		tradetype.put("tsdcf", "business");
		tradetype.put("tsdoper", "query");
		tradetype.put("tsdpk", "FINAL.tradetype");
		tradetype.put("tsdType", "select");
		propConstant.put("FINAL.tradetype", tradetype);
		
		//单位类型
		Map<String, String> comptype = new HashMap<String, String>();
		comptype.put("ds", "tsdBilling");
		comptype.put("tsdcf", "business");
		comptype.put("tsdoper", "query");
		comptype.put("tsdpk", "FINAL.comptype");
		comptype.put("tsdType", "select");
		propConstant.put("FINAL.comptype", comptype);
		
		//证件类型FINAL.tsd_ini_idtype
		Map<String, String> idtype = new HashMap<String, String>();
		idtype.put("ds", "tsdBilling");
		idtype.put("tsdcf", "business");
		idtype.put("tsdoper", "query");
		idtype.put("tsdpk", "FINAL.tsd_ini_idtype");
		idtype.put("tsdType", "select");
		propConstant.put("FINAL.tsd_ini_idtype", idtype);
		
		//合同号当用户性质只存取中文FINAL.yhxz_hthdang
		Map<String, String> yhxz_hthdang = new HashMap<String, String>();
		yhxz_hthdang.put("ds", "tsdBilling");
		yhxz_hthdang.put("tsdcf", "business");
		yhxz_hthdang.put("tsdoper", "query");
		yhxz_hthdang.put("tsdpk", "FINAL.yhxz_hthdang");
		yhxz_hthdang.put("tsdType", "select");
		propConstant.put("FINAL.yhxz_hthdang", yhxz_hthdang);		
		
		//是否代收
		Map<String, String> sfds = new HashMap<String, String>();
		sfds.put("ds", "tsdBilling");
		sfds.put("tsdcf", "business");
		sfds.put("tsdoper", "query");
		sfds.put("tsdpk", "FINAL.tsd_ini_bz2");
		sfds.put("tsdType", "select");
		propConstant.put("FINAL.tsd_ini_bz2", sfds);
		
		//hthdang 中文 
		Map<String, String> hthdang_zh = new HashMap<String, String>();
		hthdang_zh.put("ds", "tsdBilling");
		hthdang_zh.put("tsdcf", "business");
		hthdang_zh.put("tsdoper", "query");
		hthdang_zh.put("tsdpk", "FINAL.hthdang_zh");
		hthdang_zh.put("tsdType", "table");
		hthdang_zh.put("tsdTable", "hthdang");
		propConstant.put("FINAL.hthdang_zh", hthdang_zh);
		
		//yhdang 中文
		Map<String, String> yhdang_zh = new HashMap<String, String>();
		yhdang_zh.put("ds", "tsdBilling");
		yhdang_zh.put("tsdcf", "business");
		yhdang_zh.put("tsdoper", "query");
		yhdang_zh.put("tsdpk", "FINAL.yhdang_zh");
		yhdang_zh.put("tsdType", "table");
		yhdang_zh.put("tsdTable", "yhdang");
		propConstant.put("FINAL.yhdang_zh", yhdang_zh);
		//hthdang 英文
		Map<String, String> hthdang_en = new HashMap<String, String>();
		hthdang_en.put("ds", "tsdBilling");
		hthdang_en.put("tsdcf", "business");
		hthdang_en.put("tsdoper", "query");
		hthdang_en.put("tsdpk", "FINAL.hthdang_en");
		hthdang_en.put("tsdType", "table");
		hthdang_en.put("tsdTable", "hthdang");
		propConstant.put("FINAL.hthdang_en", hthdang_en);
		
		//yhdang 英文
		Map<String, String> yhdang_en = new HashMap<String, String>();
		yhdang_en.put("ds", "tsdBilling");
		yhdang_en.put("tsdcf", "business");
		yhdang_en.put("tsdoper", "query");
		yhdang_en.put("tsdpk", "FINAL.yhdang_en");
		yhdang_en.put("tsdType", "table");
		yhdang_en.put("tsdTable", "yhdang");
		propConstant.put("FINAL.yhdang_en", yhdang_en);		

		//radpkg 中文
		Map<String, String> radpkg_zh = new HashMap<String, String>();
		radpkg_zh.put("ds", "tsdBilling");
		radpkg_zh.put("tsdcf", "business");
		radpkg_zh.put("tsdoper", "query");
		radpkg_zh.put("tsdpk", "dbsql_rad.radpkg");
		radpkg_zh.put("tsdType", "select");
		propConstant.put("dbsql_rad.radpkg", radpkg_zh);	

		//radAcc 中文
		Map<String, String> radacc_zh = new HashMap<String, String>();
		radacc_zh.put("ds", "tsdBilling");
		radacc_zh.put("tsdcf", "business");
		radacc_zh.put("tsdoper", "query");
		radacc_zh.put("tsdpk", "FINAL.tsd_ini_radAccessType");
		radacc_zh.put("tsdType", "select");
		propConstant.put("FINAL.tsd_ini_radAccessType", radacc_zh);
		
		
		//合同号月租表
		Map<String, String> attachprice_hth = new HashMap<String, String>();
		attachprice_hth.put("ds", "tsdBilling");
		attachprice_hth.put("tsdcf", "business");
		attachprice_hth.put("tsdoper", "query");
		attachprice_hth.put("tsdpk", "FINAL.attachprice_hth");
		attachprice_hth.put("tsdType", "select");
		propConstant.put("FINAL.attachprice_hth", attachprice_hth);
		
		//radpayitem 中文
		Map<String, String> radpayitem_zh = new HashMap<String, String>();
		radpayitem_zh.put("ds", "tsdBilling");
		radpayitem_zh.put("tsdcf", "business");
		radpayitem_zh.put("tsdoper", "query");
		radpayitem_zh.put("tsdpk", "dbsql_rad.payitem");
		radpayitem_zh.put("tsdType", "select");
		propConstant.put("dbsql_rad.payitem", radpayitem_zh);	

		//add by wangli 2011.12.13
		//号线管理-业务类型
		Map<String, String> route_type = new HashMap<String, String>();
		route_type.put("ds", "tsdBilling");
		route_type.put("tsdcf", "route");
		route_type.put("tsdoper", "query");
		route_type.put("tsdpk", "dbsql_route.GetRouteType");
		route_type.put("tsdType", "select");
		propConstant.put("dbsql_route.GetRouteType", route_type);
		//号线管理-配线方式
		Map<String, String> route_linemode = new HashMap<String, String>();
		route_linemode.put("ds", "tsdBilling");
		route_linemode.put("tsdcf", "route");
		route_linemode.put("tsdoper", "query");
		route_linemode.put("tsdpk", "dbsql_route.GetLineMode");
		route_linemode.put("tsdType", "select");
		propConstant.put("dbsql_route.GetLineMode", route_linemode);
		//号线管理-设备对象状态
		Map<String, String> route_state = new HashMap<String, String>();
		route_state.put("ds", "tsdBilling");
		route_state.put("tsdcf", "route");
		route_state.put("tsdoper", "query");
		route_state.put("tsdpk", "dbsql_route.GetObjState");
		route_state.put("tsdType", "select");
		propConstant.put("dbsql_route.GetObjState", route_state);		
		//add end
		
		// added by zhumengfeng
		// 专线类型
		Map<String, String> pl_type = new HashMap<String, String>();
		pl_type.put("ds", "tsdBilling");
		pl_type.put("tsdcf", "privateline");
		pl_type.put("tsdoper", "query");
		pl_type.put("tsdpk", "FINAL.pl_type");
		pl_type.put("tsdType", "select");
		propConstant.put("FINAL.pl_type", pl_type);	
		// 专线端点
		Map<String, String> pl_endpoint = new HashMap<String, String>();
		pl_endpoint.put("ds", "tsdBilling");
		pl_endpoint.put("tsdcf", "privateline");
		pl_endpoint.put("tsdoper", "query");
		pl_endpoint.put("tsdpk", "FINAL.pl_endpoint");
		pl_endpoint.put("tsdType", "select");
		propConstant.put("FINAL.pl_endpoint", pl_endpoint);		
		// end
	}

}
