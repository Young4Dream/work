package com.tsd.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.service.dto.SpowerBean;
import com.tsd.service.util.LoadProperties;

public class UserManager extends DBhelper {
	private Connection conn;
	private PreparedStatement ps=null;
	private CallableStatement proc = null;
	private ResultSet rs;
	
	public UserManager(){}
	
	public UserManager(HttpSession session,HttpServletRequest request){
		ArrayList<SpowerBean> spowerList = getSpower(request);
		session.setAttribute("spowerlist", spowerList);
	}
	/***************************************************************************
	 * 判断用户是否存在
	 * 
	 * @param sadminname
	 * @param spassword
	 * @return
	 */
	public Map queryUser(String sadminname, String spassword,String suserip,HttpServletRequest request) {
		/**
		 * 进行用户名和密码进行判断
		 */
        String sql = " {call login(?,?)}";
		Map map = null;
		try {

			String keysql = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
			conn = DBhelper.getConnection(keysql);
			conn.setAutoCommit(false);
			String db = DBhelper.getDatabaseProductName(conn);
			proc =conn.prepareCall(sql);
			String querystr = "USERID="+sadminname+";PASSWORD="+spassword+";USERIP="+suserip+";";
			
			if("oracle".equalsIgnoreCase(db)){
				proc.setObject(1, querystr);
				proc.registerOutParameter(2, OracleTypes.CURSOR);
				proc.execute();
				rs = (ResultSet) proc.getObject(2);
			}else if("enterprisedb".equalsIgnoreCase(db)){
				proc.setObject(1, querystr);
				proc.setNull(2,Types.REF);
				proc.registerOutParameter(2, Types.REF);
				proc.execute();
				rs = (ResultSet) proc.getObject(2);
			}else if ("PostgreSQL".equalsIgnoreCase(db))
			{
				proc.setObject(1, querystr);
				proc.registerOutParameter(2, Types.OTHER);
				proc.execute();
				rs = (ResultSet) proc.getObject(2);
			}
			else{
				rs=proc.executeQuery();
			}
			conn.commit();
			conn.setAutoCommit(true);
			while (rs.next()) {
				map = new HashMap();
				if (rs.getObject("res").equals("success"))
				{
					map.put("userid", rs.getObject("userid"));
					map.put("username", rs.getObject("username"));
					map.put("password", rs.getObject("password"));
					map.put("last_login", rs.getObject("last_login"));
					map.put("departname", rs.getObject("departname"));
					map.put("groupid", rs.getObject("groupid"));
					map.put("canloginip", rs.getObject("canloginip"));
					//map.put("limitlogin", rs.getObject("limitlogin"));
					//map.put("custom", rs.getObject("custom"));
					
					//记录当前工号登陆IP，chenliang，2012-10-16
					map.put("userloginip", suserip);
					
					if(rs.getObject("sarea")==null){
						map.put("userarea", "未配置ip");  //工号登录所在的业务区域
					}
					else{
						map.put("userarea", rs.getObject("sarea"));  //工号登录所在的业务区域
					}
					if(rs.getObject("chargearea")==null){
						map.put("chargearea", "未配置营收区域");   //工号登录所在的营业点
					}
					else{
						map.put("chargearea", rs.getObject("chargearea")); //工号登录所在的营业点
					}					
					
					map.put("managearea", rs.getObject("userarea"));  //工号可管理区域
				}
				else
				{
					map.put("checkfalse", rs.getObject("res"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (proc != null) {
					proc.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	//判断当前字符串 是否为数字  --2009-12-06 add by chenliang
	public static boolean isNumeric(String str){
	     Pattern pattern = Pattern.compile("[0-9]*");
	     return pattern.matcher(str).matches();   
	}
	
	//取系统的会话超时时间 --2009-12-06 add by chenliang
	public String getSessionTime(HttpServletRequest request){
		String sql = null;
		String theTimeString = "25";
		try {
			/*******************************************************************
			 * 开始执行sql语句
			 */
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
			conn = DBhelper.getConnection(dataSourceName);
			String db = DBhelper.getDatabaseProductName(conn);
			sql = LoadProperties.getKeyValues(db, "dbsql_getSessionTime");

			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				String theValueString = rs.getString("TValues");
				if(!"".equals(theValueString)||true==isNumeric(theValueString)){
					theTimeString = rs.getString("TValues");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return theTimeString;
	}
	
	//获取扩展权限
	public ArrayList<SpowerBean> getSpower(HttpServletRequest request){
		String sql = null;
		ArrayList<SpowerBean> spowerList = null;
		SpowerBean sBean = null;
		try {
			/***************************************************************
			* 开始执行sql语句
			*/
				String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
				conn = DBhelper.getConnection(dataSourceName);
				String db = DBhelper.getDatabaseProductName(conn);
				sql = LoadProperties.getKeyValues(db, "dbsql_getSpower");
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				spowerList = new ArrayList<SpowerBean>();
				while(rs.next()){
					sBean = new SpowerBean();
					sBean.setParamname(rs.getString("paramname"));
					sBean.setParamalias(rs.getString("paramalias"));
					spowerList.add(sBean);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(rs!=null){rs.close();}
					if(ps!=null){ps.close();}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		return spowerList;
	}	
	
	//tomcat重新启动时更新用户状态
	public void updateLogined(){
		String sql = null;
		try {
				/***************************************************************
				 * 开始执行sql语句
				 */
				String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
				conn = DBhelper.getConnection(dataSourceName);
				String db = DBhelper.getDatabaseProductName(conn);
				sql = LoadProperties.getKeyValues(db, "dbsql_updateLogined");
				ps = conn.prepareStatement(sql);
				int i = ps.executeUpdate();
				if(i>0){
					System.out.println("Tomcat restart-->update all user status logined=false");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(rs!=null){rs.close();}
					if(ps!=null){ps.close();}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	}	
	
	//获取jqgrid的显示函数的配置信息
	public Map getjqGridRow()
	{
		String sql = null;
		String rowlist = "[";
		String rownum = null;
		
		Map map = new HashMap();
		String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");	
		conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
		String dbname = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名

		sql = LoadProperties.getKeyValues(dbname, "dbsql_getjqGridRow");
		try
		{
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
			{
				int tmp = rs.getInt("TValues");
				rowlist += tmp;
				rowlist += ",";
				
				if(rownum==null)
				{
					rownum = String.valueOf(tmp);
				}
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try {
				if (rs != null) {
					rs.close();
				}
				if (proc != null) {
					proc.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		rowlist = rowlist.substring(0, rowlist.length()-1);
		rowlist += "]";
		
		map.put("rowlist", rowlist);
		map.put("rownum", rownum);
		
		return map;
	}
}
