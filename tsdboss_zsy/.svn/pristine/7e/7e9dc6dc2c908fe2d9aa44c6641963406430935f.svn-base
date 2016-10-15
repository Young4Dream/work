/*****************************************************************
 * name: ProcedureExeFoctory.java
 * author: dangchengcheng
 * version: 
 * description: 执行存储过程用的一个工厂类
 * modify: 2010-11-22 luoyulong 添加注释
 *****************************************************************/
package com.tsd.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.SqlReturnResultSet;
import org.springframework.jdbc.object.StoredProcedure;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.tsd.service.QueryProcedure;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.StringUtil;

public class ProcedureExeFoctory extends StoredProcedure{
	public ProcedureExeFoctory() {
		  //super(DBhelper.dataSource,"myTest");
		  declareParameter(new SqlParameter("querystr",Types.VARCHAR));
		  declareParameter(new SqlReturnResultSet("result",new RowMappers()));
		  compile();

	}
	/***************************************************************************
	 * 此处jdbcTemplate、hibernateTemplate 两个模板对象已初始化自动加载 不需要在进行xml注入或者再次获取 直接调用即可
	 */
	//未使用这两个模板对象，注释于2012-10-16 ，chenliang
	//private static JdbcTemplate jdbcTemplate = DBhelper.jdbcTemplate;
	//private HibernateTemplate hibernateTemplate = DBhelper.hibernateTemplate;
	
	private static final Boolean tsdSQLPrint = DBhelper.tsdSQLPrint;
	private static final Boolean tsdResultPrint = DBhelper.tsdResultPrint;
	//private static ComboPooledDataSource dataSource = DBhelper.dataSource;
	//private static CallableStatement call = null;
	//private static ResultSet rs =null;
	//private static List  dataSet=null;
	//private static Connection conn;
	/*****
	 * 执行存储过程并返回结果集 结果集可以是map 也可以是一个xml结构的字符串
	 * @param request
	 * @param response
	 */
	public static Object exequeryProcedure(String paramters,String ds,HttpServletRequest request,HttpServletResponse response) {
		CallableStatement call = null;
		ResultSet rs =null;
		List  dataSet=null;
		Connection conn = null;
		dataSet=null;
		String page=request.getParameter("page");
		String total="0";
		String records="0";
		HttpSession  session = request.getSession(true);
		String sLang =(String) session.getAttribute("languageType");
		//System.out.println(sLang);
		//Object  obj = session.getAttribute("procedurs");
		//操作类型 querypage：获取分页结果集 query：获取结果集	exe：执行存储过程
		String tsdExeType = request.getParameter("tsdExeType");
		String procedursName="";
		procedursName = QueryProcedure.queryProcedure(request.getParameter("tsdpname"));
		if("".equals(procedursName)){
			//System.out.println("[Procedure is not exist]："+procedursName);
			throw new RuntimeException("The Procedure is not exist："+procedursName);//不存在的存储过程、请注意大小写
		}
		//获取用户指定的返回数据类型 xml/json
		String datatype =  request.getParameter("datatype");
		if (!StringUtil.isNotEmpty(datatype)) {
			datatype ="xml";
		}
		try {
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);	
			conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
			String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
			conn.setAutoCommit(false);
			 if("exe".equalsIgnoreCase(tsdExeType)||"query".equalsIgnoreCase(tsdExeType)){
				 ///执行存储过程获取结果集
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call " + procedursName + "(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call " + procedursName + "(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}else if ("PostgreSQL".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call " + procedursName + "(?,?)}");
					call.registerOutParameter(2, Types.OTHER);
				}else{
				 call =conn.prepareCall("{call "+procedursName+"(?)}");
				}
				paramters = "language="+sLang+";"+paramters;
				call.setObject(1, paramters);
				if("exe".equalsIgnoreCase(tsdExeType)){
					call.execute();
				}else{
					dataSet = new ArrayList<Map>();
					// 适应不同数据库
					if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) || "PostgreSQL".equalsIgnoreCase(dbName)) {
						call.execute();
						rs = (ResultSet) call.getObject(2);
					} else {
						rs = call.executeQuery();
					}
					 	ResultSetMetaData  rsmds = rs.getMetaData();
						int columnCounts=rsmds.getColumnCount();
						while(rs.next()){
							List<DataObj> rowObj=new ArrayList<DataObj>();
							for (int i = 1; i <= columnCounts; i++) {
								DataObj dataObj = new DataObj();
								dataObj.setDataName(rsmds.getColumnLabel(i));
								dataObj.setDataVal(rs.getObject(i));
								rowObj.add(dataObj);
							}
							dataSet.add(rowObj);
						}
					if (!("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName))) {
						while (call.getMoreResults()) {
							dataSet = new ArrayList<Map>();
							rs = call.getResultSet();
							ResultSetMetaData rsmd = rs.getMetaData();
							int columnCount = rsmd.getColumnCount();
							while (rs.next()) {
								List<DataObj> rowObj = new ArrayList<DataObj>();
								for (int i = 1; i <= columnCount; i++) {
									DataObj dataObj = new DataObj();
									dataObj.setDataName(rsmd.getColumnLabel(i));
									dataObj.setDataVal(rs.getObject(i));
									rowObj.add(dataObj);
								}
								dataSet.add(rowObj);
							}
						}
					}
				}
			 }else if("querypage".equalsIgnoreCase(tsdExeType)){
				String sql="{call "+procedursName+"(?,?,?,?)}";
				 ///执行存储过程 获取结果集 并分页
				 ///执行存储过程获取结果集
				 call =conn.prepareCall(sql);//参数串 ，总页数，当前页码，总记录数
				 call.registerOutParameter(2, java.sql.Types.INTEGER);//要向外输出的参数
				 call.registerOutParameter(3, java.sql.Types.INTEGER);//要向外输出的参数
				 call.registerOutParameter(4, java.sql.Types.INTEGER);//要向外输出的参数
				 call.setObject(1, paramters);
				 call.execute();
				 // rs=call.getResultSet();
					dataSet = new ArrayList<Map>();
					rs=call.getResultSet();
					 	ResultSetMetaData  rsmds = rs.getMetaData();
						int columnCounts=rsmds.getColumnCount();
						while(rs.next()){
							List<DataObj> rowObj=new ArrayList<DataObj>();
							for (int i = 1; i <= columnCounts; i++) {
								DataObj dataObj = new DataObj();
								dataObj.setDataName(rsmds.getColumnName(i));
								dataObj.setDataVal(rs.getObject(i));
								rowObj.add(dataObj);
							}
							dataSet.add(rowObj);
						}
					 while(call.getMoreResults()){
							dataSet = new ArrayList<Map>();
						 rs=call.getResultSet();
						 ResultSetMetaData  rsmd = rs.getMetaData();
							int columnCount=rsmd.getColumnCount();
							while(rs.next()){
								List<DataObj> rowObj=new ArrayList<DataObj>();
								for (int i = 1; i <= columnCount; i++) {
									DataObj dataObj = new DataObj();
									dataObj.setDataName(rsmd.getColumnName(i));
									dataObj.setDataVal(rs.getObject(i));
									rowObj.add(dataObj);
								}
								dataSet.add(rowObj);
							}
					}
					rs.close();
					page=call.getObject(2).toString();
					total=call.getObject(3).toString();
					records = call.getObject(4).toString();
					//System.out.println("records:"+records);
			}
			//日志输出等级
			if(tsdSQLPrint){
				System.out.println("===================================================================================");
				System.out.println("[Procedure Name]: "+procedursName);
				System.out.println("[Procedure Params]: "+paramters);
				//System.out.println("=====================================================");
			}
			conn.commit();
		} catch (SQLException e) {
			System.out.println("[Procedure Name]: "+procedursName);
			System.out.println("[Procedure Params]: "+paramters);
			System.out.println("[Procedure Exception]: ");
			try {
				conn.rollback();
				e.printStackTrace();
			} catch (SQLException sqle) {
				System.out.println("[Procedure Rollback Exception]: ");
				sqle.printStackTrace();
			}
		}finally{
				try {
					conn.setAutoCommit(true);
					if (call!=null) {call.close();}
					if (rs != null) {
						rs.close();
						
					}
					if(conn !=null){
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}//将链接返回池中
		if (dataSet==null&&"exe".equalsIgnoreCase(tsdExeType)) {
			ClientOutPut.printout(response, "true", "");return  false;
		}else{
			if(dataSet==null){return  "false";}
		}
		if (dataSet.size()==0&&"exe".equalsIgnoreCase(tsdExeType)) {
			ClientOutPut.printout(response, "true", "");
			return "false";
		}
		///////////////////////////////////////
		///返回Map键值对形式的数据 适用于懂java编程的用户
		/////////////////////////////////////////
		if ("map".equalsIgnoreCase(datatype)) {
			List<Map> dataSetMap = new ArrayList<Map>();
			int length = dataSet.size();
			for (int i = 0; i < length; i++) {
				List<DataObj> temp = (List) dataSet.get(i);
				Map rowMap = new HashMap();
				if(temp.size()!=0&&temp.get(0)!=null){
					int tempSize = temp.size();
					for (int j = 0; j < tempSize; j++) {
						rowMap.put(temp.get(j).getDataName(),  temp.get(j).getDataVal());
					}
				}
				dataSetMap.add(rowMap);
			}
			return dataSetMap;
		}
		///////////////////////////////////////
		///返回xml形式的数据
		/////////////////////////////////////////
		if ("xml".equalsIgnoreCase(datatype)) {
			
			List<Map> dataSetMap = new ArrayList<Map>();
			StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
			xmls.append("<rows>");
			int length = dataSet.size();
			if("querypage".equalsIgnoreCase(tsdExeType)){
				 
				xmls.append("<page>" + page + "</page>");
				xmls.append( "<total>" + total+ "</total>");
				xmls.append("<records>" + records+ "</records>");
			}
			for (int i = 0; i < length; i++) {
				xmls.append("<row");
				String idColumnName=request.getParameter("idColumnName");
			
				List<DataObj> temp = (List) dataSet.get(i);
				if(StringUtil.isNotEmpty(idColumnName)){
					if (temp.size() != 0 && temp.get(0) != null) {
						int tempSize = temp.size();
						for (int j = 0; j < tempSize; j++) {
								if(idColumnName.equals(temp.get(j).getDataName())){
									xmls.append(" id=\"").append(temp.get(j).getDataVal()).append("\"");
									break;
								}
						}
					}
				}
				xmls.append(">");
				if (temp.size() != 0 && temp.get(0) != null) {
					int tempSize = temp.size();
					for (int j = 0; j < tempSize; j++) {
						xmls.append("<cell>").append(temp.get(j).getDataVal()).append("</cell>");
					}
				}
				xmls.append("</row>");
			}
			xmls.append("</rows>");
			if(tsdResultPrint){
				System.out.println("[Procedure XML Result]: "+xmls.toString());
			}
			//System.out.println(xmls.toString());
			return xmls;
		}
		
		 /////////////////////////////////////
		// /返回属性形式的xml数据
		// ///////////////////////////////////////
		if ("xmlattr".equalsIgnoreCase(datatype)) {
			
			List<Map> dataSetMap = new ArrayList<Map>();
			StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
			xmls.append("<rows>");
			int length = dataSet.size();

			for (int i = 0; i < length; i++) {
				xmls.append("<row ");
				List<DataObj> temp = (List) dataSet.get(i);
				if (temp.size() != 0 && temp.get(0) != null) {
					int tempSize = temp.size();
					for (int j = 0; j < tempSize; j++) {
						xmls.append(temp.get(j).getDataName()).append("=\"").append(temp.get(j).getDataVal()).append("\" ");
					}
				}
				xmls.append("></row>");
			}
			xmls.append("</rows>");
			if(tsdResultPrint){
				System.out.println("[Procedure XMLAttr Result]: "+xmls.toString());
			}
			//System.out.println(xmls);
			ClientOutPut.printout(response, xmls.toString(), "xml");
			return xmls;
		}
		///////////////////////////////////////
		///返回JSON形式的数据
		/////////////////////////////////////////
		if ("json".equalsIgnoreCase(datatype)) {
			List<Map> dataSetMap = new ArrayList<Map>();
			String json = "{";
			if("querypage".equalsIgnoreCase(tsdExeType)){
				json += "total: \""+page+"\"";
				json += ", page: \""+page+"\"";
				json += ", records: \""+records+"\",";
			}
			json += "rows : [";
			int length = dataSet.size();
			
			for (int i = 0; i < length; i++) {
				json += "{id:\"2\"";
				json += " cell:[";
				List<DataObj> temp = (List) dataSet.get(i);
				if(temp.size()!=0&&temp.get(0)!=null){
					int tempSize = temp.size();
					for (int j = 0; j < tempSize; j++) {
						json+="\""+temp.get(j).getDataVal()+"\"";
						if (j==tempSize-1) {
							continue;
						}
						json+=",";
					}
				}
				json += "]},";
			}
			json += " ... ]}";
			if(tsdResultPrint){
				System.out.println("[Procedure Json Result]: "+json.toString());
			}
			//System.out.println(json);
			return json;
		}
		return false;
		//{ rows : [ {id:"1", cell:["cell11", "cell12", "cell13"]}, {id:"2", cell:["cell21", "cell22", "cell23"]}, ... ] }
		//{rows : [{id:2 cell:["0","不自动降级"]},{id:2 cell:["1","后付费欠费降级"]},{id:2 cell:["2","预付费欠费降级"]},{id:2 cell:["3","话费限额超额降级"]},{id:2 cell:["ww","wwwwwww"]},...]}
	}
}
