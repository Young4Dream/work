package com.tsd.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AskConstant {
	public boolean askConstantTable(HttpServletRequest request,
			HttpServletResponse response){
		
		//常量表标识
		String identity = request.getParameter("identity");
		
		//访问方式 methods=update 更新表信息 methods=select 获取内存对应常量表信息。
		String pattern = request.getParameter("pattern");
		
		//过滤条件 字段信息
		String params = request.getParameter("argument");
		if(params==null){
			params="";			
		}
		
		//是否传进了常量表标识
		if (identity != null && !"".equalsIgnoreCase(identity)) {

			if (pattern != null) {
				
				//判断方式方式 读取或是更新
				if ("update".equalsIgnoreCase(pattern)) {
					
					//实例化getDataDictOne
					LoadAllDataDict loadAllDataDict = new LoadAllDataDict();					
					try {						
						String arr[] = identity.split(",");
						System.out.println(arr.length);
						for(int i=0;i<arr.length;i++){							
							System.out.println(arr[i]);
							loadAllDataDict.loadOneTable(arr[i]);
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else if ("select".equalsIgnoreCase(pattern)) {
					//实例化getDataDictOne
					GetDataDictOne getDataDictOne = new GetDataDictOne();
					System.out.println("------------");
					/**
					 * 根据properties文件id获取对应的常量表信息
					 * 返回的是xmlattr 格式
					 * */
					getDataDictOne.getOneTable(response, identity,params);

				}
			}

		}
		//更新全部常量表
		else if((identity == null || "".equalsIgnoreCase(identity)) && "update".equalsIgnoreCase(pattern)){
			//实例化getDataDictOne
			LoadAllDataDict loadAllDataDict = new LoadAllDataDict();			
			try {
				loadAllDataDict.loadAll();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
		
	}
}
