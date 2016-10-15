package com.tsd.service.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;
/**********
 * JAVA资源文件国际化
 * 资源文件存放于：com.tsd.i18n里
 *system_zh.propertices:  系统管理和通用资源的中文，_en为英文等
 *com.tsd.i18n.phone:存放电话业务资源文件
 *com.tsd.i18n.broadband:存放宽带业务资源文件
 *com.tsd.i18n.voice:存放语音业务资源文件
 */
public class I18n {
	/**
	 * 语言
	 */	
	private String Language="zh";
	/**
	 * 业务名称：phone：电话 broadband: 宽带 voice:语音
	 */	
	private String BusiName="phone";
	/**
	 * 业务类型：charge:营收  business:业务受理 等
	 */	
	private String BusiType="business";
	/**
	 * 构造函数
	 * 传入三个变量的值
	 */	
	public I18n(String sLanguage, String sBusiName, String sBusiType)
	{
		this.Language = sLanguage;
		this.BusiName = sBusiName;
		this.BusiType = sBusiType;
	}
	
	public boolean getI18n(Properties i18n){
		Properties props = new Properties();
		InputStream ins = null;
		try {
			String path = I18n.class.getProtectionDomain().getCodeSource().getLocation().toURI().getPath();

			int i = path.indexOf("WEB-INF");
			if(i>0){
				path = path.substring(0,i+8);
				path += ("".equals(BusiName)?"classes/i18n/system_"+Language+".properties":"classes/i18n/"+BusiName+"/"+BusiType+"_"+Language+".properties");				
			}
			else
			{
				return false;
			}
			
			try{
				ins = new FileInputStream(new File(path));
				props.load(ins);
			}
			finally{
				ins.close();
			}
			Enumeration<Object> en = i18n.keys();
			String sKey="";
			while(en.hasMoreElements()){
				sKey = (String) en.nextElement();
				String val =  (String)props.get(sKey);
				if (null != val)
				{
					i18n.setProperty(sKey, val);
				}
				//System.out.println("Enumeration："+val);
			}
		} catch (IOException e) {
			throw new RuntimeException("i18n error:"+e);	
		} catch (URISyntaxException ue){
			throw new RuntimeException("URISyntax error:"+ue);
		}
		finally{
			props.clear();
		}
		return true;
	}
}
