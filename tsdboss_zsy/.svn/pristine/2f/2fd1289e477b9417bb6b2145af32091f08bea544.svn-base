package com.tsd.service;


import java.util.List;

import javax.servlet.http.HttpServletResponse;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.ConstantFilterImpl;

/**
 * @author youhongyu
 * 2010-8-11 15:02:35
 * */
import com.tsd.service.util.ConstantFilterI;

/**
 * 常量表页面访问接口
 * */
public class GetDataDictOne {
	
	//无参构造函数
	public GetDataDictOne(){
		super();
	}	

	/**
	 * 根据properties文件id获取对应的常量表信息
	 * @param response: HttpServletResponse 
	 * @param name: 常量表对应key
	 * @param params:字段过滤 
	 * 返回的是xmlattr 格式
	 * */
	public void getOneTable(HttpServletResponse response,String keyname,String params){	
				
		//从静态变量tableMap中获取key=name的常量表信息
		List aA =  null;//(List) LoadAllDataDict.tableMap.get(keyname);
		
		//判断传入的key值是否在常量表中存在
		if(aA==null){
			System.out.println("------不存在所提交关键字对应的常量表------\t"+keyname);
		}
		else{
			
			/**
			 * 根据相应的过滤条件进行过滤
			 * */
			
			//创建过滤对象
			ConstantFilterI constantFilterI = new ConstantFilterImpl();
			String xml = "";
			//部门过滤
			if("FINAL.department".equals(keyname)){
				xml = constantFilterI.departmentFilter(aA, params);
			}
			//地址过滤
			else if("FINAL.sys_address".equals(keyname)){
				xml = constantFilterI.addressFilter(aA, params);
			}
			//两表通过id关联过滤
			else if(params!=null && !"".equals(params)){
				xml = constantFilterI.associationFilter(aA, params);
			}
			//一般情况
			else{
				xml = constantFilterI.originalFilter(aA);
			}
			
			//将拼接好的xml信息通过response输入给用户
			ClientOutPut.printout(response, xml, "xml");		
		}
	}
}
