/*****************************************************************
 * name: PauseOrActiveJob.java
 * author: 
 * version: 
 * description: 工单相关类
 * modify: 2010-11-22 luoyulong 添加注释
 *         2010-12-3  chenze    工单调用相关修改
 *****************************************************************/
package com.tsd.jobschedule;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LoadProperties;

public class PauseOrActiveJob extends HttpServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			HttpSession session = request.getSession();
			String groupid = (String)session.getAttribute("groupid");//工号所在权限组
			if(groupid.indexOf("~")!=-1){
				String[] grouparr = groupid.split("~");
				for(int i = 0 ; i < grouparr.length;i++){
					//系统管理员处理工单
					if("1".equals(grouparr[i])){
						groupid = "1";
					}
				}
			}
			String opertype = request.getParameter("opertype");//执行的操作
			String reason = request.getParameter("reason");//添加备注
			String resvalue = request.getParameter("resvalue");//获取数据结果集
			
			String userid = (String)session.getAttribute("userid");
			String operjob = request.getParameter("operjob");//工单类型
			//区分是电话工单还是宽带工单
			String datasource = null;//指定数据源
			boolean flagsql = false;//判定执行sql语句
			
			if("broadbandjob".equals(operjob)){
				datasource = "broadband";
			}else if("teljob".equals(operjob)){
				datasource = "tsdReport";
				flagsql = true;		
			}
			if("pause".equals(opertype)){//工单挂起
				String type = request.getParameter("type");//工单ID
				String newjob = request.getParameter("newjob");//新工单数量
				String untreated = request.getParameter("untreated");//未处理工单数量
				String groupidres = request.getParameter("groupidres");//更新静态数组变量
				String Rw = request.getParameter("Rw");//是新工单还是未处理工单
				String jobids = pauseAddToFlow(datasource,flagsql,resvalue,reason,Rw,userid);//添加数据
				if(!"".equals(jobids)){
					String dept = (String)session.getAttribute("departname");
					pauseJob(datasource,flagsql,jobids,groupid,dept,userid,type,newjob,untreated,groupidres,response);
				}
			}else if("alive".equals(opertype)){//工单激活
				String jobids = aliveAddToFlow(datasource,flagsql,resvalue,userid,reason);//添加数据
				if(!"".equals(jobids)){
					activateJob(datasource,flagsql,jobids,response);
				}
			}
	}
	
	//挂起工单
	public void pauseJob(String datasource,boolean flagsql,String jobids,String groupid,String dept,String userid,String type,String newjob,String untreated,String groupidres,HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		Statement stmt = null;
		ResultSet rs = null;
		String editStatus = null;
		String editStatustmp = null;
		
		//更新工单状态
		try {
			if(flagsql==false){
				//更新radjob表中的工单状态为挂起
				editStatus = "UPDATE radjob SET jobstatus='pause' WHERE jobid in("+jobids+")";
				//同步更新radjob_new表中的数据
				editStatustmp = "UPDATE radjob_new SET jobstatus='pause' WHERE jobid in("+jobids+")";
			}else if(flagsql==true){
				//更新radjob表中的工单状态为挂起
				editStatus = "UPDATE TelJob SET jobstatus='pause' WHERE ID in("+jobids+")";
				//同步更新radjob_new表中的数据
				editStatustmp = "UPDATE TelJob_new SET jobstatus='pause' WHERE jobid in("+jobids+")";
			}
				//取得数据库链接
				conn = DBhelper.getConnection( LoadProperties.getKeyValues("mainSystem", datasource));
				stmt = conn.createStatement();
				int r = stmt.executeUpdate(editStatustmp);//查询在工单ID范围内当前表中的未挂起的工单
				String flags = "";
				if(r>0){
					int res = stmt.executeUpdate(editStatus);//查询在工单ID范围内当前表中的未挂起的工单
					if(res>0){//未被全部接收
						flags += res;
						getJobTask job = new getJobTask();
						job.run();
					}else{
						flags += "false";//要挂起的工单已被全部接收
					}
				}
				//String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
				//xmls+="<row flags='"+flags+"' />";
				ClientOutPut.printout(response, flags,""); //将执行的结果返回给客户端
				return;
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
	
	//挂起工单,添加流程
	public String pauseAddToFlow(String datasource,boolean flagsql,String resvalue,String reason,String Rw,String userid){
		Connection conn = null;
		PreparedStatement ps=null;
		String str = "";
		String endflow = null;
		String sql = null;
		
		if(flagsql==false){
			//将工单流程结束掉
			endflow = "update radjobflow set Wcqk='Y' where jobid=? and PgID!=?";
			//发送人员是系统管理员
			sql = "insert into radjobflow(jobid,PgID,Fsbm,Fsry,Fsrq,Bm,Bz,Rw,Ry,OperTime)  values(?,?,?,?,sysdate,'系统管理员',?,?,?,sysdate)";
		}else if(flagsql==true){
			//将工单流程结束掉
			endflow = "update TelJob_Pglc set Wcqk='Y' where jobid=? and PgID!=?";
			//发送人员是系统管理员
			sql = "insert into TelJob_Pglc(jobid,PgID,Fsbm,Fsry,Fsrq,Bm,Bz,Rw,Ry,OperTime)  values(?,?,?,?,sysdate,'系统管理员',?,?,?,sysdate)";
		}
		try {
				//取得数据库链接
				conn = DBhelper.getConnection( LoadProperties.getKeyValues("mainSystem", datasource));
				ps = conn.prepareStatement(endflow);
				int x = 0;
				// 传入数据参数格式
				//3379~2~宽带机房@3275~2~宽带机房
				//3539~2~宽带机房@3537~3~宽带外线
				if(resvalue.lastIndexOf("@")!=-1){
					String[] resarr = resvalue.split("@");
					for(int i = 0 ; i < resarr.length;i++){
						String[] res = resarr[i].split("~");
						ps.setInt(1, Integer.parseInt(res[0]));
						ps.setInt(2, Integer.parseInt(res[1]));
						x = ps.executeUpdate();
					}
				}else{
					String[] res = resvalue.split("~");
					ps.setInt(1, Integer.parseInt(res[0]));
					ps.setInt(2, Integer.parseInt(res[1]));
					x = ps.executeUpdate();
				}
				if(x>0){
					ps = conn.prepareStatement(sql);
					//3379~2~宽带机房@3275~2~宽带机房
					//3539~2~宽带机房@3537~3~宽带外线
					if(resvalue.lastIndexOf("@")!=-1){
						String[] resarr = resvalue.split("@");
						for(int i = 0 ; i < resarr.length;i++){
							String[] res = resarr[i].split("~");
							for(int j = 0 ; j < res.length;j++){
								str += res[0] + ",";
								ps.setString(j+1, res[j]);
							}
							ps.setString(4, userid);
							ps.setString(5, reason);
							ps.setString(6, Rw);
							ps.setString(7, userid);
							ps.executeUpdate();
						}
					}else{
						String[] res = resvalue.split("~");
						str = res[0] + ",";
						for(int i = 0 ; i < res.length;i++){
							ps.setString(i+1, res[i]);
						}
						ps.setString(4, userid);
						ps.setString(5, reason);
						ps.setString(6, Rw);
						ps.setString(7, userid);
						ps.executeUpdate();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(ps!=null){ps.close();}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		str = str.substring(0,str.lastIndexOf(","));
		return str;
	}	
	
	//激活工单,添加流程
	public String aliveAddToFlow(String datasource,boolean flagsql,String resvalue,String userid,String reason){
		Connection conn = null;
		PreparedStatement ps=null;
		String str = "";
		//将之前工单流程结束
		String endflow = null;
		//插入一条新的流程
		String sql = null;
		
		if(flagsql==false){
			//将之前工单流程结束
			endflow = "update radjobflow set Wcqk='Y' where jobid=? and PgID!=?";
			sql = "insert into radjobflow(jobid,PgID,Bm,dtwaringtime,dttimeout,dtjobtimeout,Fsbm,Fsrq,Fsry,Bz,OperTime) values('<p1>','<p2>','<p3>',sysdate+(interval '<p4>' hour),sysdate+(interval '<p5>' hour),sysdate+(interval '<p6>' hour),'系统管理员',sysdate,'<p7>','<p8>',sysdate)";
		}else if(flagsql==true){
			endflow = "update TelJob_Pglc set Wcqk='Y' where jobid=? and PgID!=?";
			sql = "insert into TelJob_Pglc(jobid,PgID,Bm,dtwaringtime,dttimeout,dtjobtimeout,Fsbm,Fsrq,Fsry,Bz,OperTime) values('<p1>','<p2>','<p3>',sysdate+interval '<p4>' hour,sysdate+interval '<p5>' hour,sysdate+interval '<p6>' hour,'系统管理员',sysdate,'<p7>','<p8>',sysdate)";
		}
		
		try {
				//取得数据库链接
				conn = DBhelper.getConnection( LoadProperties.getKeyValues("mainSystem", datasource));
				ps = conn.prepareStatement(endflow);
				int x = 0;
				//3379~2~宽带机房@3275~2~宽带机房
				//3539~2~宽带机房@3537~3~宽带外线
				if(resvalue.lastIndexOf("@")!=-1){
					String[] resarr = resvalue.split("@");
					for(int i = 0 ; i < resarr.length;i++){
						String[] res = resarr[i].split("~");
						ps.setInt(1, Integer.parseInt(res[0]));
						ps.setInt(2, Integer.parseInt(res[1]));
						x = ps.executeUpdate();
					}
				}else{
					String[] res = resvalue.split("~");
					ps.setInt(1, Integer.parseInt(res[0]));
					ps.setInt(2, Integer.parseInt(res[1]));
					x = ps.executeUpdate();
				}
				if(x>0){
					//ps = conn.prepareStatement(sql);
					//3379~2~宽带机房@3275~2~宽带机房
					//3539~2~宽带机房@3537~3~宽带外线
					if(resvalue.lastIndexOf("@")!=-1){
						String[] resarr = resvalue.split("@");
						for(int i = 0 ; i < resarr.length;i++){
							String[] res = resarr[i].split("~");
							for(int j = 0 ; j < res.length;j++){
								str += res[0] + ",";
								/*
								if(j==3||j==4||j==5){
									ps.setInt(j+1, Integer.parseInt(res[j]));
								}else{
									ps.setString(j+1, res[j]);
								}*/
								sql = sql.replace("<p" + (j+1) + ">", res[j]);
							}
							//ps.setString(7, userid);
							//ps.setString(8, reason);
							sql = sql.replace("<p7>", userid);
							sql = sql.replace("<p8>", reason);
							System.out.println(">> >>" + sql);
							ps = conn.prepareStatement(sql);
							ps.executeUpdate();
						}
					}else{
						String[] res = resvalue.split("~");
						str = res[0] + ",";
						for(int i = 0 ; i < res.length;i++){
							/*
							if(i==3||i==4||i==5){
								ps.setInt(i+1, Integer.parseInt(res[i]));
							}else{
								ps.setString(i+1, res[i]);
							}
							*/
							sql = sql.replace("<p" + (i+1) + ">", res[i]);
						}
						//ps.setString(7, userid);
						//ps.setString(8, reason);
						sql = sql.replace("<p7>", userid);
						sql = sql.replace("<p8>", reason);
						System.out.println(">> >>" + sql);
						ps = conn.prepareStatement(sql);
						ps.executeUpdate();
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if(ps!=null){ps.close();}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		str = str.substring(0,str.lastIndexOf(","));
		return str;
	}	
	
	//激活工单
	public void activateJob(String datasource,boolean flagsql,String jobids,HttpServletResponse response){
		Connection conn = null;
		Statement stmt = null;
		String editStatus = null;//更新工单状态
		if(flagsql==false){
			editStatus = "UPDATE radjob SET jobstatus='normal' WHERE jobid in("+jobids+")";
		}else if(flagsql==true){
			editStatus = "UPDATE TelJob SET jobstatus='normal' WHERE ID in("+jobids+")";
		}
		try {
				//取得数据库链接
				conn = DBhelper.getConnection(LoadProperties.getKeyValues("mainSystem", datasource));
				stmt = conn.createStatement();
				String flags = "";
				int res = stmt.executeUpdate(editStatus);//查询在工单ID范围内当前表中的要激活的工单
				if(res>0){//被全部激活的工单条数
					flags += res;
					getJobTask job = new getJobTask();
					job.run();
				}else{
					flags += "false";//要激活的工单已被全部接收
				}
				//String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
				//xmls+="<row flags='"+flags+"' />";
				ClientOutPut.printout(response, flags,""); //将执行的结果返回给客户端
				return;
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	}		
}