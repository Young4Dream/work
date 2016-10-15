package com.tsd.web.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.javabean.PromainBean;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.Log;

public class PromainServlet extends HttpServlet {
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
			String opertype = request.getParameter("opertype");//操作类型
			String imenuid = request.getParameter("imenuid");
			String pmenuname = request.getParameter("pmenuname");
			String groupid = request.getParameter("groupid");
			String imenuname = request.getParameter("imenuname");
			
			if("add".equals(opertype)||"modify".equals(opertype)){
				String pname = request.getParameter("pname");//存储过程名称
				String pdatabase = request.getParameter("pdatabase");//所属数据源
				String pdatabaseip = request.getParameter("pdatabaseip");//数据源IP
				String pmemo = request.getParameter("pmemo");//刚才内容
				pmemo = pmemo.trim();
				String pcmemo = request.getParameter("pcmemo");//备注信息
				pcmemo = pcmemo.trim();
				String upman = request.getParameter("userid");//操作工号
				String upip = Log.getIpAddr(request);
				
				PromainBean pb = new PromainBean();
				pb.setPname(pname);
				pb.setPdatabase(pdatabase);
				pb.setPdatabaseip(pdatabaseip);
				pb.setPmemo(pmemo);
				pb.setPcmemo(pcmemo);
				pb.setUpman(upman);
				pb.setUpip(upip);
				
				if("add".equals(opertype)){
					//添加要维护的存储过程
					addPromain(pb,imenuid,pmenuname,imenuname,groupid,request,response);
				}else if("modify".equals(opertype)){
					String id = request.getParameter("id");
					pb.setId(Integer.parseInt(id));
					//修改存储过程
					updatePromain(pb,imenuid,pmenuname,imenuname,groupid,request,response);
				}
				
			}else if("query".equals(opertype)){
				String pid = request.getParameter("nid");
				String diskeys = request.getParameter("diskeys");
				//查询存储过程信息
				queryPromain(pid,diskeys,imenuid,pmenuname,imenuname,groupid,request,response);
			}else{
				System.out.println("数据格式返回错误...");
			}
	}
	
	//添加要维护的存储过程
	public void addPromain(PromainBean pb,String imenuid,String pmenuname,String imenuname,String groupid,HttpServletRequest request, HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		String sql = "INSERT INTO pro_main(pname,pdatabase,pdatabaseip,upman,pmemo,pcmemo,upip) values(?,?,?,?,?,?,?)";
		try {
				//取得数据库链接
				String keysql = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
				conn = DBhelper.getConnection(keysql);
				ps = conn.prepareStatement(sql);
				ps.setString(1, pb.getPname());
				ps.setString(2, pb.getPdatabase());
				ps.setString(3, pb.getPdatabaseip());
				ps.setString(4, pb.getUpman());
				ps.setString(5, pb.getPmemo());
				ps.setString(6, pb.getPcmemo());
				ps.setString(7, pb.getUpip());
				
				int flag = ps.executeUpdate();
				if(flag>0){
					String pagename = "system/promain.jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid;
					try {
						request.getRequestDispatcher("/WEB-INF/template/"+pagename).forward(request, response);
					} catch (ServletException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
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
	
	//查询存储过程信息
	public void queryPromain(String id,String diskeys,String imenuid,String pmenuname,String imenuname,String groupid,HttpServletRequest request, HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		PromainBean nb = null;
		String querysql = "SELECT pname,pdatabase,pdatabaseip,upman,pmemo,pcmemo,upip,uptime FROM pro_main WHERE id=?";
		
		try {
				//取得数据库链接
				String keysql = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
				conn = DBhelper.getConnection(keysql);
				ps = conn.prepareStatement(querysql);
				ps.setString(1, id);
				//执行查询
				rs = ps.executeQuery();
			
				if(rs.next()){
					nb = new PromainBean();
					nb.setPname(rs.getString("pname"));
					nb.setPdatabase(rs.getString("pdatabase"));
					nb.setPdatabaseip(rs.getString("pdatabaseip"));
					nb.setUpman(rs.getString("upman"));
					nb.setPmemo(rs.getString("pmemo"));
					nb.setPcmemo(rs.getString("pcmemo"));
					nb.setUpip(rs.getString("upip"));
					nb.setUptime(rs.getString("uptime"));
					
					request.setAttribute("promaininfo", nb);
				}
				if(null!=nb){
					String pagename = "system/editpromain.jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid+"&id="+id+"&diskeys="+diskeys;
					try {
						request.getRequestDispatcher("/WEB-INF/template/"+pagename).forward(request, response);
					} catch (ServletException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
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
	
	//保存修改的存储过程
	public void updatePromain(PromainBean pb,String imenuid,String pmenuname,String imenuname,String groupid,HttpServletRequest request, HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		String sql = "UPDATE pro_main SET pname=?,pdatabase=?,pdatabaseip=?,upman=?,pmemo=?,pcmemo=?,upip=?,uptime=sysdate WHERE id=?";
		try {
				//取得数据库链接
				String keysql = LoadProperties.getKeyValues("mainSystem", "tsdBilling");			
				conn = DBhelper.getConnection(keysql);
				ps = conn.prepareStatement(sql);
				ps.setString(1,pb.getPname());
				ps.setString(2,pb.getPdatabase());
				ps.setString(3,pb.getPdatabaseip());
				ps.setString(4,pb.getUpman());
				ps.setString(5,pb.getPmemo());
				ps.setString(6,pb.getPcmemo());
				ps.setString(7,pb.getUpip());
				ps.setInt(8,pb.getId());
				
				int flag = ps.executeUpdate();			
				
				if(flag>0){
					String pagename = "system/promain.jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid;
					try {
						request.getRequestDispatcher("/WEB-INF/template/"+pagename).forward(request, response);
					} catch (ServletException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
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
}
