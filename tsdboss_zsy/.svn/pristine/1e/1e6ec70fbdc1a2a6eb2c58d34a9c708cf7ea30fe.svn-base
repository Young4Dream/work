package com.tsd.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;


public class QHYTMenu {
	
	
	List<String> menuslist = new ArrayList<String>();
	private Connection conn;
	private Statement st;
	private ResultSet rs;

	public void getList(HttpServletRequest request, HttpServletResponse response,Object sadminname) {
		String dsName = request.getParameter("ds");
		
		String sql = "SELECT imenuid,smenuname,smenuurl,iparentid,sparentname,iorder,simgico,isvisible FROM sys_menu";
		
		String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
		try {
			conn = DBhelper.getConnection( LoadProperties.getKeyValues("mainSystem",dsName ));
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			xmls += "<treemenu>";
			while (rs.next()) {
				xmls += "<treenode imenuid=\"" + rs.getInt("imenuid");
				String sMenuName = rs.getString("smenuname");
				xmls += "\" smenuname=\"" + sMenuName + "\" iparentid=\""+rs.getInt("iparentid")+"\" sparentname=\""
						+ rs.getString("sparentname") + "\" smenuurl=\""+rs.getString("smenuurl")
						+"\" iorder=\""+ rs.getInt("iorder") + "\" isvisible=\""+rs.getString("isvisible")+"\" simgico=\""+rs.getString("simgico")+"\" />";
			}
			xmls += "</treemenu>";
			rs.close();
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
					
				}
				if (st != null) {
					st.close();
				}
				if(conn !=null){
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		try {
			response.setContentType("application/XML,charset=UTF-8");
			response.setHeader("Charset","UTF-8"); 
			response.setCharacterEncoding("UTF-8"); 
			response.setContentType("text/xml");
			System.out.println(xmls);
			PrintWriter out = response.getWriter();
			out.write(xmls);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
