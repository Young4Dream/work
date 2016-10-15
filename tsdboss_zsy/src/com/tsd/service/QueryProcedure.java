package com.tsd.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;

/******
 * 用于查询存储过程映射情况
 * @author tongyong
 *
 */
public class QueryProcedure {
	/****
	 * 通过存储过程的名称 获取存储过程
	 * @param pageName
	 * @return
	 */
	public static Map queryProcedureByName(String pageName) {
		if(pageName.startsWith("/")){
			pageName=pageName.substring(1);
			}
		String sql  = null;
		Connection conn=null;
		PreparedStatement st=null;
		ResultSet rs=null;

		Map pmap=null;
		try {
			pmap = new HashMap();
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
			conn = DBhelper.getConnection(dataSourceName);
			String db = DBhelper.getDatabaseProductName(conn);
			sql = LoadProperties.getKeyValues(db, "dbsql_queryProcedureByName");
			st=conn.prepareStatement(sql);
			st.setString(1, pageName);
			rs=st.executeQuery();
			while(rs.next()){
				pmap.put(rs.getString("sshowname"),rs.getString("sproname"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {if(rs!=null){rs.close();}
			if(st!=null){st.close();}
			if (conn != null) {
				conn.close();
			}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return pmap;
	}	
	
	/****
	 * 通过存储过程的名称 获取存储过程
	 * @param pageName
	 * @return
	 */
	public static String queryProcedure(String spName)
	{
		//System.out.println("queryProcedure: "+spName);
		String sql  = null;
		Connection conn=null;
		PreparedStatement st=null;
		ResultSet rs=null;
		String sProName="";

		try {
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
			conn = DBhelper.getConnection(dataSourceName);
			String db = DBhelper.getDatabaseProductName(conn);
			sql = LoadProperties.getKeyValues(db, "dbsql_queryProcedure");
			st=conn.prepareStatement(sql);
			st.setString(1, spName);
			rs=st.executeQuery();
			while(rs.next()){
				sProName = rs.getString("sproname");
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			try {if(rs!=null){rs.close();}
			if(st!=null){st.close();}
			if (conn != null) {
				conn.close();
			}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return sProName;				
	}
}
