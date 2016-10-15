package com.tsd.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;
public class adduserlog extends HttpServlet {

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
		
		String useridaddlog = request.getParameter("useridaddlog");
		String titlename1 = request.getParameter("titlename1");
		String logcontent1 = request.getParameter("logcontentto1");
		//String EditorAccessibility = request.getParameter("logcontentto1");
		String imenuid = request.getParameter("imenuidto");
		String pmenuname = request.getParameter("pmenunameto");
		String imenuname = request.getParameter("imenunameto");
		String groupid = request.getParameter("zidto");
		String logtype = request.getParameter("logtype");//提交的操作类型：1为添加保存，2为修改保存
		String id = request.getParameter("updateid");//执行修改的时候根据主键ID值来修改相应数据
		int upid;		
		System.out.println(titlename1 + "*****************"+useridaddlog+"*****************"+ logcontent1);
		System.out.println("logtype:"+logtype);
		int logtypeint;
		logtypeint = Integer.parseInt(logtype);
		 if(logtypeint==1){
			//操作类型logtype为1的时候执行添加保存操作
			try{
				/**
				Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver").newInstance();
				String url = "jdbc:microsoft:sqlserver://192.168.44.4:1433;DatabaseName=telcount2009billing";			
				String user = "tsd";
				String password = "tsd";**/
				Connection conn=null;
				PreparedStatement stmt=null;
				String b = "NO";
					try {
						//取得数据库链接
						String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");
						conn = DBhelper.getConnection(dataSourceName);						
						//conn= DriverManager.getConnection(url,user,password);
						stmt= conn.prepareStatement("insert into userlog(userid,logname,logcontent) values(?,?,?)");
						stmt.setString(1, useridaddlog);
						stmt.setString(2, titlename1);
						stmt.setString(3, logcontent1);
						int rst=stmt.executeUpdate(); 
						if(rst!=0){ 
						b="YES"; 												
						} 
						request.setAttribute("b", b);				    
						String pagename = "myfavorites/StaffBlog.jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid;												
						request.getRequestDispatcher("/WEB-INF/template/"+pagename).forward(request, response);
						
						//System.out.println("imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid);
						//System.out.println(b+"*********************************************************");							
					} catch (SQLException e){
						// TODO Auto-generated catch block
						e.printStackTrace();
					}finally{
						try {
							stmt.close();
							conn.close(); 
						} catch (SQLException e){
							// TODO Auto-generated catch block
							e.printStackTrace();
						}						
					} 
			 }catch (Exception e){
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }else if(logtypeint==2){
	    	//操作类型logtype为2的时候执行修改保存操作
	    	upid = Integer.parseInt(id);//将字符串ID值转换成int类型
	    	try{				
				Connection conn=null;
				PreparedStatement stmt=null;
				String b = "NO";
					try {
						//取得数据库链接
						String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");
						conn = DBhelper.getConnection(dataSourceName);
						//conn= DriverManager.getConnection(url,user,password);
						stmt= conn.prepareStatement("update userlog set logname=?,logcontent=? where id=?");						
						stmt.setString(1, titlename1);
						stmt.setString(2, logcontent1);
						stmt.setInt(3, upid);
						int rst=stmt.executeUpdate(); 
						if(rst!=0){
						b="YES"; 												
						} 
						request.setAttribute("b", b);
						String pagename = "myfavorites/StaffBlog.jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid;												
						request.getRequestDispatcher("/WEB-INF/template/"+pagename).forward(request, response);						
						//System.out.println("imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid);
						//System.out.println(b+"*********************************************************");							
					} catch (SQLException e){
						e.printStackTrace();
					}finally{
						try{
							stmt.close();
							conn.close();														
						}catch (SQLException e){
							e.printStackTrace();
						}						
					} 
			 }catch (Exception e){
				e.printStackTrace();
			}	    	
	    }
	}
 }

