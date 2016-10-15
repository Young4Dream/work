package com.tsd.web.servlet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;

public class SessionListener implements HttpSessionBindingListener  {    
	public String userid = "";
	public String ipaddress = "";
	public String DataSoure = "";
	
	public SessionListener(){} 
	/**
	 * 
	 * @param userid		当前登陆工号
	 * @param ipaddress		当前登陆IP
	 * @param sDataSoure	当前访问数据源
	 */
	public SessionListener(String userid,String ipaddress, String sDataSoure){    
		  this.userid = userid;    
		  this.ipaddress = ipaddress;
		  this.DataSoure = sDataSoure;
	}     
	public void valueBound(HttpSessionBindingEvent event){    
		//开始会话监听可以进行一些操作
		//System.out.println("开始监听.....");
	}    
	
	public void valueUnbound(HttpSessionBindingEvent event){
		//会话超时时可以进行一些操作
		updateUserLogined();//更新用户登陆状态
		//System.out.println("会话超时，监听结束.....");
	} 
	
	//更新用户状态
	public void updateUserLogined(){
		Connection conn=null;
		PreparedStatement ps=null;
		try 
		{
			String sql = null;
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");
			conn = DBhelper.getConnection(dataSourceName);//获得连接
			String db = DBhelper.getDatabaseProductName(conn);//获得数据库名
			sql = LoadProperties.getKeyValues(db, "dbsql_updateLogined_user");//取得对应数据库的SQL配置文件中的SQL语句
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			ps.executeUpdate();
			System.out.println("[Session timeout]: Userid "+userid+" is session timeout , [Date]: "+com.tsd.service.util.Log.getThisTime());
		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try{
				if(ps!=null){
					ps.close();
				}
				if(conn!=null){
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}