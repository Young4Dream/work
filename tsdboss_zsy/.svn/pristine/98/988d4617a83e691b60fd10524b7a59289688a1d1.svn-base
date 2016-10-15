 /*****************************************************************
 * name: DBService.java
 * author: luoyulong
 * version: 1.0, 2010-11-2
 * description: 为前台提供操作数据库的方法
 * modify:
 * 		2011-1-6 youhongyu 添加decideDataSource方法
 *****************************************************************/
package com.tsd.service;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;
import com.tsd.web.servlet.ExeMethodFactory;

/**
 * 为前台提供操作数据库的方法
 */
public class DBService {
	/**
	 * 控制器，根据传递的operate参数来判断调用哪个方法。
	 */
	public static void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String operate = request.getParameter("operate");
		try{
			if(operate==null) throw new Exception();
			ExeMethodFactory.executeMethod(request, response,"com.tsd.service.DBService", operate);
		}catch (Exception e) {
			System.err.println("class: com.tsd.service.DBService method: service. error!");
			e.printStackTrace();
		}
	}
	
	/**
	 * 判断指定数据源的数据库类型
	 * 前台页面调用示例，其中ds:'tsdBill' 填写为要查询的数据源名称：
	 * $.get('mainServlet.html',{packgname:'service',clsname:'DBService',method:'service',operate:'decideDBType',ds:'tsdBill'},function(data){
	 *    alert(data);
	 * });
	 * @return 输出页面数据库名称，mssql,mysql,oracle,postgresql,enterprisedb，为空则没有查询到或有错误
	 */
	public static void decideDBType(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/plain; charset=utf-8");
		String result = "";
		Connection conn = null;
		try {
			String ds = request.getParameter("ds");
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);
			
			conn = DBhelper.getConnection(dataSourceName);
			result = DBhelper.getDatabaseProductName(conn);
			
		} catch (Exception e) {
			System.err.println("class: com.tsd.service.DBService method: decideDBType. error!");
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			conn = null;
			response.getWriter().print(result);
		}
	}
	
	/**
	 * 判断指定数据源对应到mainSystem.properties右侧数据源的名称
	 * 前台页面调用示例，其中ds:'tsdBill' 填写为要查询的数据源名称：
	 *  var urlstr ='mainServlet.html?&packgname=service&clsname=DBService&method=service&operate=decideDataSource&ds=tsdBilling'
	 *	$.ajax({
			url:urlstr,
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(msg){
				alert(msg);
			}
		});
	 *
	 * @return 输出页面数据库名称，mssql,mysql,oracle,postgresql,enterprisedb，为空则没有查询到或有错误
	 */
	public static void decideDataSource(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/plain; charset=utf-8");
		String dataSourceName = "";
		try {
			String ds = request.getParameter("ds");
			dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);			
			
		} catch (Exception e) {
			System.err.println("class: com.tsd.service.DBService method: decideDataSource. error!");
			e.printStackTrace();
		} finally {
			response.getWriter().print(dataSourceName);
		}
	}
}
