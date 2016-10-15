package com.tsd.service.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.tsd.dao.DBhelper;

import oracle.jdbc.OracleResultSet;
import oracle.sql.BLOB;

public class LineDocumentUtil {
	
	//文件入库
	public void saveBlobOrcl(Connection conn,int dhtypeNum ,int docTypeNum,String filename  ,String operator,String dh ,String filePath) throws SQLException{
		//状态码
		int retVal = 0;
		
//		Connection conn = null;
		Statement st = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		int countnum = 0;		
		String querySql ;
		
		FileInputStream fis = null;
		java.io.File file1 = null;
	
		
		// 保存到数据库中
		try {		
			
			//根据配置的数据源获得连接
		//	String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");	
		//	conn = DBhelper.getConnection(dataSourceName);
			System.out.println( "-----------------------getDatabaseProductName:" + DBhelper.getDatabaseProductName(conn));
			    //处理事务
			conn.setAutoCommit(false);
			querySql = "select count(*) FROM AIR_DOCUMENT WHERE dhtype = "
				+ dhtypeNum + " and DOCTYPE=" + docTypeNum + " and dh="+ dh;
			st = conn.createStatement();
			rs = st.executeQuery(querySql);
			// 对于统一个号线只能有一个doc文件和一个excel文件，验证该号线下该类型的文件是否已经存在
			if (rs != null && rs.next()) {
				countnum = rs.getInt(1);
			}
			// 已存在该类型文件，则覆盖已有记录下文件；不存在该类型文件则添加一条记录存放该文件
			if (countnum > 0) {
				querySql = "update air_document set docname=?,operator=?,moddate=sysdate "
						+ "where dhtype=? and doctype=? and dh=?  ";
			} else {
				querySql = "insert into air_document( docname,operator,  moddate,dhtype , doctype, dh ,   doccontext  ) values("
						+ "?,		?,		 sysdate ,?,		?,		?,empty_blob()" + ") ";
			}
			
			ps = conn.prepareStatement(querySql); // conn 是建立的数据库连接
			ps.setString(1, filename);
			ps.setString(2, operator);
			ps.setInt(3, dhtypeNum);
			ps.setInt(4, docTypeNum);
			ps.setString(5, dh);
			ps.execute();
			ps.clearParameters();			
		
		
			   
		    //用for update方式锁定数据行
		    ResultSet rss = st.executeQuery("SELECT doccontext FROM air_document "
						+ "where dhtype="+ dhtypeNum+" and doctype="+docTypeNum +" and dh='"+ dh +"'  FOR UPDATE ");
		    if (rss.next()) {
			    //使用oracle.sql.BLOB类，没办法了，变成专用的了
			    oracle.sql.BLOB blob = (oracle.sql.BLOB) rss.getBlob(1);
			    
			    System.out.println("文件路径="+filePath );
			    OutputStream outStream = blob.getBinaryOutputStream();
				file1 = new java.io.File(filePath);
				fis = new FileInputStream(file1);

				byte[] buffer = new byte[blob.getBufferSize()];
				int bytesRead = 0;
				while ((bytesRead = fis.read(buffer)) != -1) {
					//fis.read(buffer, 0, bytesRead);
					 outStream.write(buffer, 0, bytesRead);
				}
			     
			   
				blob = null;
				buffer = null;
				fis.close();
				//依次关闭
			    outStream.flush();
			    outStream.close(); 
		    }

		} catch (SQLException ex) {
			ex.printStackTrace();
			retVal = 1;
		} catch (FileNotFoundException ef) {
			ef.printStackTrace();
			retVal = 2;
		} catch (Exception e) {
			e.printStackTrace();
			retVal = 3;
		}

		finally {
			try {
				conn.commit();
				ps.close();				
				fis = null;
				ps = null;
				st = null;
				rs = null;
			} catch (SQLException e) {
				retVal = 1;
			}
		}
		
	}
	//文件入库
	public void saveBlobEDB(Connection conn,int dhtypeNum ,int docTypeNum,String filename  ,String operator,String dh ,String filePath) throws SQLException{
		
		int retVal = 0;
		PreparedStatement stmt = null;
		Statement st=null;
		ResultSet rs =null;
		String query =null;
		
		FileInputStream fis = null;
		java.io.File file1 = null;
	
		//保存到数据库中
		try {
			conn.setAutoCommit(false);
			
			//对于统一个号线只能有一个doc文件和一个excel文件，验证该号线下该类型的文件是否已经存在	
			query = "select count(*) FROM AIR_DOCUMENT WHERE dhtype = "
				+ dhtypeNum + " and DOCTYPE=" + docTypeNum + " and dh="+ dh;
			st = conn.createStatement(); 
			rs = st.executeQuery( query ); 
			int countnum =0;
			rs = st.executeQuery( query ); 			 
			if (rs!=null &&rs.next()) { 
				 countnum = rs.getInt(1);		        
			}
			//已存在该类型文件，则覆盖已有记录下文件；不存在该类型文件则添加一条记录存放该文件
			if(countnum>0)
			{
				query   =   "update air_document set docname=?,operator=?,moddate=sysdate,doccontext=? " +
				"where dhtype=? and doctype=? and dh=? ;"; 
			}else
			{					
				query   =   "insert into air_document( docname,operator,  moddate,   doccontext,dhtype , doctype, dh   ) values(" 
					+"?,		?,		 sysdate ,?,?,		?,		?		" 
					+") ;"; 
			}
			file1 = new java.io.File(filePath);
			fis = new FileInputStream(file1);

			int   fileLength   =   (int)file1.length(); 
			byte[] b = new byte[fileLength];
			fis.read(b);
			stmt   =   conn.prepareStatement(query);   //conn   是建立的数据库连接 
			stmt.setString(1, filename);
			stmt.setString(2, operator);
			//stmt.setAsciiStream(6,   fis,   fileLength);
			stmt.setBytes(3, b);
			stmt.setInt(4, dhtypeNum);
			stmt.setInt(5, docTypeNum);			
			stmt.setString(6, dh);		
			stmt.execute();
			stmt.clearParameters();					
			
		} catch (SQLException ex) {
			ex.printStackTrace();
			retVal = 1;
		} catch (FileNotFoundException ef) {
			ef.printStackTrace();
			retVal = 2;
		} catch (Exception e) {
			e.printStackTrace();
			retVal = 3;
		}

		finally {
			try {
				
				conn.commit();
				stmt.close();
				conn.close();
				fis = null;
				conn = null;
				stmt = null;
				st = null;
				rs = null;
			} catch (SQLException e) {
				retVal = 1;
			} 
		}
	}
	
	public String downloadBlob(int id, String filePath){
		
		String retVal = "0";
		String docname = "";// 文件名
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		OutputStream fout = null;
		String filename = "";// 文件完成路径，包括文件名
		java.io.File isFile = null;
		java.io.File file = null;

		try {
			//根据配置的数据源获得连接
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");	
			conn = DBhelper.getConnection(dataSourceName);
			conn.setAutoCommit(false);
			st = conn.createStatement();
			String sqlstr = "SELECT doctype,docname,doccontext FROM air_document WHERE id= "
					+ id;
			rs = st.executeQuery(sqlstr);
			if (rs.next()) {
				int doctype = rs.getInt(1);
				docname = rs.getString(2);
				Blob blob = rs.getBlob(3); 
				//byte[] b = rs.getBytes(3);
				String[] docnameA = docname.split("\\.");

				// 用文件模拟输出流
				// java.io.File file = new
				// java.io.File(basePath+docname+".odc");
				isFile = new java.io.File(filePath);
				if (!isFile.exists()) {
					isFile.mkdir();
				}
				// 在日期前添加时间，避免文件被覆盖
				Date dat = new Date();
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
				docname = df.format(dat) + "." + docnameA[1];
				filename = filePath + docname;
				// System.out.println("-------------------------1111111filename="+filename);
				// String str = "C:\\Program Files\\Apache Software
				// Foundation\\Tomcat
				// 6.0\\webapps\\tsdboss_cqjc5\\"+docname+".doc";
				file = new java.io.File(filename);
				fout = new FileOutputStream(file);
				// 下面将BLOB数据写入文件
				byte []b = blob.getBytes(1, (int) blob.length());
				fout.write(b);
				
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
			retVal = "1";
		} catch (Exception e) {
			e.printStackTrace();
			retVal = "3";
		} finally {

			try {
				// 依次关闭
				isFile = null;
				file = null;
				conn.commit();
				st.close();
				conn.close();
				fout = null;
				rs = null;
				conn = null;
				st = null;
				retVal = docname;
			} catch (SQLException e) {
				retVal = "4";
			}
		}
		return retVal;
	}
	
	//文件入库
	public void saveBlob111(int dhtypeNum ,int docTypeNum,String filename  ,String operator,String dh ,String filePath) throws SQLException{
		//状态码
		int retVal = 0;
		
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps=null;
		ResultSet rs = null;
		
		int countnum = 0;		
		String querySql ;
		
		FileInputStream fis = null;
		java.io.File file1 = null;
		//根据配置的数据源获得连接
		String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");	
		conn = DBhelper.getConnection(dataSourceName);
		
		conn.setAutoCommit(false);
		
		querySql = "select count(*) FROM AIR_DOCUMENT WHERE dhtype = "
			+ dhtypeNum + " and DOCTYPE=" + docTypeNum ;
		// 保存到数据库中
		try {
			
			st = conn.createStatement();
			rs = st.executeQuery(querySql);
			// 对于统一个号线只能有一个doc文件和一个excel文件，验证该号线下该类型的文件是否已经存在
			if (rs != null && rs.next()) {
				countnum = rs.getInt(1);
			}
			// 已存在该类型文件，则覆盖已有记录下文件；不存在该类型文件则添加一条记录存放该文件
			if (countnum > 0) {
				querySql = "update air_document set docname=?,operator=?,moddate=sysdate "
						+ "where dhtype=? and doctype=? and dh=?  ";
			} else {
				querySql = "insert into air_document( docname,operator,  moddate,dhtype , doctype, dh ,   doccontext  ) values("
						+ "?,		?,		 sysdate ,?,		?,		?,empty_blob()" + ") ";
			}
			
			ps = conn.prepareStatement(querySql); // conn 是建立的数据库连接
			ps.setString(1, filename);
			ps.setString(2, operator);
			ps.setInt(3, dhtypeNum);
			ps.setInt(4, docTypeNum);
			ps.setString(5, dh);
			ps.execute();
			ps.clearParameters();

			// 更新上传文件
			ps = conn
					.prepareStatement("SELECT doccontext FROM air_document "
							+ "where dhtype=? and doctype=? and dh=?  FOR UPDATE ");
			ps.setInt(1, dhtypeNum);
			ps.setInt(2, docTypeNum);
			ps.setString(3, dh);
			rs = ps.executeQuery();
			if (rs.next()) {
				BLOB blob = ((OracleResultSet) rs).getBLOB("doccontext");
				file1 = new java.io.File(filePath);
				fis = new FileInputStream(file1);

				// java.io.File f = new java.io.File(filePath + prev +
				// fileext);
				// fin = new FileInputStream(f);

				byte[] buffer = new byte[blob.getBufferSize()];
				int bytesRead = 0;
				while ((bytesRead = fis.read(buffer)) != -1) {
					fis.read(buffer, 0, bytesRead);
				}
				blob = null;
				buffer = null;
				fis.close();
			}
			ps.clearParameters();

		} catch (SQLException ex) {
			ex.printStackTrace();
			retVal = 1;
		} catch (FileNotFoundException ef) {
			ef.printStackTrace();
			retVal = 2;
		} catch (Exception e) {
			e.printStackTrace();
			retVal = 3;
		}

		finally {
			try {
				conn.commit();
				ps.close();
				conn.close();
				fis = null;
				conn = null;
				ps = null;
				st = null;
				rs = null;
			} catch (SQLException e) {
				retVal = 1;
			}
		}
		
	}
}
