/*****************************************************************
 * name: getJobTask.java
 * author: 
 * version: 
 * description: 工单相关类，该类继承TimerTask类，以实现定时执行任务
 * modify: 2010-11-22 luoyulong 添加注释
 *         2010-12-3  chenze    修改获取工单方式
 *         2010-12-6  chenze    处理edb下工单调用
 *****************************************************************/
package com.tsd.jobschedule;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.Log;

public class getJobTask extends java.util.TimerTask{
	public static String sbbJobTotal[]=null;
	public static String telJobTotal[]=null;
	
	public void run(){
		// SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd
		// HH:mm:ss");
		// Date now = new Date();
		// String thislogtime = format.format(now);
		//System.out.println("-----------------------------------------------");
		//System.out.println("get radjob:"+thislogtime);
		
		sbbJobTotal = ExecProc("broadband","getKdJob",1);
		if(null!=sbbJobTotal){
			for(int i=0; i<sbbJobTotal.length; i++)
			{
				//System.out.println(sbbJobTotal[i]);
			}
		}
		//System.out.println("-----------------------------------------------");
		//System.out.println("get teljob:"+thislogtime);
		telJobTotal = ExecProc("tsdReport","getNewJob",2);
		if(null!=telJobTotal){
			for(int i=0; i<telJobTotal.length; i++)
			{
				//System.out.println(telJobTotal[i]);
			}
		}
		//System.out.println("-----------------------------------------------");
	}
	
	public String[] ExecProc(String ds,String proname,int database)
	{
		CallableStatement call = null;
		ResultSet rs =null;
		Connection conn = null;
		Statement stmt = null;
		
		Statement stmt1 = null;
		ResultSet rset1 = null;
		String[] sTotal= null;
		try {

			String dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);	
			conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
			String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
			conn.setAutoCommit(false);
			if("oracle".equalsIgnoreCase(dbName)){
				call =conn.prepareCall("{call "+proname+"(?)}");
				call.registerOutParameter(1, OracleTypes.CURSOR);
			}else if("enterprisedb".equalsIgnoreCase(dbName)){
				call = conn.prepareCall("{call "+proname+"(?)}");
				call.setNull(1, Types.REF);
				call.registerOutParameter(1, Types.REF);// 注册输出参数
			}else{
				call = conn.prepareCall("{call "+proname+"()}");
			}
			
			if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName)) {
				call.execute();
				rs = (ResultSet) call.getObject(1);
			}
			else{
				rs = call.executeQuery();
			}
			conn.commit();
			//modify by chenliang 2010-04-06
			//记录条数
			int iRow = 0;
			/*
			if(database==1){//Mysql数据库
				rs.last();//移到最后一行
				iRow = rs.getRow();//得到当前行号，也就是记录数
				rs.beforeFirst(); //还要用到记录集，就把指针再移到初始化的位置
			}else if(database==2){//MSSQL数据库
				stmt = conn.createStatement();
				String sql = "select sum(decode(iType,1,1,0)) as newjob from TelJob_new group by sdh2,mqbm,JobType,accept";
				ResultSet rset = stmt.executeQuery(sql); 
				while(rset.next()){ 
					iRow++;
				}
			}
			*/
			stmt1 = conn.createStatement();
			rset1 = stmt1.executeQuery("select TValues from tsd_ini i where i.tsection='Phone' and i.tident='WorkFlowByChargeArea'");
			String areatype = "N";
			while(rset1.next())
			{
				areatype = rset1.getString("TVALUES");
			}
			if(!"Y".equalsIgnoreCase(areatype))
				areatype = "N";
			
			stmt = conn.createStatement();
			String sql = "select sum(decode(iType,1,1,0)) as newjob from "+(database==1?"radjob_new":"Teljob_new")+" group by "+(!areatype.equalsIgnoreCase("Y")?"sdh2":"area")+",mqbm,JobType,accept";
			ResultSet rset = stmt.executeQuery(sql); 
			while(rset.next()){ 
				iRow++;
			}
			//System.out.println("iRow:"+iRow);
			sTotal = new String[iRow];
			int i = 0;
			while(rs.next()){
				String userarea = rs.getString("SDH2");
				if(null!=userarea){//当用户区域为空时，不取统计数据
					//用户区域~工单目前部门~工单类型~新工单~未处理工单~配置可接收工单工号
					sTotal[i] = userarea + "~" + Log.isNull(rs.getString("MQBM")) + "~" +
								Log.isNull(rs.getString("JOBTYPE")) + "~" + rs.getString("NEWJOB") + "~" +
								rs.getString("NOTOPERATEJOB")+ "~" + Log.isNull(rs.getString("ACCEPT"));
				}
				i++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally
		{
			try 
			{
				if (call!=null) {call.close();}
				if (stmt!=null) {stmt.close();}
				if(stmt1!=null){stmt1.close();}
				if(rset1!=null){rset1.close();}
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
		return sTotal;
	}
}