/*****************************************************************
 * name: 	WorkFlowServlet.java
 * author: 	chenliang
 * version: 
 * description: 工单管理调用后台处理过程
 * modify:  2011-11-02：增加jobGetStattbinfo方法，处理当前工号可处理业务类型和工单条数 chenliang
 *****************************************************************/
package com.tsd.web.servlet;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LoadProperties;

public class WorkFlowServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	/**
	 * Constructor of the object.
	 */
	public WorkFlowServlet() {
		super();
	}
	public void destroy() {
		super.destroy();
		// System.out.println("Destroy WorkFlowServlet....");
	}
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			doPost(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String opertype = request.getParameter("opertype");						//操作类型
		if(null!=opertype){
			if("1".equals(opertype)){//当前工号可处理业务类型和工单条数
				HttpSession session = request.getSession();
				String userid = (String)session.getAttribute("userid");			//当前登陆工号
				String userdept = (String)session.getAttribute("departname");	//部门名称
				String userarea = (String)session.getAttribute("userarea");		//所属业务区域
				String chargearea = (String)session.getAttribute("chargearea");	//所属营业区域
				String operflag = request.getParameter("operflag");				//用户权限
				String imenu = request.getParameter("imenu");					//菜单ID
				String ywlx = request.getParameter("ywlx");						//业务类型
				//String busitype = request.getParameter("busitype");			//业务类别
				String params = "";
				params += "userid="+userid+";";
				params += "imenu="+imenu+";";
				params += "userarea="+userarea+";";
				params += "userdept="+userdept+";";
				params += "operflag="+operflag+";";
				params += "chargearea="+chargearea+";";
				params += "ywlx="+ywlx+";";
				System.out.println("Busi Type:"+ywlx);
				jobGetStateInfo("tsdBilling",params,ywlx,response);
			}else if("2".equals(opertype)){//查看工单详细信息
				String jobid = request.getParameter("jobid");					//业务类型
				String params = "jobid="+jobid;
				System.out.println("jobGetDetailInfo Params: "+params);
				jobGetDetailInfo("tsdBilling",params,response);
			}
		}
	}
	public void init() throws ServletException {
		//System.out.println("Init WorkFlowServlet....");
	}
	/**
	 * 当前工号可处理业务类型和工单条数，并同步返回明细
	 * @param datasource 	数据源
	 * @param params		过程处理参数
	 * @param response		组织好html返回前台
	 * @param ywlx			业务类型		
	 */
	
	private void callJobGetStatInfo(Connection conn, String params, String ywlx, ResultSet rs, ResultSet rstbinfo) throws Exception {
		CallableStatement call = null;
		call = conn.prepareCall("{call jobGetStatInfo(?,?,?)}");//获取当前工号可处理工单类型和条数
		//if("oracle".equalsIgnoreCase(dbName)){
			call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
			call.registerOutParameter(3, OracleTypes.CURSOR);// 注册输出参数
		/*}
		else if("enterprisedb".equalsIgnoreCase(dbName)){
			call.setNull(2, Types.REF);
			call.registerOutParameter(2, Types.REF);// 注册输出参数
			call.setNull(3, Types.REF);
			call.registerOutParameter(3, Types.REF);// 注册输出参数
		} */
		
		System.out.println("WorkFlow jobGetStatInfo Params: "+params);
		String newParams = params.replace("ywlx=;", "") + "ywlx=" + ywlx + ";";
		System.out.println(ywlx + ".params=" + newParams);
		call.setString(1, newParams);//设置参数
		call.execute();//执行过程
		//System.out.println("CallableStatement Size："+call.getFetchSize());
		//获取工单条数信息
		rs =  (ResultSet)call.getObject(2);						//获取返回游标的值
		//获取工单详细信息
		rstbinfo =  (ResultSet)call.getObject(3);				//获取返回游标的值
	}
	
	private class OutParam {
		public int iNew;
		public int iUntreated;
		public String sNew;
		public String sUntreated;
		List<String> jobTypes;
		List<String> titles;
	}
	
	private OutParam getStateInfo(String datasource, String params, String ywlx, String title) {
		OutParam outParam = new OutParam();

		Connection conn = null;
		CallableStatement call = null;
		ResultSet rs;
		ResultSet rstbinfo;
		
		try {
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",datasource);// 取得数据库链接
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			String dbName = DBhelper.getDatabaseProductName(conn);// 根据数据连接获得数据库名
			conn.setAutoCommit(false);//设置是否自动提交
			call = conn.prepareCall("{call jobGetStatInfo(?,?,?)}");//获取当前工号可处理工单类型和条数
			if("oracle".equalsIgnoreCase(dbName)){
				call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				call.registerOutParameter(3, OracleTypes.CURSOR);// 注册输出参数
			}
			else if("enterprisedb".equalsIgnoreCase(dbName)){
				call.setNull(2, Types.REF);
				call.registerOutParameter(2, Types.REF);// 注册输出参数
				call.setNull(3, Types.REF);
				call.registerOutParameter(3, Types.REF);// 注册输出参数
			}
			System.out.println("WorkFlow jobGetStatInfo Params: "+params);
			call.setString(1, params);//设置参数
			call.execute();//执行过程
			//System.out.println("CallableStatement Size："+call.getFetchSize());
			//获取工单条数信息
			rs =  (ResultSet)call.getObject(2);						//获取返回游标的值
			//获取工单详细信息
			rstbinfo =  (ResultSet)call.getObject(3);				//获取返回游标的值
			//System.out.println("rstbinfo："+rstbinfo.getFetchSize());
			ResultSetMetaData rsmd = rs.getMetaData();				//获取游标返回结果集
			ResultSetMetaData rsmdtbinfo = rstbinfo.getMetaData();	//获取游标返回结果集
			//System.out.println("Rsmdtbinfo getColumnCount："+rsmdtbinfo.getColumnCount());
			String sYwlx = "";//判断业务类型
			int newjobs = 0;//新工单
			int untreatedjobs = 0;//未处理工单
			int total = 0;//总工单条数
			String menuDiv = "";//在后台组织html
			int iCount = 0;
			//boolean flag = rs.next();
			boolean flag = false;//是否可对工单进行管理，有业务处理数据
			List<String> jobTypes = new ArrayList<String>();
			List<String> titles = new ArrayList<String>();
			while(rs.next()){
				/**
				  * 列：SGNR；值：p_setup；列：SHOWNAME；值：装机；列：NEWJOB；值：2；列：UNSETTLEDJOB；值：2 
					for(int i = 1 ; i <= rsmd.getColumnCount();i++){
						columnName = rsmd.getColumnName(1);
						columnValue = rs.getString(rsmd.getColumnName(1));
						System.out.println("列："+columnName+"；值："+columnValue);
					}
				*/
				String sJobType = rs.getString(rsmd.getColumnName(1));//工单类型：p_setup;
				String sTitle = rs.getString(rsmd.getColumnName(2));//工单类型显示名称：装机
				jobTypes.add(sJobType);
				titles.add(sTitle);
				if(iCount==0 && "".equals(ywlx) || sJobType.equals(ywlx)){//第一种业务类型默认显示新工单，未处理工单条数和对应工单处理信息；
					newjobs = rs.getInt(rsmd.getColumnName(3));//新工单：2;
					untreatedjobs = rs.getInt(rsmd.getColumnName(4));//未处理工单：2;
					total = newjobs + untreatedjobs;
					sYwlx = sJobType;//默认第一次查询
					flag = true;
				}else{
					total = rs.getInt(rsmd.getColumnName(3))+rs.getInt(rsmd.getColumnName(4));
				}
				menuDiv += "<li>";
				menuDiv += 	"<a href=\"#\" id=\"jobcss"+sJobType+"\" onclick=getJobMenu(\""+sJobType+"\") title=\""+sTitle+"\" >";
				menuDiv +=  "<b>"+sTitle+"(<span id=\"jobspan"+iCount+"\">"+total+"</span>)</b></a>";
				menuDiv += "</li>";	
				iCount++;
			}
			//不是默认第一次查询，指定业务类型进行查询
			if(!"".equals(ywlx)){
				sYwlx = ywlx;
			}
            int iNew = 1;			//新工单序号
            int iUntreated = 1;		//未处理工单序号
            String sNew = "";		//新工单信息信息
            String sUntreated = "";	//未处理工单详细信息
			String returnHtml = "";	//拼接好最终要返回的html
			String tbinfo = "";
			String tbTitle = "";
			if(flag){
				menuDiv = "<ul id=\"menu\">" + menuDiv + "</ul>";
				//System.out.println(rsmdtbinfo.getColumnCount());
				//拼接工单显示信息
				tbinfo += "<table id=\"ntable\" width=\"100%\"  border=\"1\" class=\"t1\">";
				tbinfo += "<tr>";
				tbTitle += "<th>序号</th><th>类型</th><th>状态</th>";
				tbTitle += "<th>详细</th><th style=\"width:80px;\">用户账号</th><th>受理人员</th>";
				tbTitle += "<th>派工人员</th><th>业务区域</th>"; //<th>目前区域</th>";
				tbTitle += "<th>当前部门</th><th>用户姓名</th>";
	            if("p_changename".equals(sYwlx) || "transfer".equals(sYwlx)){						//电话更名 宽带过户
	            	tbTitle += "<th>原姓名</th>";
	            }
	            tbTitle += "<th>用户地址</th>";
	            if("p_movephone".equals(sYwlx) || "move".equals(sYwlx)){							//电话移机 宽带移机
	            	tbTitle += "<th>原地址</th>";
	            }
	            tbTitle += "<th>部门超时</th><th>工单超时</th></tr>";

	            //if(rstbinfo.getRow()!=0){
	            //for (int i = 0; i < jobTypes.size(); i++) {
            		//String jobType = jobTypes.get(0);
            		//String title = titles.get(0);
    	            /*
	            	if (i > 0) {
	            		try {
	            			//rs.close();
	            			//rstbinfo.close();
	            			callJobGetStatInfo(conn, params, jobType, rs, rstbinfo);
	            		} 
	            		catch(Exception e) {
	            			System.out.println("What's happen?");
	            		}
	            	} */
					while(rstbinfo.next()){
						/** id, ywarea, d.area,d.bm, u.username as fsry, pgid,jobstatus,jobtype,xdh, xm, nxm, 
						 * 	xdz, ydz,dttimeout,dtjobtimeout,dtwaringtime,ITYPE,jlry,bmid
						 * for(int i = 1 ; i <= rsmdtbinfo.getColumnCount();i++){
								String columnName = rsmdtbinfo.getColumnName(i);
								String columnValue = rstbinfo.getString(rsmdtbinfo.getColumnName(i));
								System.out.println("序号："+i+"；列："+columnName+"；值："+columnValue);
						   }
						*/
						String iType = rstbinfo.getString(rsmdtbinfo.getColumnName(17));
						if("1".equals(iType)){		//新工单
							sNew += "<tr height=\"25px\" class=\"trclass\" id=\"jobtr"+iNew+"\">";									
							sNew += "<td class=\"jobtabclass\"><input name=\"jobchk1\" value=\""+rstbinfo.getString(rsmdtbinfo.getColumnName(1)) 		//工单ID
								+"\" type=\"checkbox\"/></td>";
							sNew += "<td class=\"jobtabclass\">" + iNew + "</td>";
							//sNew += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(7))		//工单类型 
							//	+ ".gif\" alt=\"工单类型\"/></td>";
							sNew += "<td class=\"jobtabclass\">" + title + "</td>";
							sNew += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(8))		//工单状态 
								+ ".gif\" alt=\"工单状态\"/></td>";	
							sNew += "<td class=\"jobtabclass\"><a href=\"#\" onclick=javascript:readJobDetail("+rstbinfo.getString(rsmdtbinfo.getColumnName(1))//工单ID
								+",\""+rstbinfo.getString(rsmdtbinfo.getColumnName(4))																	//目前部门
								+"\")><img src=\"style/images/public/ltubiao_03.gif\" alt=\"工单详细\"/></a></td>";
							sNew += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(9))+ "</td>";		//用户账号
							sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(18)) + "</td>";		//受理人员
							sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(5)) + "</td>";		//派工人员
							sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(2)) + "</td>";		//所属区域
							// Removed by zhumengfeng at 2016/06/11
							//sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(3)) + "</td>";		//目前区域
							sNew += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(4)) + "</td>";		//当前部门
							sNew += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(10))+ "</td>";		//用户姓名
							if("p_changename".equals(sYwlx) || "transfer".equals(sYwlx)){
								sNew += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(11))+ "</td>";	//原用户姓名
							}
							sNew += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(12))+ "</td>";		//用户地址
							if("p_movephone".equals(sYwlx) || "move".equals(sYwlx)){
								sNew += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(13))+ "</td>";	//原用户地址
							}
							sNew += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(14))+ "</td>";		//部门超时
							sNew += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(15))+ "</td>";		//工单超时
							sNew += "</tr>";
							iNew++;
						}else if("2".equals(iType)){//未处理工单
							sUntreated += "<tr height=\"25px\" class=\"trclass\" id=\"jobtr"+iUntreated+"\">";						
							sUntreated += "<td class=\"jobtabclass\"><input name=\"jobchk2\" value=\""+rstbinfo.getString(rsmdtbinfo.getColumnName(1))			// 工单ID
								+"\" type=\"checkbox\"/></td>";
							sUntreated += "<td class=\"jobtabclass\">" + iUntreated + "</td>";
							//sUntreated += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(7)) + ".gif\" alt=\"工单类型\"/></td>";
							sUntreated += "<td class=\"jobtabclass\">" + title + "</td>";
							sUntreated += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(8)) + ".gif\" alt=\"工单状态\"/></td>";
							sUntreated += "<td class=\"jobtabclass\"><a href=\"#\" onclick=javascript:readJobDetail("+rstbinfo.getString(rsmdtbinfo.getColumnName(1))+",\""
								+rstbinfo.getString(rsmdtbinfo.getColumnName(4))+"\")><img src=\"style/images/public/ltubiao_03.gif\" alt=\"工单详细\"/></a></td>";
							sUntreated += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(9))+ "</td>";		//用户账号
							sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(18)) + "</td>";		//受理人员
							sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(5)) + "</td>";		//派工人员
							sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(2)) + "</td>";		//所属区域
							// Removed by zhumengfeng at 2016/06/11
							//sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(3)) + "</td>";		//目前区域
							sUntreated += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(4)) + "</td>";		//当前部门
							sUntreated += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(10))+ "</td>";		//用户姓名
							if("p_changename".equals(sYwlx) || "transfer".equals(sYwlx)){
								sUntreated += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(11))+ "</td>";	//原用户姓名
							}
							sUntreated += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(12))+ "</td>";		//用户地址
							if("p_movephone".equals(sYwlx) || "move".equals(sYwlx)){
								sUntreated += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(13))+ "</td>";	//原用户地址
							}
							sUntreated += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(14))+ "</td>";								//部门超时
							sUntreated += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(15))+ "</td>";								//工单超时
							sUntreated += "<td style=\"display:none\" id=\"flowparam"+rstbinfo.getString(rsmdtbinfo.getColumnName(1))+"\" >" 					
								+  sYwlx+rstbinfo.getString(rsmdtbinfo.getColumnName(19)) + "@" + rstbinfo.getString(rsmdtbinfo.getColumnName(2)) + "@" + rstbinfo.getString(rsmdtbinfo.getColumnName(6)) + "</td>";	//提交下一级流转部门需要的参数
							sUntreated += "</tr>";
							iUntreated++;
						}
					}
					conn.commit();//事务提交
				}
            //}
			outParam.iNew = iNew;
			outParam.iUntreated = iUntreated;
			outParam.sNew = sNew;
			outParam.sUntreated = sUntreated;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return outParam;
	}
	
	public void jobGetStateInfo(String datasource,String params,String ywlx,HttpServletResponse response){
		Connection conn = null;
		CallableStatement call = null;
		ResultSet rs;
		ResultSet rstbinfo;
		try {
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",datasource);// 取得数据库链接
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			String dbName = DBhelper.getDatabaseProductName(conn);// 根据数据连接获得数据库名
			//System.out.println("DbName:"+dbName);
			//System.out.println("DataSourceName:"+dataSourceName);
			conn.setAutoCommit(false);//设置是否自动提交
			call = conn.prepareCall("{call jobGetStatInfo(?,?,?)}");//获取当前工号可处理工单类型和条数
			if("oracle".equalsIgnoreCase(dbName)){
				call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				call.registerOutParameter(3, OracleTypes.CURSOR);// 注册输出参数
			}
			else if("enterprisedb".equalsIgnoreCase(dbName)){
				call.setNull(2, Types.REF);
				call.registerOutParameter(2, Types.REF);// 注册输出参数
				call.setNull(3, Types.REF);
				call.registerOutParameter(3, Types.REF);// 注册输出参数
			}
			System.out.println("WorkFlow jobGetStatInfo Params: "+params);
			call.setString(1, params);//设置参数
			call.execute();//执行过程
			//System.out.println("CallableStatement Size："+call.getFetchSize());
			//获取工单条数信息
			rs =  (ResultSet)call.getObject(2);						//获取返回游标的值
			//获取工单详细信息
			rstbinfo =  (ResultSet)call.getObject(3);				//获取返回游标的值
			//System.out.println("rstbinfo："+rstbinfo.getFetchSize());
			ResultSetMetaData rsmd = rs.getMetaData();				//获取游标返回结果集
			ResultSetMetaData rsmdtbinfo = rstbinfo.getMetaData();	//获取游标返回结果集
			//System.out.println("Rsmdtbinfo getColumnCount："+rsmdtbinfo.getColumnCount());
			String sYwlx = "";//判断业务类型
			int newjobs = 0;//新工单
			int untreatedjobs = 0;//未处理工单
			int total = 0;//总工单条数
			String menuDiv = "";//在后台组织html
			int iCount = 0;
			//boolean flag = rs.next();
			boolean flag = false;//是否可对工单进行管理，有业务处理数据
			List<String> jobTypes = new ArrayList<String>();
			List<String> titles = new ArrayList<String>();
			while(rs.next()){
				/**
				  * 列：SGNR；值：p_setup；列：SHOWNAME；值：装机；列：NEWJOB；值：2；列：UNSETTLEDJOB；值：2 
					for(int i = 1 ; i <= rsmd.getColumnCount();i++){
						columnName = rsmd.getColumnName(1);
						columnValue = rs.getString(rsmd.getColumnName(1));
						System.out.println("列："+columnName+"；值："+columnValue);
					}
				*/
				String sJobType = rs.getString(rsmd.getColumnName(1));//工单类型：p_setup;
				String sTitle = rs.getString(rsmd.getColumnName(2));//工单类型显示名称：装机
				jobTypes.add(sJobType);
				titles.add(sTitle);
				if(iCount==0 && "".equals(ywlx) || sJobType.equals(ywlx)){//第一种业务类型默认显示新工单，未处理工单条数和对应工单处理信息；
					newjobs = rs.getInt(rsmd.getColumnName(3));//新工单：2;
					untreatedjobs = rs.getInt(rsmd.getColumnName(4));//未处理工单：2;
					total = newjobs + untreatedjobs;
					sYwlx = sJobType;//默认第一次查询
					flag = true;
				}else{
					total = rs.getInt(rsmd.getColumnName(3))+rs.getInt(rsmd.getColumnName(4));
				}
				menuDiv += "<li>";
				menuDiv += 	"<a href=\"#\" id=\"jobcss"+sJobType+"\" onclick=getJobMenu(\""+sJobType+"\") title=\""+sTitle+"\" >";
				menuDiv +=  "<b>"+sTitle+"(<span id=\"jobspan"+iCount+"\">"+total+"</span>)</b></a>";
				menuDiv += "</li>";	
				iCount++;
			}
			//不是默认第一次查询，指定业务类型进行查询
			if(!"".equals(ywlx)){
				sYwlx = ywlx;
			}
            int iNew = 1;			//新工单序号
            int iUntreated = 1;		//未处理工单序号
            String sNew = "";		//新工单信息信息
            String sUntreated = "";	//未处理工单详细信息
			String returnHtml = "";	//拼接好最终要返回的html
			String tbinfo = "";
			String tbTitle = "";
			if(flag){
				menuDiv = "<ul id=\"menu\">" + menuDiv + "</ul>";
				//System.out.println(rsmdtbinfo.getColumnCount());
				//拼接工单显示信息
				tbinfo += "<table id=\"ntable\" width=\"100%\"  border=\"1\" class=\"t1\">";
				tbinfo += "<tr>";
				tbTitle += "<th>序号</th><th>类型</th><th>状态</th>";
				tbTitle += "<th>详细</th><th style=\"width:80px;\">用户账号</th><th>受理人员</th>";
				tbTitle += "<th>派工人员</th><th>业务区域</th>"; //<th>目前区域</th>";
				tbTitle += "<th>当前部门</th><th>用户姓名</th>";
	            if("p_changename".equals(sYwlx) || "transfer".equals(sYwlx)){						//电话更名 宽带过户
	            	tbTitle += "<th>原姓名</th>";
	            }
	            tbTitle += "<th>用户地址</th>";
	            if("p_movephone".equals(sYwlx) || "move".equals(sYwlx)){							//电话移机 宽带移机
	            	tbTitle += "<th>原地址</th>";
	            }
	            tbTitle += "<th>部门超时</th><th>工单超时</th></tr>";

	            //if(rstbinfo.getRow()!=0){
	            //for (int i = 0; i < jobTypes.size(); i++) {
            		String jobType = jobTypes.get(0);
            		String title = titles.get(0);
            		/*
	            	if (i > 0) {
	            		try {
	            			//rs.close();
	            			//rstbinfo.close();
	            			callJobGetStatInfo(conn, params, jobType, rs, rstbinfo);
	            		} 
	            		catch(Exception e) {
	            			System.out.println("What's happen?");
	            		}
	            	} */
					while(rstbinfo.next()){
						String iType = rstbinfo.getString(rsmdtbinfo.getColumnName(17));
						if("1".equals(iType)){		//新工单
							sNew += "<tr height=\"25px\" class=\"trclass\" id=\"jobtr"+iNew+"\">";									
							sNew += "<td class=\"jobtabclass\"><input name=\"jobchk1\" value=\""+rstbinfo.getString(rsmdtbinfo.getColumnName(1)) 		//工单ID
								+"\" type=\"checkbox\"/></td>";
							sNew += "<td class=\"jobtabclass\">" + iNew + "</td>";
							//sNew += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(7))		//工单类型 
							//	+ ".gif\" alt=\"工单类型\"/></td>";
							sNew += "<td class=\"jobtabclass\">" + title + "</td>";
							sNew += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(8))		//工单状态 
								+ ".gif\" alt=\"工单状态\"/></td>";	
							sNew += "<td class=\"jobtabclass\"><a href=\"#\" onclick=javascript:readJobDetail("+rstbinfo.getString(rsmdtbinfo.getColumnName(1))//工单ID
								+",\""+rstbinfo.getString(rsmdtbinfo.getColumnName(4))																	//目前部门
								+"\")><img src=\"style/images/public/ltubiao_03.gif\" alt=\"工单详细\"/></a></td>";
							sNew += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(9))+ "</td>";		//用户账号
							sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(18)) + "</td>";		//受理人员
							sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(5)) + "</td>";		//派工人员
							sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(2)) + "</td>";		//所属区域
							// Removed by zhumengfeng at 2016/06/11
							//sNew += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(3)) + "</td>";		//目前区域
							sNew += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(4)) + "</td>";		//当前部门
							sNew += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(10))+ "</td>";		//用户姓名
							if("p_changename".equals(sYwlx) || "transfer".equals(sYwlx)){
								sNew += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(11))+ "</td>";	//原用户姓名
							}
							sNew += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(12))+ "</td>";		//用户地址
							if("p_movephone".equals(sYwlx) || "move".equals(sYwlx)){
								sNew += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(13))+ "</td>";	//原用户地址
							}
							sNew += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(14))+ "</td>";		//部门超时
							sNew += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(15))+ "</td>";		//工单超时
							sNew += "</tr>";
							iNew++;
						}else if("2".equals(iType)){//未处理工单
							sUntreated += "<tr height=\"25px\" class=\"trclass\" id=\"jobtr"+iUntreated+"\">";						
							sUntreated += "<td class=\"jobtabclass\"><input name=\"jobchk2\" value=\""+rstbinfo.getString(rsmdtbinfo.getColumnName(1))			// 工单ID
								+"\" type=\"checkbox\"/></td>";
							sUntreated += "<td class=\"jobtabclass\">" + iUntreated + "</td>";
							//sUntreated += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(7)) + ".gif\" alt=\"工单类型\"/></td>";
							sUntreated += "<td class=\"jobtabclass\">" + title + "</td>";
							sUntreated += "<td class=\"jobtabclass\"><img src=\"style/images/public/" + rstbinfo.getString(rsmdtbinfo.getColumnName(8)) + ".gif\" alt=\"工单状态\"/></td>";
							sUntreated += "<td class=\"jobtabclass\"><a href=\"#\" onclick=javascript:readJobDetail("+rstbinfo.getString(rsmdtbinfo.getColumnName(1))+",\""
								+rstbinfo.getString(rsmdtbinfo.getColumnName(4))+"\")><img src=\"style/images/public/ltubiao_03.gif\" alt=\"工单详细\"/></a></td>";
							sUntreated += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(9))+ "</td>";		//用户账号
							sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(18)) + "</td>";		//受理人员
							sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(5)) + "</td>";		//派工人员
							sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(2)) + "</td>";		//所属区域
							// Removed by zhumengfeng at 2016/06/11
							//sUntreated += "<td class=\"jobtabclass\" style=\"width:60px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(3)) + "</td>";		//目前区域
							sUntreated += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(4)) + "</td>";		//当前部门
							sUntreated += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(10))+ "</td>";		//用户姓名
							if("p_changename".equals(sYwlx) || "transfer".equals(sYwlx)){
								sUntreated += "<td class=\"jobtabclass\" style=\"width:80px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(11))+ "</td>";	//原用户姓名
							}
							sUntreated += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(12))+ "</td>";		//用户地址
							if("p_movephone".equals(sYwlx) || "move".equals(sYwlx)){
								sUntreated += "<td class=\"jobtabclass\" style=\"width:120px\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(13))+ "</td>";	//原用户地址
							}
							sUntreated += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(14))+ "</td>";								//部门超时
							sUntreated += "<td class=\"jobtabclass\">" + rstbinfo.getString(rsmdtbinfo.getColumnName(15))+ "</td>";								//工单超时
							sUntreated += "<td style=\"display:none\" id=\"flowparam"+rstbinfo.getString(rsmdtbinfo.getColumnName(1))+"\" >" 					
								+  sYwlx+rstbinfo.getString(rsmdtbinfo.getColumnName(19)) + "@" + rstbinfo.getString(rsmdtbinfo.getColumnName(2)) + "@" + rstbinfo.getString(rsmdtbinfo.getColumnName(6)) + "</td>";	//提交下一级流转部门需要的参数
							sUntreated += "</tr>";
							iUntreated++;
						}
					}
					conn.commit();//事务提交
				//}
				
				for (int i = 1; i < jobTypes.size(); i++) {
					String parm = params.replace("ywlx=;", "ywlx=" + jobTypes.get(i));
					System.out.println("parm=" + parm);
					OutParam outParam = getStateInfo(datasource, parm, jobTypes.get(i), titles.get(i));
					System.out.println("outParam.iNew=" + outParam.iNew);
					if (outParam != null) {
						//iUntreated += outParam.iUntreated;
						//iNew += outParam.iNew;
						sUntreated += outParam.sUntreated;
						sNew += outParam.sNew;
						newjobs += outParam.iNew - 1;
						untreatedjobs += outParam.iUntreated - 1;
					}
					
				}
            }
			
				//window.onload =function() {a(); b();}
				//document.getElementById("user_login").innerHTML='xxx'
				//在拼接html时注意'"'，否则可能会在前台显示不出来
				/**
				System.out.println("===============================================================");
				System.out.println("Menu: "+menuDiv);
				System.out.println("===============================================================");
				System.out.println("Job New Info:"+tbinfo+tbTitle+sNew);
				System.out.println("===============================================================");
				System.out.println("Job Untreated Info:"+tbinfo+sUntreated);
				System.out.println("===============================================================");
				*/
				//是否有待处理的工单
				if(!"".equals(menuDiv)){
					//火狐和ie，兼容性问题，innerText与textContent的不同
					returnHtml += "<script type='text/javascript'>";
					//是否已处理完毕该业务类型的工单
					if("".equals(tbinfo)){
						returnHtml += "$('#iComplete').text(1);";			
					}else{
						returnHtml += "$('#iComplete').text(2);";					
					}
					//returnHtml += "window.onload=function(){";
					returnHtml += "$('#ywlxCount').text('"+iCount+"');";			//显示菜单导航
					returnHtml += "$('#thisYwlx').text('"+sYwlx+"');";				//当前业务类型		
					returnHtml += "$('#newjobs').text("+newjobs+");";				//新工单条数
					returnHtml += "$('#untreatedjobs').text("+untreatedjobs+");";	//未处理工单条数
					//returnHtml += "$('#menudiv').html('"+menuDiv+"');";				//显示菜单导航
					returnHtml += "$('#disnewjobs').html('"+tbinfo
							+"<th class=\"jobtabclass\"><input id=\"thchecked1\" type=\"checkbox\"/></th>"
							+tbTitle+sNew+"</table>');";							//新工单详细信息
					returnHtml += "$('#disuntreatedjobs').html('"+tbinfo
							+"<th class=\"jobtabclass\"><input id=\"thchecked2\" type=\"checkbox\"/></th>"
							+tbTitle+sUntreated+"</table>');";						//未处理工单详细信息
					//returnHtml += "}";
					returnHtml += "</script>";
				}
			//}
			//String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
			//xmls+="<row flags='"+flags+"' />";
			ClientOutPut.printout(response, returnHtml, ""); //将执行的结果返回给客户端
			return;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 调用jobGetDetailInfo过程，查看工单详细信息
	 * @param datasource	数据源
	 * @param jobid			工单ID
	 * @param response		输出内容
	 */
	public void jobGetDetailInfo(String datasource,String params,HttpServletResponse response){
		Connection conn = null;
		CallableStatement call = null;
		ResultSet rs;
		ResultSet rstbinfo;
		try {
			String dataSourceName = LoadProperties.getKeyValues("mainSystem",datasource);// 取得数据库链接
			conn = DBhelper.getConnection(dataSourceName);// 根据配置的数据源获得连接
			String dbName = DBhelper.getDatabaseProductName(conn);// 根据数据连接获得数据库名
			conn.setAutoCommit(false);//设置是否自动提交
			call = conn.prepareCall("{call jobGetDetailInfo(?,?,?)}");//获取工单和业务基本信息
			if("oracle".equalsIgnoreCase(dbName)){
				call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				call.registerOutParameter(3, OracleTypes.CURSOR);// 注册输出参数
			}
			else if("enterprisedb".equalsIgnoreCase(dbName)){
				call.setNull(2, Types.REF);
				call.registerOutParameter(2, Types.REF);// 注册输出参数
				call.setNull(3, Types.REF);
				call.registerOutParameter(3, Types.REF);// 注册输出参数
			}
			call.setString(1, params);//设置参数
			call.execute();//执行过程
			//获取工单基本信息
			rs =  (ResultSet)call.getObject(2);						//获取返回游标的值
			//获取业务基本信息
			rstbinfo =  (ResultSet)call.getObject(3);				//获取返回游标的值
			ResultSetMetaData rsmd = rs.getMetaData();				//获取游标返回结果集
			ResultSetMetaData rsmdtbinfo = rstbinfo.getMetaData();	//获取游标返回结果集
			//System.out.println("Rsmdtbinfo getColumnCount："+rsmdtbinfo.getColumnCount());
			String res = "";
			//正常返回工单数据
			String busiInfo = "";
			boolean flag = false;//是否可对工单进行管理，有业务处理数据
			while(rs.next()){
				//返回字段：internetacct, busitype, status, jobdate, userid, billno, area, dept, fee, memo
				String isVal = rs.getString(rsmd.getColumnName(1));//正确：返回用户姓名；错误：返回FAILED
				if(null!=isVal && !"FAILED".equals(isVal)){
					for(int i = 1 ; i <= rsmd.getColumnCount();i++){
						//System.out.println("["+rsmd.getColumnName(i)+" : "+rs.getString(rsmd.getColumnName(i))+"]");
						res += rs.getString(rsmd.getColumnName(i))+"@";
					}
					if(flag==false){//正常工单可返回结果集
						flag = true;
					}
					//System.out.println("Show resInfo："+ res);
					//res = res.substring(0, res.lastIndexOf("@"));
				}else{
					busiInfo =  rs.getString(rsmd.getColumnName(2));//返回错误信息
				}
			}
			if(flag){
				while(rstbinfo.next()){
					for(int i = 1 ; i <= rsmdtbinfo.getColumnCount();i++){
						//System.out.println("["+rsmdtbinfo.getColumnName(i)+" : "+rstbinfo.getString(rsmdtbinfo.getColumnName(i))+"]");
						busiInfo += rstbinfo.getString(rsmdtbinfo.getColumnName(i))+"@";
					}
				}
				//System.out.println("Show busiInfo："+ busiInfo);
				//busiInfo = busiInfo.substring(0, busiInfo.lastIndexOf("@"));
			}
			//System.out.println("Show val："+ res+"~"+busiInfo);
			conn.commit();//事务提交
			ClientOutPut.printout(response, res+"~"+busiInfo, ""); //将执行的结果返回给客户端
			return;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
