/*****************************************************************
 * name: ReceiveJob.java
 * author: 
 * version: 
 * description: 工单相关类
 * modify: 2010-11-22 luoyulong 添加注释
 *         2010-12-3  chenze    工单调用相关修改
 *         2010-12-6  chenze    处理edb下工单调用
 *****************************************************************/
package com.tsd.jobschedule;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LoadProperties;

public class ReceiveJob extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");// 当前登陆工号
		String fsbm = (String) session.getAttribute("departname");// 工号当前部门
		String groupid = (String) session.getAttribute("groupid");// 工号所在权限组
		if (groupid.indexOf("~") != -1) {
			String[] grouparr = groupid.split("~");
			for (int i = 0; i < grouparr.length; i++) {
				// 系统管理员处理工单
				if ("1".equals(grouparr[i])) {
					groupid = "1";
					break;
				}
			}
		}
		String opertype = request.getParameter("opertype");// 执行的是哪种操作
		String memo = request.getParameter("memobz");// 备注信息
		String jobid = request.getParameter("jobid");// 工单ID
		String type = request.getParameter("type");// 业务类型
		String newjob = request.getParameter("newjob");// 新工单数量
		String untreated = request.getParameter("untreated");// 未处理工单数量
		String groupidres = request.getParameter("groupidres");// 参数结果集
		String operjob = request.getParameter("operjob");// 工单类型

		// 区分是电话工单还是宽带工单
		String datasource = null;// 指定数据源
		boolean flagsql = false;// 判定执行sql语句

		if ("broadbandjob".equals(operjob)) {
			datasource = "broadband";
		} else if ("teljob".equals(operjob)) {
			datasource = "tsdReport";
			flagsql = true;
		}
		if (opertype.equals("receivejob")) {// 接收工单
			if (null != jobid && !"".equals(jobid)) {
				receiveJob(datasource, flagsql, groupid, fsbm, jobid, userid,
						type, newjob, untreated, groupidres, response);
			}
		} else if (opertype.equals("deletejob")) {// 删除工单
			if (null != jobid && !"".equals(jobid)) {
				deleteJob(datasource, flagsql, groupid, fsbm, jobid, type,
						newjob, untreated, groupidres, response);
			}
		} else if (opertype.equals("endJob")) {// 完工工单
			if (null != jobid && !"".equals(jobid)) {
				endJob(datasource, flagsql, groupid, jobid, fsbm, memo, type,
						userid, newjob, untreated, groupidres, response);
			}
		} else if (opertype.equals("submitjob")) {// 提交工单
			String revdept = request.getParameter("revdept");// 工单接收部门
			String waring = request.getParameter("waring");// 部门预警时间
			String timeout = request.getParameter("timeout");// 部门超时时间
			if (null != jobid && !"".equals(jobid)) {
				submitJob(datasource, flagsql, groupid, jobid, fsbm, revdept,
						memo, waring, timeout, type, userid, newjob, untreated,
						groupidres, response);
			}
		} else if (opertype.equals("goback")) {
			// mqbm=?,Fsbm=?,Fsry=?,jobid=?
			String params = "";// 更新radjob表需要的参数
			String params_flow = "";// 更新radjobflow表需要的参数
			String mqbm = request.getParameter("mqbm");
			String pgid = request.getParameter("pgid");
			String pgbm = request.getParameter("pgbm");
			String reason = request.getParameter("reason");
			String dtwaring = request.getParameter("dtwaring");
			String dttimeout = request.getParameter("dttimeout");
			String dtjobtime = request.getParameter("dtjobtime");

			if (null == reason) {
				reason = "";
			}
			if (jobid.indexOf(",") != -1) {
				String[] jobids = jobid.split(",");
				String[] pgids = pgid.split(",");
				String[] mqbms = mqbm.split(",");
				String[] dtwarings = dtwaring.split(",");
				String[] dttimeouts = dttimeout.split(",");
				String[] dtjobtimes = dtjobtime.split(",");

				for (int i = 0; i < jobids.length; i++) {
					params += mqbms[i] + "~" + fsbm + "~" + userid + "~"
							+ jobids[i] + "@";
				}
				// jobid,PgID,Fsbm,Fsry,Fsrq,Bm,Bz
				for (int i = 0; i < jobids.length; i++) {
					int tmppgid = Integer.parseInt(pgids[i]) + 1;
					params_flow += jobids[i] + "~" + tmppgid + "~" + pgbm + "~"
							+ userid + "~" + mqbms[i] + "~" + dtwarings[i]
							+ "~" + dttimeouts[i] + "~" + dtjobtimes[i] + "~"
							+ reason + "@";
				}
			} else {
				int tmppgid = Integer.parseInt(pgid) + 1;
				params += mqbm + "~" + fsbm + "~" + userid + "~" + jobid;
				params_flow += jobid + "~" + tmppgid + "~" + pgbm + "~"
						+ userid + "~" + mqbm + "~" + dtwaring + "~"
						+ dttimeout + "~" + dtjobtime + "~" + reason + "@";
			}
			if (params.lastIndexOf("@") != -1) {
				params = params.substring(0, params.lastIndexOf("@"));
			}
			if (params_flow.lastIndexOf("@") != -1) {
				params_flow = params_flow.substring(0, params_flow
						.lastIndexOf("@"));
			}
			// 工单回退
			goBackJob(datasource, flagsql, params, params_flow, groupid, fsbm,
					type, newjob, untreated, groupidres, jobid, pgid, response);
		}
	}

	// 接收新工单
	public void receiveJob(String datasource, boolean flagsql, String groupid,
			String dept, String jobid, String userid, String type,
			String newjob, String untreated, String groupidres,
			HttpServletResponse response) {
		Connection conn = null;
		PreparedStatement ps = null;
		Statement stmt = null;
		ResultSet rs = null;
		String isReceive = null;
		String editJobStaus = null;
		String updateType = null;
		// 执行宽带的sql语句
		if (flagsql == false) {
			// 先判断该工单有没有被别人接收
			isReceive = "select count(jobid) as num from radjobflow where jobid in("
					+ jobid + ") and Rw='N'";
			// 更新工单状态
			editJobStaus = "update radjobflow set Rw='Y',Ry='" + userid
					+ "',OperTime=sysdate where jobid in(" + jobid
					+ ") and Rw='N'";
			// 更新工单类型
			updateType = "update radjob_new set iType=2 where jobid in("
					+ jobid + ")";
		} else if (flagsql == true) {
			// 先判断该工单有没有被别人接收
			isReceive = "select count(jobid) as num from TelJob_Pglc where jobid in("
					+ jobid + ") and Rw='N'";
			// 更新工单状态
			editJobStaus = "update TelJob_Pglc set Rw='Y',Ry='" + userid
					+ "',OperTime=sysdate where jobid in(" + jobid
					+ ") and Rw='N'";
			// 更新工单类型
			updateType = "update TelJob_new set iType=2 where jobid in("
					+ jobid + ")";
		}
		// System.out.println("------------>"+editJobStaus);

		int x = 1;
		if (jobid.indexOf(",") != -1) {
			// 取得的工单数量
			String[] jobarr = jobid.split(",");
			x = jobarr.length;
		}
		try {
			// 取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",
					datasource);
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			stmt = conn.createStatement();
			rs = stmt.executeQuery(isReceive);// 查询在工单ID范围内当前表中的未接收的工单
			String flags = "";
			if (rs.next()) {// 未被全部接收
				int num = rs.getInt("num");
				if (num > 0) {
					int y = Math.abs(num - x);
					if (y != 0) {
						x = y;
					}
					int i = stmt.executeUpdate(editJobStaus);// 同步更新工单的状态为已接收
					if (i > 0) {
						int j = stmt.executeUpdate(updateType);// 同步更新工单的类型为未处理工单
						if (j > 0) {
							// jobmanage jobmanage = new jobmanage();
							// jobmanage.changeInput(groupid,dept,type,newjob,untreated,groupidres);//同步更新静态数组变量中的值
							getJobTask job = new getJobTask();
							job.run();
							flags += "rev=" + x;// 成功接收的工单数量
						} else {
							flags += "3";// 更新工单类型失败
						}
					} else {
						flags += "2";// 更新工单状态失败
					}
				}
			} else {
				flags += "1";// 接收的工单已被全部接收
			}

			// String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
			// xmls+="<row flags='"+flags+"' />";
			ClientOutPut.printout(response, flags, ""); // 将执行的结果返回给客户端
			return;
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
	}

	// 删除工单
	public void deleteJob(String datasource, boolean flagsql, String groupid,
			String dept, String jobid, String type, String newjob,
			String untreated, String groupidres, HttpServletResponse response) {
		Connection conn = null;
		PreparedStatement ps = null;
		Statement stmt = null;
		ResultSet rs = null;

		String delradjobflow = null;
		String delradjobnew = null;
		String delradjobtemp = null;

		if (flagsql == false) {
			// 删除流程表中的记录
			delradjobflow = "delete from radjobflow where jobid in (" + jobid
					+ ")";
			// 删除new临时表中的记录
			delradjobnew = "delete from radjob_new where jobid in (" + jobid
					+ ")";
			// 删除工单表中的记录
			delradjobtemp = "delete from radjob where jobid in (" + jobid + ")";
		} else if (flagsql == true) {
			// 删除流程表中的记录
			delradjobflow = "delete from TelJob_Pglc where jobid in (" + jobid
					+ ")";
			// 删除new临时表中的记录
			delradjobnew = "delete from TelJob_new where jobid in (" + jobid
					+ ")";
			// 删除工单表中的记录
			delradjobtemp = "delete from TelJob where ID in (" + jobid + ")";
		}
		int rsno = 0;
		try {
			// 取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",
					datasource);
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			stmt = conn.createStatement();
			rsno = stmt.executeUpdate(delradjobflow);// 查询在工单ID范围内当前表中的未接收的工单
														// -- 可能多个jobid
			rsno = stmt.executeUpdate(delradjobtemp);// 查询在工单ID范围内当前表中的未接收的工单
														// -- 临时表中的数据是单条的
			rsno = stmt.executeUpdate(delradjobnew);// 查询在工单ID范围内当前表中的未接收的工单 --
													// 临时表中的数据是单条的
			if (rsno > 0) {
				// jobmanage jobmanage = new jobmanage();
				// jobmanage.changeInput(groupid,dept,type,newjob,untreated,groupidres);//同步更新静态数组变量中的值
				getJobTask job = new getJobTask();
				job.run();
			}
			// String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
			// xmls+="<row flags='"+flags+"' />";
			ClientOutPut.printout(response, rsno + "", ""); // 将执行的结果返回给客户端
			return;
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
	}

	// 提交工单
	public void submitJob(String datasource, boolean flagsql, String groupid,
			String jobid, String fsbm, String revdept, String memo,
			String waring, String timeout, String type, String userid,
			String newjob, String untreated, String groupidres,
			HttpServletResponse response) {
		Connection conn = null;
		// Statement stmt = null;
		ResultSet rs = null;
		CallableStatement call = null;
		String rsno = null;
		int res = 0;
		try {
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",
					datasource);
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
			conn.setAutoCommit(false);
			// userid,jobid,pgid,senddepart,revdepart,memo,waring,timeout
			if (jobid.indexOf(",") != -1) {
				String[] jobidarr = jobid.split(",");
				for (int i = 0; i < jobidarr.length; i++) {
					// call =conn.prepareCall("{call jobCommit(?)}");//调用提交工单的过程
					if("oracle".equalsIgnoreCase(dbName)){
						call = conn.prepareCall("{call "+("broadband".equalsIgnoreCase(datasource)?"kd":"")+"jobCommit(?,?)}");
						call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
					}
					else if("enterprisedb".equalsIgnoreCase(dbName)){
						call = conn.prepareCall("{call "+("broadband".equalsIgnoreCase(datasource)?"kd":"")+"jobCommit(?,?)}");
						call.setNull(2, Types.REF);
						call.registerOutParameter(2, Types.REF);// 注册输出参数
					}
					else{
						call = conn.prepareCall("{call "+("broadband".equalsIgnoreCase(datasource)?"kd":"")+"jobCommit(?)}");
					}
					String[] arr = jobidarr[i].split("@");// 数据格式：jobid@pgid
					// 拼接存储过程字符串参数
					String params = "committype=nextdepart;sender=" + userid + ";jobid=" + arr[0]
							+ ";pgid=" + arr[1] + ";senddepart=" + fsbm
							+ ";revdepart=" + revdept + ";memo=" + memo
							+ ";waring=" + waring + ";timeout=" + timeout;
					// System.out.println("Params--batch:>>>>>>>>>>>>>>>>>>"+params);
					call.setString(1, params);
					// rs = call.executeQuery();
					if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName)) {
						call.execute();
						rs = (ResultSet) call.getObject(2);
					}
					else{
						rs = call.executeQuery();
					}
					if (rs.next()) {
						rsno = rs.getString("result");// 返回执行结果：1：工单已经被别的工号接收
														// 0：成功接收工单
						if ("0".equals(rsno)) {
							res++;
						}
					}
				}
			} else {
				// call =conn.prepareCall("{call jobCommit(?)}");//调用提交工单的过程
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call "+("broadband".equalsIgnoreCase(datasource)?"kd":"")+"jobCommit(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call "+("broadband".equalsIgnoreCase(datasource)?"kd":"")+"jobCommit(?,?)}");
					call.setNull(2, Types.REF);
					call.registerOutParameter(2, Types.REF);// 注册输出参数
				}
				else{
					call = conn.prepareCall("{call "+("broadband".equalsIgnoreCase(datasource)?"kd":"")+"jobCommit(?)}");
				}
				String[] arr = jobid.split("@");
				String params = "committype=nextdepart;sender=" + userid + ";jobid=" + arr[0]
						+ ";pgid=" + arr[1] + ";senddepart=" + fsbm
						+ ";revdepart=" + revdept + ";memo=" + memo
						+ ";waring=" + waring + ";timeout=" + timeout;
				// System.out.println("Params:>>>>>>>>>>>>>>>>>>"+params);
				call.setString(1, params);

				// rs = call.executeQuery();
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName)) {
					call.execute();
					rs = (ResultSet) call.getObject(2);
				}
				else{
					rs = call.executeQuery();
				}
				if (rs.next()) {
					rsno = rs.getString("result");// 返回执行结果：1：工单已经被别的工号接收
													// 0：成功接收工单
					if ("0".equals(rsno)) {
						res++;
					}
				}
			}
			
			conn.commit();
			// if(flag==true){
			// jobmanage jobmanage = new jobmanage();
			// jobmanage.changeInput(groupid,fsbm,type,newjob,untreated,groupidres);//同步更新静态数组变量中的值
			getJobTask job = new getJobTask();
			job.run();
			// }else{
			// flags += "0";//在执行完工存储过程时出现错误
			// }
			ClientOutPut.printout(response, res + "", ""); // 将执行的结果返回给客户端
			return;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 工单完工
	public void endJob(String datasource, boolean flagsql, String groupid,
			String jobid, String fsbm, String memo, String type, String userid,
			String newjob, String untreated, String groupidres,
			HttpServletResponse response) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		CallableStatement call = null;
		try {
			// 取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",
					datasource);
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
			conn.setAutoCommit(false);
			String tmp_table = null;
			if (flagsql == false) {
				tmp_table = "radjobflow";
			} else if (flagsql == true) {
				tmp_table = "TelJob_Pglc";
			}
			String isComplete = "select count(jobid) as num from " + tmp_table
					+ " where jobid in(" + jobid + ") and Wcqk='N'";

			stmt = conn.createStatement();
			rs = stmt.executeQuery(isComplete);// 查询在工单ID范围内当前表中的未接收的工单
			String flags = "";
			int x = 1;
			if (jobid.indexOf(",") != -1) {
				// 取得的工单数量
				String[] jobarr = jobid.split(",");
				x = jobarr.length;
			}
			if (rs.next()) {// 未被全部接收
				int num = rs.getInt("NUM");
				if (num > 0) {
					int y = Math.abs(num - x);
					if (y != 0) {
						x = y;
					}
					// boolean flag = false;
					// 完工前判断是否完工
					if (jobid.indexOf(",") != -1) {
						String[] jobidarr = jobid.split(",");
						for (int i = 0; i < jobidarr.length; i++) {
							if("oracle".equalsIgnoreCase(dbName)){
								call = conn.prepareCall("{call "
										+ (flagsql == false ? "kdjobAfterComplete" : "jobCommit") + "(?,?)}");// 调用完工的过程
								call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
							}else if("enterprisedb".equalsIgnoreCase(dbName)){
								call = conn.prepareCall("{call "
										+ (flagsql == false ? "kdjobAfterComplete" : "jobCommit") + "(?,?)}");// 调用完工的过程
								call.setNull(2, Types.REF);// 注册输出参数
								call.registerOutParameter(2, Types.REF);// 注册输出参数
							}
							else{
								call = conn.prepareCall("{call "
										+ (flagsql == false ? "kdjobAfterComplete" : "jobCommit") + "(?)}");// 调用完工的过程
							}
								
							String params = "committype=complete;sender=" + userid + ";jobid="
									+ jobidarr[i] + ";senddepart=" + fsbm
									+ ";memo=" + memo;
							call.setString(1, params);
							call.execute();
							// if(rs.next()){
							// flag = true;
							// }
						}
					} else {
						if("oracle".equalsIgnoreCase(dbName)){
							call = conn.prepareCall("{call "
									+ (flagsql == false ? "kdjobAfterComplete" : "jobCommit") + "(?,?)}");// 调用完工的过程
							call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
						}else if("enterprisedb".equalsIgnoreCase(dbName)){
							call = conn.prepareCall("{call "
									+ (flagsql == false ? "kdjobAfterComplete" : "jobCommit") + "(?,?)}");// 调用完工的过程
							call.setNull(2, Types.REF);// 注册输出参数
							call.registerOutParameter(2, Types.REF);// 注册输出参数
						}
						else{
							call = conn.prepareCall("{call "
									+ (flagsql == false ? "kdjobAfterComplete" : "jobCommit") + "(?)}");// 调用完工的过程
						}
						String params = "committype=complete;sender=" + userid + ";jobid=" + jobid
								+ ";senddepart=" + fsbm + ";memo=" + memo;
						call.setString(1, params);
						call.execute();
					}
					
					conn.commit();
					// if(flag==true){
					// jobmanage jobmanage = new jobmanage();
					// jobmanage.changeInput(groupid,fsbm,type,newjob,untreated,groupidres);//同步更新静态数组变量中的值
					getJobTask job = new getJobTask();
					job.run();
					flags += x + "";// 将成功完工的工单条数返回给客户端
					// }else{
					// flags += "0";//在执行完工存储过程时出现错误
					// }
				}
			} else {
				flags += "none";// 要完工的工单已被全部完工
			}
			ClientOutPut.printout(response, flags, ""); // 将执行的结果返回给客户端
			return;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 回退工单
	public void goBackJob(String datasource, boolean flagsql, String params,
			String params_flow, String groupid, String fsbm, String type,
			String newjob, String untreated, String groupidres, String jobid,
			String pgid, HttpServletResponse response) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String updateradjob = null;
		String updateradjob_new = null;
		String endjobflow = null;
		String addnewradjobflow = null;
		
		if (flagsql == false) {
			// 更新工单表
			updateradjob = "update radjob set mqbm=? where jobid=?";// IfCancel='N',jobstatus='normal',
			// 更新工单临时表
			updateradjob_new = "update radjob_new set iType=1,mqbm=?,Fsbm=?,Fsry=? where jobid=?";
			// 将原来的流程结束
			endjobflow = "update radjobflow set Wcqk='Y' where jobid=? and PgID=?";
			// 插入一条新的工单流程
			addnewradjobflow = "insert into radjobflow(jobid,PgID,Fsbm,Fsry,Fsrq,Bm,dtwaringtime,dttimeout,dtjobtimeout,Bz)  values(?,?,?,?,sysdate,?,?,?,?,?)";
		} else if (flagsql == true) {
			// 更新工单表
			updateradjob = "update TelJob set Mqbm=? where ID=?";
			// 更新工单临时表
			updateradjob_new = "update TelJob_new set iType=1,mqbm=?,Fsbm=?,Fsry=? where jobid=?";
			// 将原来的流程结束
			endjobflow = "update TelJob_Pglc set Wcqk='Y' where jobid=? and PgID=?";
			// 插入一条新的工单流程
			addnewradjobflow = "insert into TelJob_Pglc(jobid,PgID,Fsbm,Fsry,Fsrq,Bm,dtwaringtime,dttimeout,dtjobtimeout,Bz)  values(?,?,?,?,sysdate,?,to_date(?,'YYYY-MM-DD HH24:MI:SS'),to_date(?,'YYYY-MM-DD HH24:MI:SS'),to_date(?,'YYYY-MM-DD HH24:MI:SS'),?)";
		}

		int x = 0;
		String flags = "";
		try {
			// 取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",
					datasource);
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			if (params.indexOf("@") != -1) {
				ps = conn.prepareStatement(updateradjob_new);
				String[] temp_ = params.split("@");
				for (int i = 0; i < temp_.length; i++) {
					String[] tmparr = temp_[i].split("~");
					
					for (int j = 0; j < tmparr.length; j++) {
						ps.setString(j + 1, tmparr[j]);
					}
					x = ps.executeUpdate();
				}
				/*
				 * if(x>0){ ps = conn.prepareStatement(updateradjobflow);
				 * String[] tempf_ = params.split("@"); for(int i = 0 ; i <
				 * tempf_.length;i++){ String[] tmparr = tempf_[i].split("~");
				 * for(int j = 0 ; j < tmparr.length;j++){ ps.setString(j+1,
				 * tmparr[j]); } x = ps.executeUpdate(); } }
				 */
				if (x > 0) {
					ps = conn.prepareStatement(updateradjob);
					String[] mp_ = params.split("@");
					for (int i = 0; i < mp_.length; i++) {
						String[] tmparr = mp_[i].split("~");
						ps.setString(1, tmparr[0]);
						ps.setString(2, tmparr[3]);
						x = ps.executeUpdate();
					}
				}
				if (x > 0) {
					// 结束流程
					ps = conn.prepareStatement(endjobflow);
					String[] tempjob = jobid.split(",");
					String[] temppg = pgid.split(",");
					for (int i = 0; i < tempjob.length; i++) {
						ps.setString(1, tempjob[i]);
						ps.setString(2, temppg[i]);
						x = ps.executeUpdate();
					}
				}
				if (x > 0) {
					// 添加流程
					// 3571~2~宽带机房~admin~系统管理员~爱时尚大方@3570~2~宽带机房~admin~系统管理员~爱时尚大方@
					ps = conn.prepareStatement(addnewradjobflow);
					String[] tempadd_ = params_flow.split("@");
					for (int i = 0; i < tempadd_.length; i++) {
						String[] tmparr = tempadd_[i].split("~");
						for (int j = 0; j < tmparr.length; j++) {
							ps.setString(j + 1, tmparr[j]);
						}
						x = ps.executeUpdate();
					}
				}
			} else {
				ps = conn.prepareStatement(updateradjob_new);
				String[] tmparr = params.split("~");
				for (int j = 0; j < tmparr.length; j++) {
					ps.setString(j + 1, tmparr[j]);
				}
				x = ps.executeUpdate();
				/*
				 * if(x>0){ ps = conn.prepareStatement(updateradjob_new);
				 * String[] tmparrf = params.split("~"); for(int j = 0 ; j <
				 * tmparrf.length;j++){ ps.setString(j+1, tmparrf[j]); } x =
				 * ps.executeUpdate(); }
				 */
				if (x > 0) {
					ps = conn.prepareStatement(updateradjob);
					String[] mparr = params.split("~");
					ps.setString(1, mparr[0]);
					ps.setString(2, mparr[3]);
					x = ps.executeUpdate();
				}
				if (x > 0) {
					ps = conn.prepareStatement(endjobflow);
					ps.setString(1, jobid);
					ps.setString(2, pgid);
					x = ps.executeUpdate();
				}
				if (x > 0) {
					ps = conn.prepareStatement(addnewradjobflow);
					String[] tmpadd_ = params_flow.split("~");
					
					for (int j = 0; j < tmpadd_.length; j++) {
						ps.setString(j + 1, tmpadd_[j]);
					}
					x = ps.executeUpdate();
				}
			}
			if (x > 0) {
				flags = x + "";
				// jobmanage jobmanage = new jobmanage();
				// jobmanage.changeInput(groupid,fsbm,type,newjob,untreated,groupidres);//同步更新静态数组变量中的值
				// 重写数组数据
				getJobTask job = new getJobTask();
				job.run();
			} else {
				flags = "false";
			}
			//String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
			//xmls+="<row flags='"+flags+"' />";
			ClientOutPut.printout(response, flags, ""); //将执行的结果返回给客户端
			return;
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
	}
}
