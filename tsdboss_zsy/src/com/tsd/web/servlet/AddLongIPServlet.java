package com.tsd.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.jobschedule.getJobTask;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LoadProperties;

public class AddLongIPServlet extends HttpServlet {

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
			String userid = request.getParameter("userkey");
			String longip = request.getParameter("longip");
			addLogIP(longip,userid);
	}
	
	//激活工单
	public void addLogIP(String longip,String userid){
		Connection conn = null;
		PreparedStatement ps=null;
		String sql = "UPDATE sys_user set canloginip=? where userid=?";
		try {
				//取得数据库链接
				conn = DBhelper.getConnection(LoadProperties.getKeyValues("mainSystem", "tsdBilling"));//根据配置的数据源获得连接
				ps = conn.prepareStatement(sql);
				ps.setString(1, longip);
				ps.setString(2, userid);
				int i = ps.executeUpdate();
				System.out.println("exec add ip:>>>>>>>>"+i);
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
