package com.tsd.service;
/**
 * name: getSessionVal.java
 * author: yhy
 * version: 1.0, 2011-8-1
 * description: 根据session属性名为前台提供session属性值
 * modify:
 * */
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class getSessionVal {
	/**
	 * 根据session属性名为前台提供session属性值
	 * 前台页面调用示例，其中AttributeName:'userid' 填写为要查询的数据源名称：
	 *var urlstr=tsd.buildParams({  
					packgname:'service',
					clsname:'getSessionVal',
					method:'getValuebyName'							
		});
		urlstr +="&AttributeName="+paramname;
		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(msg){
					sessionval = msg;			
			}			
		});	
	 * @return session中对应的值
	 */
	public static void getValuebyName(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String AttributeName = request.getParameter("AttributeName");
		HttpSession session = request.getSession();
		String value = (String) session.getAttribute(AttributeName);		
		response.getWriter().print(value);		
	}
}
