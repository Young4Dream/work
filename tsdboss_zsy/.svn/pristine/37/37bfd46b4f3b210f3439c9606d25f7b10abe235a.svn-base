/*****************************************************************
 * name: jobmanage.java
 * author: 
 * version: 
 * description: 工单相关类，该类用于启动一个重复执行的任务
 * modify: 2010-11-22 luoyulong 添加注释
 *****************************************************************/
package com.tsd.jobschedule;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Timer;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.Log;

public class jobmanage {
	public boolean bStop=false;
	static public Timer timer=null;
	public void getNewJob()
	{
		ResultSet rs =null;
		Connection conn = null;
		Statement stmt = null;
		String hasworkflow = "N";

		try {

			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");	
			conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接

			stmt = conn.createStatement();
			//是否有工单管理模块  N：没有 Y：有  没有时，后台定时器不执行，前台主页面也不执行
			rs = stmt.executeQuery("SELECT tvalues FROM tsd_ini WHERE tsection='systemparams' AND tident='hasworkflow'");
			
			while(rs.next())
			{
				hasworkflow = rs.getString("TVALUES");
			}
			if(!"Y".equalsIgnoreCase(hasworkflow))
				hasworkflow = "N";
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			try 
			{
				if (stmt!=null) {stmt.close();}
				if (rs != null) {
					rs.close();	
				}
				if(conn !=null){
					conn.close();
				}
			} catch (SQLException e) {
					e.printStackTrace();
			}
		}
		if("Y".equalsIgnoreCase(hasworkflow))
		{
			timer = new Timer();
			timer.schedule(new getJobTask(), 1000, 10*60*1000);//在1秒后执行此任务,每次间隔20分钟进行一次汇总,如果传递一个Data参数,就可以在某个固定的时间执行这个任务.
		}
     /*   while(true){//这个是用来停止此任务的,否则就一直循环执行此任务了
        	if(bStop){
        		
        		timer.cancel();//使用这个方法退出任务    
        		System.out.println(">>>>cancel");
            }
        }
      */
	}

}