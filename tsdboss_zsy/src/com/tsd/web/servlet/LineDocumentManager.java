package com.tsd.web.servlet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.jspsmart.upload.File;
import com.jspsmart.upload.Files;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;
import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LineDocumentUtil;
import com.tsd.service.util.LoadProperties;

public class LineDocumentManager extends HttpServlet {

	private static final long serialVersionUID = 1L;

	final static String separator = System.getProperties().getProperty(
			"file.separator");
	//处理blob的辅助类
	private LineDocumentUtil blobUtil = new LineDocumentUtil();

	
	/**
	 * 服务主函数
	 */
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 获取绝对路径
		HttpSession session = request.getSession(true);
		// 上传文件路径
		String filePath = session.getServletContext().getRealPath("/")
				+ "UpFlies" + separator;
		
		
		filePath = new String(filePath.getBytes(),"utf-8");
		
		System.out.println("filePath:"+filePath);
		
		// 操作类型
		String opertype = request.getParameter("opertype");
		request.setCharacterEncoding("utf-8");

		if (null != opertype) {
			// String xmls = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
			// +"<rows><row filename=\""+ filename + "\" /></rows>";
			if ("1".equals(opertype)) {// 文件上传

				String isRandom = request.getParameter("israndom");
				String prefix = request.getParameter("prefix");
				upFiles(filePath, isRandom, prefix, separator, request,
						response);

			} else if ("2".equals(opertype)) {// 获取上传文件列表

				getFiles(filePath, separator, response);

			} else if ("3".equals(opertype)) {// 删除文件

				String deleteFile = request.getParameter("deletefile");
				String res = deleteFile(filePath + deleteFile);
				ClientOutPut
						.printout(response,
								"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
										+ "<rows><row result=\"" + res
										+ "\" /></rows>", "xml");

			} else if ("4".equals(opertype)) {// 重命名文件

				String oldFileName = request.getParameter("oldfilename");
				String newFileName = request.getParameter("newfilename");
				String res = modifyFile(filePath + oldFileName, filePath
						+ newFileName);
				ClientOutPut
						.printout(response,
								"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
										+ "<rows><row result=\"" + res
										+ "\" /></rows>", "xml");
			} else if ("5".equals(opertype)) {// 下载文件

				String id = request.getParameter("id");
				int idnum = Integer.parseInt(id);
				String res = blobUtil.downloadBlob(idnum, filePath);
			
				//String res = downloadDocument(idnum, filePath, request,response);
				ClientOutPut
						.printout(response,
								"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
										+ "<rows><row result=\"" + res
										+ "\" /></rows>", "xml");
			}
		}
	}

	/**
	 * 文件上传
	 * 
	 * @param isRandom
	 *            是否使用随机文件名保存文件；1：默认文件名；2：使用随机文件名
	 * @param prefix
	 *            上传文件前缀
	 * @param separator
	 *            文件分隔符，windows：\ ；linux：/
	 * @param request
	 * @param response
	 */
	private void upFiles(String filePath, String isRandom, String prefix,
			String separator, HttpServletRequest request,
			HttpServletResponse response) {
		String strOK = "";
		String filename = "";
		InputStream fin = null;
		OutputStream fout = null;

		int retVal = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		Statement st = null;
		ResultSet rs = null;
		String query = null;
		// 记录文件上传时间，用于做临时文件的前缀，避免重名文件被覆盖
		Date dat = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String prev = df.format(dat) + "_";
		String fileext = null;// 存放文件后缀
		
		String toDBfilePath =null;

		// String docName = request.getParameter("docName");
		String docType = request.getParameter("docType");
		String operator = request.getParameter("operator");
		String dhtype = request.getParameter("dhtype");
		String dh = request.getParameter("dh");
		int dhtypeNum = Integer.parseInt(dhtype);
		int docTypeNum = Integer.parseInt(docType);

		// 检查上传文件目录是否存在，不存在默认创建
		java.io.File isFile = new java.io.File(filePath);
		if (!isFile.exists()) {
			isFile.mkdir();
		}

		boolean bflag = false;
		if (null != isRandom && !"".equals(isRandom)) {
			if (null == prefix || "".equals(prefix)) {
				prefix = "Tsd";// 未指定上传文件前缀，默认为Tsd
			}
			if ("2".equals(isRandom)) {
				bflag = true;
			}
		}
		/**
		 * // 1.限制每个上传文件的最大长度。10M up.setMaxFileSize(10000000); // 2.限制总上传数据的长度。
		 * up.setTotalMaxFileSize(20000000); //
		 * 3.设定允许上传的文件（通过扩展名限制）,这里仅允许doc,txt文件。
		 * up.setAllowedFilesList("doc,txt"); //
		 * 4.设定禁止上传的文件（通过扩展名限制）,禁止上传带有exe,bat, jsp,htm,html扩展名的文件和没有扩展名的文件。
		 * up.setDeniedFilesList("exe,bat,jsp,htm,html,");
		 */
		try {
			SmartUpload smartUpload = new SmartUpload();

			request.setCharacterEncoding("utf-8");

			smartUpload.initialize(getServletConfig(), request, response);
			// Request req = up.getRequest();
			smartUpload.upload();
			// up.setDeniedFilesList("exe,bat,jsp,htm,html");
			Files fs = smartUpload.getFiles();

			for (int i = 0; i < fs.getCount(); ++i) {
				File file = fs.getFile(i);
				if (!(file.isMissing())) {
					filename = file.getFileName();					
					filename = new String(filename.getBytes(), "utf-8");

					System.out.println( "-------------------------name--------------"
							+ filename);
					fileext = "." + file.getFileExt();
					System.out
							.println("-------------------------001--------------"
									+ file.getFileExt());
					System.out.println("源文件：" + file.getFilePathName());
					System.out.println("目标文件：" + filePath + filename);
					if (bflag) {
						filename = getNewFilename(prefix) + file.getFileExt();
					}

					file.saveAs(filePath + prev + fileext, 0);
					feedBack(filename, response);
					break;
				}
			}
			toDBfilePath = filePath + prev + fileext;			
			try {
				//将文件保存到数据库中
				//1.判断数据库类型 orcl和edb的保存方式不一样
				String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");	
				conn = DBhelper.getConnection(dataSourceName);
				String dbName = DBhelper.getDatabaseProductName(conn);
				if("enterprisedb".equalsIgnoreCase(dbName)){
					blobUtil.saveBlobEDB(conn,dhtypeNum, docTypeNum, filename, operator, dh, toDBfilePath);
				}else if("oracle".equalsIgnoreCase(dbName)){
					blobUtil.saveBlobOrcl(conn,dhtypeNum, docTypeNum, filename, operator, dh, toDBfilePath);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} catch (SmartUploadException e) {
			throw new RuntimeException("SmartUploadException Exception: "
					+ e.getMessage());
		} catch (IOException e) {
			throw new RuntimeException("IOException Exception: "
					+ e.getMessage());
		} catch (ServletException e) {
			throw new RuntimeException("ServletException Exception: "
					+ e.getMessage());
		} finally {
			isFile = null;
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			conn = null;
		}
	}

	/**
	 * 获取文件路径
	 * 
	 * @param filePath
	 */
	private void getFiles(String filePath, String separator,
			HttpServletResponse response) {
		java.io.File file = new java.io.File(filePath);
		String xmls = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
		String rows = "";
		if (null != file) {
			// System.out.println("Show info:"+file.exists());
			if (file.exists()) {
				java.io.File[] subFile = file.listFiles();
				for (int i = 0; i < subFile.length; i++) {
					// System.out.println("文件: " + subFile[i].getName());
					rows += "<row filepath=\"UpFlies" + separator + separator
							+ "\" filename=\"" + subFile[i].getName() + "\"/>";
				}
			} else {
				rows += "<row filepath=\"nofiles\"></row>";
			}
			// System.out.println(rows);
		} else {
			rows += "<row filepath=\"nofiles\"></row>";
		}
		ClientOutPut.printout(response, xmls + "<rows>" + rows + "</rows>",
				"xml");
	}

	/**
	 * 删除文件
	 * 
	 * @param filePath
	 *            要删除的文件路径
	 */
	private String deleteFile(String filePath) {
		String result = null;
		java.io.File file = new java.io.File(filePath);
		if (file.exists()) {
			boolean flag = file.delete();
			if (flag) {
				result = "删除成功";
			} else {
				result = "删除失败";
			}
		} else {
			result = "要删除的文件不存在";
		}
		return result;
	}

	/**
	 * 文件重命名
	 * 
	 * @param oldFileName
	 *            原来文件名称
	 * @param newFileName
	 *            新文件名称
	 */
	private String modifyFile(String oldFileName, String newFileName) {
		String result = null;
		java.io.File oldfile = new java.io.File(oldFileName);
		if (oldfile.exists()) {
			java.io.File newfile = new java.io.File(newFileName);
			boolean flag = oldfile.renameTo(newfile);
			if (flag) {
				result = "修改成功";
			} else {
				result = "修改失败";
			}
		} else {
			result = "要修改的文件不存在";
		}
		return result;
	}

	/**
	 * 默认按上传时间生成文件名
	 * 
	 * @param Prefix
	 *            文件名前缀
	 * @return 随机文件名称
	 */
	private String getNewFilename(String Prefix) {
		Date dat = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String filename = Prefix + "_" + df.format(dat);
		Random rand = new Random();
		for (int i = 0; i < 4; ++i)
			filename = filename + String.valueOf(rand.nextInt(9));
		return filename;
	}

	// 返回文件名称
	private void feedBack(String filename, HttpServletResponse response) {
		String xmls = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				+ "<rows><row filename=\"" + filename + "\" /></rows>";
		ClientOutPut.printout(response, xmls, "xml");
	}

	// 文件下载
	public String downloadDocument(int id, String filePath,
			HttpServletRequest request, HttpServletResponse response) {
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
			DriverManager.registerDriver(new com.edb.Driver());
			// conn = DriverManager.getConnection(
			// "jdbc:edb://192.168.44.86:5444/tsdboss",
			// "tsd", "tsd2010psw");
			conn = DBhelper.getConnection(LoadProperties.getKeyValues(
					"mainSystem", "tsdBilling"));// 根据配置的数据源获得连接
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
				System.out.println("--------------b:"+b);
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
}