package com.tsd.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.PropertyConfigurator;

import com.jspsmart.upload.File;
import com.jspsmart.upload.Files;
import com.jspsmart.upload.Request;
import com.jspsmart.upload.SmartUpload;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.StringUtil;
import com.tsd.service.util.ClientOutPut;

public class UpFiles extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//System.out.println(1);
		HttpSession session = request.getSession(true);
		String root = session.getServletContext().getRealPath("/");
		String dir = "";
		String upDirKey = request.getParameter("upDirKey");
		String tsdcf = request.getParameter("tsdcf");
		//String fileStartName = request.getParameter("fileStartName");
		String fileNameWillBeSaved = request.getParameter("ufilename");
		String resFileName;
		
		if ((StringUtil.isNotEmpty(upDirKey)) && (StringUtil.isNotEmpty(tsdcf))) {
			//LoadProperties.getSql(tsdcf, upDirKey);
			//dir = LoadProperties.getKeyValue(tsdcf, upDirKey);
			LoadProperties.getSql(tsdcf, upDirKey);
			dir = LoadProperties.sql;
		} else {
			dir = root;
		}
		
		String sysname=System.getProperties().getProperty("os.name");
		if(sysname.toUpperCase().indexOf("WINDOWS")==-1){
			dir = dir.replaceAll("\\\\", "/");//linux
		}
		
		long maxsize = 52428800L;
		SmartUpload up = new SmartUpload();
		request.setCharacterEncoding("utf-8");
		up.initialize(getServletConfig(), request, response);

		try {
			up.upload();
			Request req = up.getRequest();

			Files fs = up.getFiles();
			for (int i = 0; i < fs.getCount(); ++i) {
				File file = fs.getFile(i);
				if (!(file.isMissing())) {
					//String info = req.getParameter(fileStartName + i);
					//String type = file.getContentType();
					String filename = file.getFileName();

					if (StringUtil.isNotEmpty(fileNameWillBeSaved)) {
						//System.out.println(fileNameWillBeSaved);
						filename = fileNameWillBeSaved.replaceAll("\\\\",
								"\\\\\\\\");
						//System.out.println(filename);
					}
					System.out.println("源文件：" + file.getFilePathName());
					System.out.println("目标文件：" + dir + java.io.File.separator + filename);
					
					resFileName=resFileName(request,filename);
					
					file.saveAs(dir + java.io.File.separator + resFileName, 0);
					
					if(!filename.equals(resFileName)){
						String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><rows>";
						xmls+="<row filename=\""+resFileName+"\"></row>";
						xmls+="</rows>";
						
						ClientOutPut.printout(response, xmls, "xml");
					}else{
						
						ClientOutPut.printout(response, "true", "");
					}
				}
			}
		} catch (Exception ex) {
			throw new RuntimeException("Exception:" + ex.getMessage());
		}
	}
	
	private String getCusDate(){
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr= format.format(date);
		return dateStr;
	} 
	
	public String resFileName(HttpServletRequest request,String filename){
		String resFilename;
		String username = request.getParameter("username");
		if(username==null){
			username="";
		}
		String date=request.getParameter("date");
		if(date==null){
			date="";
		}else{
			date=getCusDate();
			return date+filename.substring(filename.length()-4);
		}
		return username+filename;
	}
}