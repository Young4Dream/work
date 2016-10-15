package com.tsd.service;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.HTMLFilter;

public class charge_phone extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Boolean tsdSQLPrint = DBhelper.tsdSQLPrint;
	private static final Boolean tsdResultPrint = DBhelper.tsdResultPrint;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		CallableStatement call = null;
		//PreparedStatement ps=null;
		ResultSet rs_power = null;
		ResultSet rs_payitem = null;
		ResultSet rs_tsdini = null;
		String paramters="";
		String sPayitem="", sPower="", sRes="";
		String sFunc = request.getParameter("func");
		//验证当前会话是否有效
		HttpSession session = request.getSession();
		if (null == session.getAttribute("userid"))
		{
			ClientOutPut.printout(response, "session invalid", "");
			return;
		}
		//工号
		String sUserID = (String)session.getAttribute("userid");
		//营业区域
		String sArea = (String)session.getAttribute("chargearea");
		//语言
		String sLang =(String) session.getAttribute("languageType");
		paramters = "language="+sLang+";";
		conn = DBhelper.getConnection("tsdboss");//根据配置的数据源获得连接
		String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名	
		try
		{	
			System.out.println("===================================================================================");
			conn.setAutoCommit(false);//是否进行自动提交
			if (sFunc.equalsIgnoreCase("init"))
			{ 
				//收费页面显示加载数据
				String sGroup = request.getParameter("groupid");//权限组ID
				String smenuid = request.getParameter("imenuid");//菜单ID
				String spaytype = request.getParameter("pay_type");//收费类型
				//groupcustomer：大客户收费；normalcustomer：普通用户收费
				if(!"groupcustomer".equalsIgnoreCase(spaytype)){
					spaytype = "normalcustomer";
				}
				///执行存储过程获取结果集
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_init(?,?,?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
					call.registerOutParameter(3, OracleTypes.CURSOR);// 注册输出参数
					call.registerOutParameter(4, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_init(?,?,?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
					call.setNull(3,Types.REF);
					call.registerOutParameter(3, Types.REF);
					call.setNull(4,Types.REF);
					call.registerOutParameter(4, Types.REF);
				}else if ("PostgreSQL".equalsIgnoreCase(dbName))
				{
					call = conn.prepareCall("{call charge_init(?,?,?,?)}");
					call.registerOutParameter(2, Types.OTHER);
					call.registerOutParameter(3, Types.OTHER);
					call.registerOutParameter(4, Types.OTHER);
				}else{
					call =conn.prepareCall("{call charge_init(?)}");
				}
				paramters += "userid="+sUserID+";groupid="+sGroup+";menuid="+smenuid + ";paytype=" + spaytype;
				if(tsdSQLPrint){
					System.out.println("[charge_init],[DBName]: "+dbName+",[Params]:"+paramters);
				}
				call.setObject(1, paramters);
				// 适应不同数据库
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) || "PostgreSQL".equalsIgnoreCase(dbName)) {
					call.execute();
					rs_power = (ResultSet) call.getObject(2);//取权限
					rs_payitem = (ResultSet) call.getObject(3);//取收费方式
					rs_tsdini = (ResultSet)call.getObject(4);
				} else {
					rs_power = call.executeQuery();
				}
				/**
				st = conn.createStatement();
				rs = st.executeQuery(sql);
				ResultSetMetaData rsmd = rs.getMetaData();
				int columnCount = rsmd.getColumnCount();
				*/
				while (rs_payitem.next()) 
				{
					sRes = rs_payitem.getString(1);
					if (sRes.equals("FAILED"))//过程执行失败
					{
						sPayitem = sRes+":"+rs_payitem.getString(2);
						break;
					}
					sPayitem=sPayitem+"<option rptfile=\"" + rs_payitem.getString(2) + "\" cval=\""
					    + rs_payitem.getString(3) +"\" value=\"" + rs_payitem.getString(3) +"\"" 
					    + (rs_payitem.getString(1)==""?" selected=\"selected\"":"") + ">" 
					    + rs_payitem.getString(1) + "</option>";
					//sPayitem = sPayitem+rs_payitem.getString(1)+";"+rs_payitem.getString(2)+";"+rs_payitem.getString(3)+"||";
				}
				while (rs_power.next()) 
				{
					sPower = sPower+rs_power.getString(1)+"||";
				}
				sPower = "<power="+sPower+"power/>";
				sPayitem = "<payitem="+sPayitem+"payitem/>";
				
				String tsdini_cfg = "";
				while(rs_tsdini.next()){
					tsdini_cfg = tsdini_cfg + "\"" + rs_tsdini.getString(1) + "_" + rs_tsdini.getString(2) + "\":\"" + rs_tsdini.getString(3) + "\"";
				}
				tsdini_cfg = "<tsdcfg={"+tsdini_cfg+"}tsdcfg/>";
				if(tsdResultPrint){
					System.out.println("[charge_init],[Result]: "+sPayitem+sPower+tsdini_cfg);
				}
				ClientOutPut.printout(response, sPayitem+sPower+tsdini_cfg, "");
				/*				
 				response.setContentType("text/html");
		  		response.setContentType("application/XML,charset=UTF-8");
				response.setHeader("Charset", "UTF-8");
				response.setCharacterEncoding("UTF-8");
				*/
				//<power=1;2||1;2||power/><payitem=1;2;3||1;2;3||payitem/>
			}//end init
			else if (sFunc.equalsIgnoreCase("unload"))//页面退出时清空临时表数据
			{
				 ///执行存储过程获取结果集
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_clear(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_clear(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}else if ("PostgreSQL".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_clear(?,?)}");
					call.registerOutParameter(2, Types.OTHER);
				}else{
					call =conn.prepareCall("{call charge_clear(?)}");
				}
				paramters += "userid="+sUserID;
				if(tsdSQLPrint){
					System.out.println("[charge_clear],[DBName]: "+dbName+",[Params]: "+paramters);
				}
				call.setObject(1, paramters);
				// 适应不同数据库
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) || "PostgreSQL".equalsIgnoreCase(dbName)) {
					call.execute();
					rs_payitem = (ResultSet) call.getObject(2);
				} else {
					rs_payitem = call.executeQuery();
				}
				if(tsdResultPrint){
					System.out.println("[charge_clear],[Result]: "+sPayitem);
				}
				ClientOutPut.printout(response, sPayitem, "");
			}//end unload
			else if (sFunc.equalsIgnoreCase("find"))
			{
				String sSffs = request.getParameter("sSkfs");//收款方式
				String sDh = request.getParameter("dh");
				String sKemu = request.getParameter("Kemu");
				String dkhflag = request.getParameter("DKHFlag");
				String Sj_SfMonth = null == request.getParameter("Sj_SfMonth")?"":request.getParameter("Sj_SfMonth");//本次交款月份
				 ///执行存储过程获取结果集
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_find(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_find(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}else if ("PostgreSQL".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_find(?,?)}");
					call.registerOutParameter(2, Types.OTHER);
				}else{
					call =conn.prepareCall("{call charge_find(?)}");
				}
				paramters += "Sj_SfMonth="+Sj_SfMonth+";SkrID="+sUserID+";Area="+sArea+";Hth="+sDh+";sSkfs="+sSffs+";Kemu="+sKemu+";Version=200404";
				if(tsdSQLPrint){
					System.out.println("[charge_find],[DBName]: "+dbName+",[Params]: "+paramters);
				}
				//大客户缴费标志
				if("Y".equalsIgnoreCase(dkhflag)){
					paramters += ";DKHFlag=Y;tickettype=combined;";
				}
				call.setObject(1, paramters);				
				// 适应不同数据库
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) || "PostgreSQL".equalsIgnoreCase(dbName)) {
					call.execute();
					rs_payitem = (ResultSet) call.getObject(2);
				} else {
					rs_payitem = call.executeQuery();
				}
				StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
				xmls.append("<rows>");
				ResultSetMetaData  rsmd = rs_payitem.getMetaData();
				int columnCount=rsmd.getColumnCount();
				while (rs_payitem.next()) 
				{
					sPayitem = "";
					xmls.append("<row ");
					sRes = rs_payitem.getString(1);
					if (sRes.equals("FAILED"))//过程执行失败
					{
						//sPayitem = sRes+":"+rs_payitem.getString(2);
						xmls.append(rsmd.getColumnLabel(1).toLowerCase()).append("=\"").append(rs_payitem.getString(1)).append("\" ").append(rsmd.getColumnLabel(2).toLowerCase()).append("=\"").append(rs_payitem.getString(2)).append("\"");
						xmls.append("></row>");
						break;
					}
					for (int j = 1; j <= columnCount; j++) {
						/**
						if (rsmd.getColumnTypeName(j).equals("NUMBER"))
						{
							sPayitem = rs_payitem.getFloat(j);
						}
						else
						{
							sPayitem = rs_payitem.getString(j);
						}	
  						if (sPayitem==null || sPayitem.equals("0")|| sPayitem.equals("0.0"))
						{
							sPayitem = "";
						}*/
						Object objdata = rs_payitem.getObject(j)==null ? "" : HTMLFilter.filter(rs_payitem.getObject(j).toString());
						//objdata = objdata.toString() == "0" ? "" : objdata;
						if (objdata.toString().equals("0") || objdata.toString().equals("null"))
						{
							objdata = "";
						}
						xmls.append(rsmd.getColumnLabel(j).toLowerCase()).append("=\"").append(objdata).append("\" ");
					}

					xmls.append("></row>");
				}
				xmls.append("</rows>");
				if(tsdResultPrint){
					System.out.println("[charge_find],[Result]: "+xmls.toString());
				}
				//System.out.println("[charge_phone find xml]："+xmls.toString());
				ClientOutPut.printout(response, xmls.toString(), "xml");
				/*		  		
 				response.setContentType("application/XML,charset=UTF-8");
				response.setHeader("Charset", "UTF-8");
				response.setCharacterEncoding("UTF-8");
				*/
			}//end find
			else if (sFunc.equalsIgnoreCase("save"))
			{
				String sSffs = request.getParameter("Skfs");
				String sDh = request.getParameter("dh");
				String sKemu = request.getParameter("Kemu");
				String sBcss = request.getParameter("Bcss");
				String loginfo = request.getParameter("loginfo");
				String hbdy = request.getParameter("hbdy");
				String prepay = request.getParameter("prepay");
				String dkhnum = request.getParameter("inputdata");
				String fewtype = null == request.getParameter("fewtype")?"":request.getParameter("fewtype");//少收方式
				String skVal = null == request.getParameter("Skval")?"":request.getParameter("Skval");//支票号
				 ///执行存储过程获取结果集
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_save(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_save(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}else if ("PostgreSQL".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_save(?,?)}");
					call.registerOutParameter(2, Types.OTHER);
				}else{
					call =conn.prepareCall("{call charge_save(?)}");
				}
				paramters += "Skval="+skVal+";fewtype="+fewtype+";SkrID=" + sUserID + ";Area=" + sArea + ";Hth="
						+ sDh + ";Skfs=" + sSffs + ";Kemu=" + sKemu
						+ ";Version=200404;Bcss=" + sBcss + ";prepay=" + prepay
						+ ";hbdy=" + hbdy + ";loginfo=" + loginfo + ";" + ((dkhnum==null || dkhnum=="")?"":"inputdata=" + dkhnum + ";");
				if(tsdSQLPrint){
					System.out.println("[charge_save],[DBName]: "+dbName+",[Params]: "+paramters);
				}
				call.setObject(1, paramters);
				// 适应不同数据库
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) || "PostgreSQL".equalsIgnoreCase(dbName)) {
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
				if(tsdResultPrint){
					System.out.println("[charge_save],[Result]: "+xmls.toString());
				}
				ClientOutPut.printout(response, xmls.toString(), "xml");
			}//end save
			else if (sFunc.equalsIgnoreCase("detail"))//取欠费明细
			{
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_detail(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_detail(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}else if ("PostgreSQL".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_detail(?,?)}");
					call.registerOutParameter(2, Types.OTHER);
				}else{
					call =conn.prepareCall("{call charge_detail(?)}");
				}
				paramters += "SkrID="+sUserID;
				if(tsdSQLPrint){
					System.out.println("[charge_detail],[DBName]: "+dbName+",[Params]: "+paramters);
				}
				call.setObject(1, paramters);
				// 适应不同数据库
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) || "PostgreSQL".equalsIgnoreCase(dbName)) {
					call.execute();
					rs_payitem = (ResultSet) call.getObject(2);
				} else {
					rs_payitem = call.executeQuery();
				}
				int i=1;

				sPayitem += "<tr>";
				sPayitem += "<td style=\"background-color:#CAD6E1\">ID</td>";
				ResultSetMetaData  rsmd = rs_payitem.getMetaData();
				int columnCount=rsmd.getColumnCount();
				for (int k = 1; k <= columnCount; k++) 
				{
					sPayitem += "<td  style=\"background-color:#CAD6E1\">"+rsmd.getColumnLabel(k)+"</td>";				
				}
				sPayitem += "</tr>";
				while (rs_payitem.next()) 
				{
					sRes = rs_payitem.getString(1);
					if (sRes.equals("FAILED"))//过程执行失败
					{
						sPayitem = sRes+":"+rs_payitem.getString(2);
						break;
					}
					sPayitem += "<tr>";
					if ((i % 2)==0)
					{
						sPayitem += "<td style=\"background-color:#EAEAEA\">";
					}
					else
					{
						sPayitem += "<td>";
					}
					sPayitem += i++;
					sPayitem += "</td>";
					for (int j = 1; j <= columnCount; j++) 
					{
						Object objdata = rs_payitem.getObject(j)==null ? "" : HTMLFilter.filter(rs_payitem.getObject(j).toString());
						if (objdata.toString().equals("null"))
						{
							objdata = "";
						}
						if (((i-1) % 2)==0)
						{
							sPayitem += "<td style=\"background-color:#EAEAEA\">";
						}
						else
						{
							sPayitem += "<td>";
						}
						sPayitem += objdata;
						sPayitem += "</td>";
					}
					sPayitem += "</tr>";
					
				}
				if(tsdResultPrint){
					System.out.println("[charge_detail],[Result]: "+sPayitem);
				}
				ClientOutPut.printout(response, sPayitem, "");
			}
			else if (sFunc.equalsIgnoreCase("checkout"))//拆机结账或退费
			{
				String sDh = request.getParameter("dh");
				
				 ///执行存储过程获取结果集
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_checkout(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_checkout(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}else if ("PostgreSQL".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call charge_checkout(?,?)}");
					call.registerOutParameter(2, Types.OTHER);
				}else{
					call =conn.prepareCall("{call charge_checkout(?)}");
				}
				paramters += "SkrID="+sUserID+";dh="+sDh;
				if(tsdSQLPrint){
					System.out.println("[charge_checkout],[DBName]: "+dbName+",[Params]: "+paramters);
				}
				call.setObject(1, paramters);
				// 适应不同数据库
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) || "PostgreSQL".equalsIgnoreCase(dbName)) {
					call.execute();
					rs_payitem = (ResultSet) call.getObject(2);
				} else {
					rs_payitem = call.executeQuery();
				}
				StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
				xmls.append("<rows>");
				ResultSetMetaData  rsmd = rs_payitem.getMetaData();
				int columnCount=rsmd.getColumnCount();
				while (rs_payitem.next()) 
				{
					sPayitem = "";
					xmls.append("<row ");
					sRes = rs_payitem.getString(1);
					if (sRes.equals("FAILED"))//过程执行失败
					{
						xmls.append(rsmd.getColumnLabel(1).toLowerCase()).append("=\"").append(rs_payitem.getString(1)).append("\" ").append(rsmd.getColumnLabel(2).toLowerCase()).append("=\"").append(rs_payitem.getString(2)).append("\"");
						xmls.append("></row>");
						break;
					}
					for (int j = 1; j <= columnCount; j++) {
						Object objdata = rs_payitem.getObject(j)==null ? "" : HTMLFilter.filter(rs_payitem.getObject(j).toString());
						if (objdata.toString().equals("0") || objdata.toString().equals("null"))
						{
							objdata = "";
						}
						xmls.append(rsmd.getColumnLabel(j).toLowerCase()).append("=\"").append(objdata).append("\" ");
					}

					xmls.append("></row>");
				}
				xmls.append("</rows>");
				if(tsdResultPrint){
					System.out.println("[charge_checkout],[Result]: "+xmls.toString());
				}
				ClientOutPut.printout(response, xmls.toString(), "xml");
			}//end checkout
			conn.commit();
		} catch (SQLException e) {
			sPayitem = "<payitem="+"FAILED:"+e+"payitem/>";
			StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
			xmls.append("<rows>");
			xmls.append("<row res=\"FAILED\"").append(" tag=").append("\""+e.toString().substring(e.toString().indexOf("ERROR:"))+"\"");
			xmls.append("></row>");
			xmls.append("</rows>");
			System.out.println("[charge_phone exception]: "+ xmls.toString());
			ClientOutPut.printout(response, xmls.toString(), "xml");
			try{
				conn.rollback();
			}catch (SQLException se) {};
			throw new RuntimeException("exceptin when access database:" + e);				
		} finally {
			try {
				conn.setAutoCommit(true);
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
				throw new RuntimeException("charge_phone exception when close the database: " + e);
			}
		}
	}
}
