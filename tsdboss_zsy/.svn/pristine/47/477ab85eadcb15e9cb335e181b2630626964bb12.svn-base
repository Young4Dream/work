package com.tsd.query.servlet;

/*****************************************************************
 * name: queryServlet.java
 * author: 
 * version: 
 * description: 公用查询模板处理类
 * modify: 2010-11-22 luoyulong 添加注释
 *****************************************************************/

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tsd.dao.DBhelper;
import com.tsd.query.model.TableQuery;
import com.tsd.service.QueryProcedure;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.StringUtil;
/**
 * 公用查询模板
 */
public class queryServlet extends HttpServlet {
		
		private static final long serialVersionUID = 1L;
		
		public Connection conn = null;
		public CallableStatement statement = null;
		public  PreparedStatement pstt = null;
		public  Statement stmt = null;
		public  ResultSet rs = null;
		public  List dataSett=null;
		

		public void doGet(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
					
				doPost(request, response);
			
		}

		
		public void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			
					
					String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");	
			
					Collection<TableQuery> c =new ArrayList<TableQuery>();
					TableQuery tableQuery =null;
					String tablename = request.getParameter("tablename");	
					String tableflag = request.getParameter("tableflag");
					//System.out.println("tableflag>>>>"+tableflag);
					if(tableflag==null){
						tableflag="false";
					}
					String sql = "select * FROM Rb_Field  where lower(Table_Name)=lower('"+tablename+"') and Searchable='T' and field_alias is not null and field_alias!='{zh=/}{en=/}' order by nOrderby ";
					try {
						conn = DBhelper.getConnection(dataSourceName);
						stmt = conn.createStatement();
						
						rs = stmt.executeQuery(sql);
						try {
							while(rs.next()){
								tableQuery=new TableQuery();
								tableQuery.setID(rs.getInt(1));
								tableQuery.setField_Name(rs.getString(3));
								tableQuery.setTable_Name(rs.getString(2));
								tableQuery.setField_Alias(rs.getString(4));
								tableQuery.setDataType(rs.getString(5));	
								tableQuery.setDataDict(rs.getString(14));
								c.add(tableQuery);					
								tableQuery=null;
							}
						} catch (SQLException e1) {
							e1.printStackTrace();					
						} catch (Exception e2) {
							e2.printStackTrace();						
						}
						
						
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}  finally {
						try {
							if(rs!=null){
								try {
									rs.close();
									rs=null;
								} catch (SQLException e) {
									e.printStackTrace();
									
								}
							}
							if (stmt != null) {
								stmt.close();
								stmt = null;
							}
							if (conn != null) {
								conn.close();
								conn = null;
							}
						} catch (SQLException eee) {
							eee.printStackTrace();
						}
					}	
					HttpSession session=request.getSession(true);
		            session.setAttribute("queryC", c);
		            ///查询表名表输出
		            session.setAttribute("tablename", tablename);
		            ///查询表名表标识
		            session.setAttribute("tableflag", tableflag);            
		            
		            String pagename=request.getParameter("url");
					
					if (StringUtil.isNotEmpty(pagename)) {
					
			
						 Map procedurs = QueryProcedure.queryProcedureByName(pagename);					
						 session.setAttribute("procedurs", procedurs);
						try {
							if (pagename.startsWith("http:/")) {
								response.sendRedirect(pagename);
								return;
							}
							
							request.getRequestDispatcher("/WEB-INF/template/"+pagename).forward(request, response);
						} catch (ServletException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
						return;
					}
		}

	}