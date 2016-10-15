package com.tsd.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.ExecuteSql;

/* 宽带业务处理类
 * 参数中有一个非常重要，busitype(业务类型)，具体值如下：
 *    setup（装机）  delete(拆机)        move（移机）       transfer（过户）
      pause（暂停）  restore（恢复暂停） modify（修改属性） payfee（宽带续费）
      common(通用)
 * wangli
 * 2011.9.3
 * modify:
 *   2011-9-7 lvkui
 *   为参数busitype增加一个值：common；意思是执行一条单独的sql语句，功能同servlet:mainServlet.html
 *   这样便于统一，凡是宽带业务受理的所有请求，都调用这一个servlet.
 */
public class RadBusi extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request, HttpServletResponse response) {
		//这里可取出busitype参数，然后进行特定编码		
		Connection conn = null;
		CallableStatement call = null;
		
		Statement st = null;
		//PreparedStatement ps=null;
		ResultSet rs = null;
		//List dataSet=null;
		
		ResultSet rs_power = null;
		ResultSet rs_payitem = null;
		ResultSet rs_tsdini = null;
		String paramters="";
		String sPayitem="", sPower="", sRes="";
		
		String sbusitype = request.getParameter("busitype");	
		String sFunc = request.getParameter("func");
		String sInternetAcct = request.getParameter("internetacct");
		
		
		HttpSession session = request.getSession();
		if (session.getAttribute("userid")==null)
		{
			ClientOutPut.printout(response, "session invalid", "");
			return;
		}
		//通用调用，和以前通用调用那个servlet一样.
		if (sbusitype.equalsIgnoreCase("common"))
		{
			ExecuteSql execs = new ExecuteSql();
			execs.exeSqlData(request, response);
			return;
		}
		//工号
		String sUserID = (String)session.getAttribute("userid");
		//营业区域
		String sArea = (String)session.getAttribute("chargearea");
		
		conn = DBhelper.getConnection("tsdboss");//根据配置的数据源获得连接
		String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
		if(sbusitype.equalsIgnoreCase("pause") || sbusitype.equalsIgnoreCase("restore")){ //暂停业务、复通业务
			try{
				String sql = "select status from raduserinfo where internetacct='"+sInternetAcct+"'";
				String status = "";
				String res = "";
				st = conn.createStatement();
				rs = st.executeQuery(sql);
				//System.out.println("wlok=========="+sql);
				if (rs.next()){					
					status = rs.getString(1);
					System.out.println("wlok==========111"+status);
					if ((sbusitype.equalsIgnoreCase("pause") && status.equalsIgnoreCase("T")) || 
						(sbusitype.equalsIgnoreCase("restore") && status.equalsIgnoreCase("K")) ){
						res = "already";
						StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
						xmls.append("<rows><row><cell>"+res+"</cell><cell>0</cell></row></rows>");
						//System.out.println("wlok==========111"+xmls);
						ClientOutPut.printout(response, xmls.toString(), "xml");
						return;
					}
				}
				
			} catch (SQLException e) {				
				throw new RuntimeException("数据库操作异常:" + e);
			}finally {
				try {
					if (rs != null) {
						rs.close();
						rs=null;
					}
					if (st != null) {
						st.close();
						st=null;
					}
					if(conn !=null){
						conn.close();
						conn=null;
					}
					
				} catch (SQLException e) {
					throw new RuntimeException("关闭数据库操作异常" + e);
				}
			}
		}
		try {
			/**
			 * 通过Procedure类调用存储过程
			 */
			Procedure pro = new Procedure();
			pro.exequery(request, response);
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		}		
		try {
			if (sbusitype.equalsIgnoreCase("setup"))
			{

			}//end setup
			else if (sbusitype.equalsIgnoreCase("payfee"))
			{
//				if (sFunc.equalsIgnoreCase("init"))
//				{
//					
//				}
				if (("init").equalsIgnoreCase(sFunc))
				{
					
				}				
				String sSffs = request.getParameter("Skfs");
				String sDh = request.getParameter("dh");
				String sKemu = request.getParameter("Kemu");
				String sBcss = request.getParameter("Bcss");
				String loginfo = request.getParameter("loginfo");
				String hbdy = request.getParameter("hbdy");
				String prepay = request.getParameter("prepay");
				
				String dkhnum = request.getParameter("inputdata");
				
				 ///执行存储过程获取结果集
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_save(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_save(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}else{
				 call =conn.prepareCall("{call charge_save(?)}");
				}
				paramters = "SkrID=" + sUserID + ";Area=" + sArea + ";Hth="
						+ sDh + ";Skfs=" + sSffs + ";Kemu=" + sKemu
						+ ";Version=200404;Bcss=" + sBcss + ";prepay=" + prepay
						+ ";hbdy=" + hbdy + ";loginfo=" + loginfo + ";" + ((dkhnum==null || dkhnum=="")?"":"inputdata=" + dkhnum + ";");
				System.out.println(paramters);
				call.setObject(1, paramters);
				// 适应不同数据库
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName)) {
					call.execute();
					rs_payitem = (ResultSet) call.getObject(2);
				} else {
					rs_payitem = call.executeQuery();
				}
				StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
				xmls.append("<rows>");
				ResultSetMetaData  rsmd = rs_payitem.getMetaData();
				
				while (rs_payitem.next()) {
					xmls.append("<row ");
					sRes = rs_payitem.getString(1);

					xmls.append(rsmd.getColumnLabel(1).toLowerCase()).append(
							"=\"").append(rs_payitem.getString(1))
							.append("\" ").append(
									rsmd.getColumnLabel(2).toLowerCase())
							.append("=\"").append(rs_payitem.getString(2))
							.append("\"");
					xmls.append("></row>");
					break;
				}
				xmls.append("</rows>");
				ClientOutPut.printout(response, xmls.toString(), "xml");
			}//end payfee
			
		} catch (SQLException e) {
			sPayitem = "<payitem="+"FAILED:"+e+"payitem/>";
			throw new RuntimeException("数据库操作异常:" + e);			
		} finally {
			try {
				if (rs_power != null) {
					rs_power.close();
					rs_power=null;
				}
				if (rs_payitem != null) {
					rs_payitem.close();
					rs_payitem=null;
				}
				if (call != null) {
					call.close();
					call=null;
				}
				if(conn !=null){
					conn.close();
					conn=null;
				}
				
			} catch (SQLException e) {
				throw new RuntimeException("关闭数据库操作异常" + e);
			}
		}			
	}
}
