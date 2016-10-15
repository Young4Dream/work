package com.tsd.service;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tsd.dao.DBhelper;
import com.tsd.dao.ProcedureExeFoctory;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.StringUtil;
/****
 * 用户调用存储过程
 * @author 
 *
 */
public class Procedure {
	public void exequery(HttpServletRequest request,HttpServletResponse response) {
		
		Enumeration enums =request.getParameterNames();
		String paramters="";
		
		while(enums.hasMoreElements()){
			String temp = (String) enums.nextElement();
			//如果是系统规定的参数则跳过
			if("packgname".equals(temp)||"clsname".equals(temp)||"method".equals(temp)||"datatype".equals(temp)||"pageurl".equals(temp)||!StringUtil.isNotEmpty(temp)||"tsdUserId".equals(temp)){
				continue;
			}
			paramters += temp+"="+ request.getParameter(temp.toString())+";";
		}	
		String tsdUserId=request.getParameter("tsdUserId");
		if(StringUtil.isNotEmpty(tsdUserId)){
			HttpSession session = request.getSession();
			tsdUserId=session.getAttribute("userid").toString();
			paramters+="tsdUserId="+tsdUserId;
		}
		///////////////////////////////////////////////
		///获取数据源指向
		//////////////////////////////////////////////
		String ds = request.getParameter("ds");
		if(!StringUtil.isNotEmpty(ds)) {
			throw new RuntimeException("data source is null");//数据源为空
		}
		
		String datatype = request.getParameter("datatype");
		Object obj = ProcedureExeFoctory.exequeryProcedure(paramters,ds,request,response);
		//XML格式输出
		if ("xml".equals(datatype)) {
			ClientOutPut.printout(response, obj.toString(), datatype);
		//json格式输出
		}else if("json".equals(datatype)){

			   response.setContentType("text/json;charset=utf-8");
			   response.setHeader("Charset", "UTF-8");
				response.setCharacterEncoding("UTF-8");
			  // System.out.println(obj);
			   try {
				response.getWriter().write(obj.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//此处写java键值集合输出  专属 java程序员写动态页面适用
		}else if("map".equals(datatype)){
			
			request.setAttribute("dataSet", obj);
			request.getRequestDispatcher(request.getParameter("pageurl"));
			//	此处写页面跳转
		}
	}
}
