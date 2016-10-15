package com.tsd.service;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tsd.service.dto.TsdMap;
import com.tsd.service.util.StringUtil;

public class ExecuteSql {
	/***************************************************************************
	 * 执行操作 此方法需要开发人员配置对应的config目录下的properties文件
	 * @return
	 */
	public boolean exeSqlData(HttpServletRequest request,HttpServletResponse response) {
		List<TsdMap> params = new ArrayList<TsdMap>();
		Enumeration enums = request.getParameterNames();
		String sqlParams = "";//打印前台拼接参数时使用，chenliang，2012-10-16
		///分解参数
		while (enums.hasMoreElements()) {
			String temp = (String) enums.nextElement();
			if ("packgname".equals(temp) || "clsname".equals(temp)
					|| "method".equals(temp) || "datatype".equals(temp)
					|| "pageurl".equals(temp) || "tsdpk".equals(temp)
					|| "tsdcf".equals(temp) || !StringUtil.isNotEmpty(temp)||"DS".equals(temp)) {
				continue;
			}
			String tempVal = request.getParameter(temp);
			//打印前台输出参数
			sqlParams += temp+"="+tempVal+";";
//			System.out.println("=============================【params】==========================================");
//			System.out.println("【Key】：" + temp + "【Value】：" + tempVal);
//			System.out.println("=============================【params】==========================================");
			TsdMap tm = new TsdMap();
			tm.setKeyName(temp);
			tm.setKeyVal(tempVal);
			params.add(tm);
		}
		String ds = request.getParameter("ds");
		if(!StringUtil.isNotEmpty(ds)) {
			throw new RuntimeException("datasource is null");
		}
		//System.out.println("【SQL Params】："+sqlParams);
		com.tsd.dao.ExecuteSql.exeSqlData(request, response, params,ds,sqlParams);
		return true;
	}
}
