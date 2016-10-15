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
import javax.servlet.http.HttpSession;

import com.tsd.dao.DBhelper;
import com.tsd.javabean.NoticeBean;
import com.tsd.service.util.LoadProperties;
public class NoticeServlet extends HttpServlet {

	
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
			
			String nid = request.getParameter("nid");//通知通告id
			String ismodify = request.getParameter("willmodify");//操作flag，是否进行修改
			String feedback = request.getParameter("feedback");//问题反馈的参数
			
			if(null==nid&&null==feedback||"".equals(nid)&&null==feedback||null!=ismodify&&null==feedback){
				String nmenuid = request.getParameter("nmenuid");//所属菜单
				String npmenuname = request.getParameter("npmenuname");//父菜单名称
				String ngroupid = request.getParameter("ngroupid");//所在权限组
				String nimenuname = request.getParameter("nimenuname");//子菜单名称
				String title = request.getParameter("title");//标题
				String type = request.getParameter("type");//类型
				String flag = request.getParameter("flag");//开关
				String topinfo = request.getParameter("topinfo");//是否置顶
				String news = request.getParameter("news");//是否推荐
				String readint = request.getParameter("isread");//阅读权限
				String[] readstr = request.getParameterValues("values");//可阅读范围
				
				String isread = "";
				if(null!=readstr&&!"".equals(readstr)){
					String temp = "";
					for(int i = 0;i<readstr.length;i++){
						temp += readstr[i] + "~";
					}
					temp = temp.substring(0, temp.lastIndexOf("~"));
					isread = temp + "@" + readint;
				}else{
					isread = "@"+readint;
				}
				
				String memo = request.getParameter("memo");//通告内容
				HttpSession session = request.getSession();
				String upman = (String)session.getAttribute("username");//工号名称
				
				NoticeBean nb = new NoticeBean();//存储数据
				nb.setTitle(title);
				nb.setType(type);
				nb.setFlag(flag);
				nb.setIsread(isread);
				nb.setMemo(memo);
				nb.setNews(news);
				nb.setTopinfo(topinfo);
				nb.setUpman(upman);
				if(null!=ismodify){
					//修改通知通告信息
					updateNotice(nid,nb,memo,nmenuid,npmenuname,nimenuname,ngroupid,request,response);
				}else{
					//添加通知通告信息
					addNotice(nb,memo,nmenuid,npmenuname,nimenuname,ngroupid,request,response);
				}
			}else if(null!=feedback){
				String title = request.getParameter("title");
				String memo = request.getParameter("memo");
				String type = request.getParameter("feedbacktype");//反馈类型
				String feedbackdept = request.getParameter("feedbackdept");//反馈部门
				//提交问题反馈
				addFeedBack(title,memo,type,feedbackdept,request,response);
			}else{
				String mmenuid = request.getParameter("mmenuid");
				String mpmenuname = request.getParameter("mpmenuname");
				String mgroupid = request.getParameter("mgroupid");
				String mimenuname = request.getParameter("mimenuname");
				String thisflag = request.getParameter("thisflag");
				String noticeflag = request.getParameter("noticeflag");
				String params = null;
				if(null!=thisflag){
					params = thisflag+"0";
				}else if(null!=noticeflag){
					params = noticeflag+"1";
				}
				//查询通告信息
				queryNotice(nid,params,mmenuid,mpmenuname,mimenuname,mgroupid,request,response);
			}
			
	}
	
	//保存通知通告信息数据
	public void addNotice(NoticeBean nb,String memo,String imenuid,String pmenuname,String imenuname,String groupid,HttpServletRequest request, HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		String sql = "INSERT INTO notices(title,memo,type,upman,flag,topinfo,news,isread) values(?,?,?,?,?,?,?,?)";
		try {
				//取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");
			conn = DBhelper.getConnection(dataSourceName);	
				ps = conn.prepareStatement(sql);
				ps.setObject(1, nb.getTitle());
				ps.setObject(2, memo);
				ps.setObject(3, nb.getType());
				ps.setObject(4, nb.getUpman());
				ps.setObject(5, nb.getFlag());
				ps.setObject(6, nb.getTopinfo());
				ps.setObject(7, nb.getNews());
				ps.setObject(8, nb.getIsread());
				
				int flag = ps.executeUpdate();
				if(flag>0){
					String pagename = "notice/notices.jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid;
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
	
	//查询通知通告信息
	public void queryNotice(String nid,String params,String imenuid,String pmenuname,String imenuname,String groupid,HttpServletRequest request, HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		NoticeBean nb = null;
		String querysql = "SELECT title,memo,type,flag,topinfo,news,isread,hots,upman,to_char(uptime,'yyyy-mm-dd hh24:mi:ss') as uptime FROM notices WHERE nid=?";
		
		try {
				//取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");
			conn = DBhelper.getConnection(dataSourceName);	
				ps = conn.prepareStatement(querysql);
				ps.setString(1, nid);
				//执行查询
				rs = ps.executeQuery();
			
				if(rs.next()){
					nb = new NoticeBean();
					nb.setTitle(rs.getString("title"));
					nb.setMemo(rs.getString("memo"));
					nb.setType(rs.getString("type"));
					nb.setFlag(rs.getString("flag"));
					nb.setTopinfo(rs.getString("topinfo"));
					nb.setNews(rs.getString("news"));
					nb.setIsread(rs.getString("isread"));
					nb.setHots(rs.getString("hots"));
					nb.setUpman(rs.getString("upman"));
					nb.setUptime(rs.getString("uptime"));
					request.setAttribute("noticeinfo", nb);
				}
				if(null!=nb){
					String jumppage = "notice/noticeModify";
					String isflag = null ;
					if(null!=params&&params.equals("true0")){
						jumppage = "rights";
					}else if(null!=params&&params.equals("true1")){
						jumppage = "rights";
						isflag = "displayinfo";
					}
					String pagename = jumppage+".jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid+"&nid="+nid+"&displayinfo="+isflag;
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
	
	//保存修改的通知通告信息
	public void updateNotice(String nid,NoticeBean nb,String memo,String imenuid,String pmenuname,String imenuname,String groupid,HttpServletRequest request, HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		String sql = "UPDATE notices SET title=?,memo=?,type=?,upman=?,flag=?,topinfo=?,news=?,isread=? WHERE nid=?";
		try {
				//取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");
			conn = DBhelper.getConnection(dataSourceName);	
				ps = conn.prepareStatement(sql);
				ps.setObject(1, nb.getTitle());
				ps.setObject(2, memo);
				ps.setObject(3, nb.getType());
				ps.setObject(4, nb.getUpman());
				ps.setObject(5, nb.getFlag());
				ps.setObject(6, nb.getTopinfo());
				ps.setObject(7, nb.getNews());
				ps.setObject(8, nb.getIsread());
				ps.setObject(9, nid);
				
				int flag = ps.executeUpdate();			
				
				if(flag>0){
					String pagename = "notice/notices.jsp?imenuid="+imenuid+"&pmenuname="+pmenuname+"&imenuname="+imenuname+"&groupid="+groupid;
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
	
	//添加反馈信息
	public void addFeedBack(String title,String memo,String type,String feedbackdept,HttpServletRequest request, HttpServletResponse response){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		String sql = "INSERT INTO notices(title,memo,type,upman,isread) values(?,?,?,?,?)";
		HttpSession session =  request.getSession();
		String upman = (String)session.getAttribute("username");
		String isread = feedbackdept + "@3";//暂无其它类型的上级部门
		try {
				//取得数据库链接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");
			conn = DBhelper.getConnection(dataSourceName);	
				ps = conn.prepareStatement(sql);
				ps.setObject(1, title);
				ps.setObject(2, memo);
				ps.setObject(3, type);
				ps.setObject(4, upman);
				ps.setObject(5, isread);
				
				int flag = ps.executeUpdate();
				if(flag>0){
					try {
						String pagename = "right-notices.jsp";
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
