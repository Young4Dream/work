<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet,java.sql.SQLException,java.sql.Statement" %>
<%@ page import="com.tsd.dao.DBhelper,com.tsd.service.util.LoadProperties" %>
<%@ page import="java.net.*" %>
<%	
	String docname ="";//文件名
	Connection conn = null;
	Statement st = null;
	ResultSet rs = null;
	out.clear();
	response.reset();
	response.setContentType("application/octet-stream;charset=utf-8");
	response.setCharacterEncoding("UTF-8");
	
	response.setLocale(new java.util.Locale("zh","CN"));
	String s = "attachment; filename="; 
	try {
		
		DriverManager.registerDriver(new com.edb.Driver());
		conn = DBhelper.getConnection(LoadProperties.getKeyValues("mainSystem", "tsdBilling"));//根据配置的数据源获得连接
		conn.setAutoCommit(false);
		st = conn.createStatement(); 
		//获得主键id
		String idstr = request.getParameter("id") == null ? ""	: request.getParameter("id");
		int id = Integer.parseInt(idstr);
		String sqlstr = "SELECT doctype,docname,doccontext FROM air_document WHERE id= "+id;
		
		rs = st.executeQuery( sqlstr ); 			 
		 if (rs.next()) { 
			 int doctype = rs.getInt(1);
			 docname = rs.getString(2);
			 byte[] b = rs.getBytes(3);
			 
			 s+=URLEncoder.encode(docname,"UTF-8");
			response.setHeader("Content-Disposition", s);
			response.setHeader("Content-Length", new Integer(b.length)
					.toString());
			response.getOutputStream().write(b, 0, b.length);
			response.getOutputStream().flush();
			out.clear();
			out = pageContext.pushBody();		
			//response.flushBuffer();
			//response.getOutputStream().close();        
		 }
	} catch (SQLException ex) {
		ex.printStackTrace();
	}  catch (Exception e) {
		e.printStackTrace();
	}
	finally{
		
	   try {
		 //依次关闭  
			conn.commit();
			st.close();
			conn.close();
			rs = null;
			conn = null;
			st = null;
		} catch (SQLException ee) {
			ee.printStackTrace();
		}
	}	
%>