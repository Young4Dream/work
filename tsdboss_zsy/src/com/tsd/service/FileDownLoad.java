package com.tsd.service;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.StringUtil;


/**
 * @author Administrator
 *
 */
public class FileDownLoad {
	private HttpServletRequest sRequest = null;
	private HttpServletResponse sResponse = null;
	private HttpSession sSession = null;

	/**
	 * 
	 */
	public FileDownLoad() {
		// TODO Auto-generated constructor stub
	}

	
	public void download(HttpServletRequest sRequest, HttpServletResponse sResponse){
		String downloadFile=sRequest.getParameter("tsdfilename");
		//System.out.println(sRequest.getRealPath("/")); 
		sSession=sRequest.getSession();
		String root = sSession.getServletContext().getRealPath("/");
		if (downloadFile == null) {
			return;
		}
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			
			String filename="";
			String filepath=root;
			filepath=filepath.substring(0, filepath.length()-1);
  			
  			String downdirkey = sRequest.getParameter("downdirkey");
  			String tsdcf = sRequest.getParameter("tsdcf");
  			if(StringUtil.isNotEmpty(downdirkey)&&StringUtil.isNotEmpty(tsdcf)){
  				//String sql = LoadProperties.getKeyValue(tsdcf, downdirkey);
  				//downloadFile = sql+"/"+ downloadFile;
  				LoadProperties.getSql(tsdcf, downdirkey);			
  				downloadFile = LoadProperties.sql+"/"+ downloadFile;
  			}else{
  				downloadFile =root+"/"+ downloadFile;
			}
  			downloadFile=downloadFile.replaceAll("\\\\", "/");
			filename   =   downloadFile.substring(downloadFile.lastIndexOf("/")+1); 
			
			
			if (filename == null) {
				return;
			}
			if (filename.equals("")) {
				return; 
			}
			File   f=new   File(downloadFile);  
			if (!f.exists()){
				return;
			}
			sResponse.setHeader("Content-Disposition", "inline; attachment; filename="+ filename );
			sResponse.setContentType("APPLICATION/OCTET-STREAM");
			//System.out.println("1=======downloadFile======:" + downloadFile);
			bos = new BufferedOutputStream(sResponse.getOutputStream());
			bis = new BufferedInputStream(new FileInputStream(downloadFile));
			String rets = null;
			byte[] buff = new byte[2048];
			int bytesRead;

			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (final IOException e) {
			System.out.println("上传文件出现IOException." + e);
		} finally {
			try {
				if (bis != null)
					bis.close();
				if (bos != null)
					bos.close();
			} catch (final IOException e) {

			}

		}

	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}

