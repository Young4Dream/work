package com.tsd.service.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;

public class StringUtil {
	
	/**
	 * 非空操作
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty(String str){
		
		if(str==null){
			return false;
		}
		str=str.trim();
		if("".equals(str)){return false;}
		return true;
		
	}
	/**
	 * 编码转换
	 * @param str
	 * @param typesName
	 * @return
	 */
	public static String setCharEncode(String str,String typesName){
		if(StringUtil.isNotEmpty(str)){
			try {
				
				str=new String(str.getBytes("ISO-8859-1"),typesName);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return str;
	}
	public static void main(String[] args) throws IOException {
		/*try{
		     URL url = new URL("http://localhost:8080/yihaotong/mainServlet.html?pagename=telBind.html");
		     BufferedReader reader;
		     reader = new BufferedReader(new InputStreamReader(url.openStream()));
		     String str;
		     String html="";
		     while ((str = reader.readLine())!=null){
		    	 html+=str;
		     }
		     //System.out.println(html);
		   }catch(MalformedURLException e){
		    
		   } */
		
		String a = "select groupid as '权限组ID',groupname as '权限组名称',memo as '权限组描述' from sys_powergroup where 1=1";
		System.out.println(a.length());
		
		System.out.println(a.getBytes().length);
		
		
	}
}
