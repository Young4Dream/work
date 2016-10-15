package com.tsd.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class JumpServlet extends HttpServlet {

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
			//返回数据格式：pagename=busManagement/AddUser.jsp&imenuid=1001&pmenuname=宽带业务受理&imenuname=开户
			String pagename = request.getParameter("jumppage");
			
			if(null!=pagename&&!"".equals(pagename)){
				String[] disarr = pagename.split("~");
				String params = "";
				params += "?imenuid="+disarr[1];
				params += " &pmenuname="+disarr[2];
				params += " &imenuname="+disarr[3];
				HttpSession session = request.getSession();
				String groupid = (String)session.getAttribute("groupid");
				params += "&groupid="+groupid;
				String dispage = disarr[0]+params;
				System.out.println(dispage);
				
				request.getRequestDispatcher("/WEB-INF/template/"+dispage).forward(request, response);
			}
	}
}
