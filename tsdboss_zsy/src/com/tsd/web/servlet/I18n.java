package com.tsd.web.servlet;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tsd.service.util.ClientOutPut;

public class I18n extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			doPost(request,response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String lang = (String)session.getAttribute("languageType");//当前语言信息，在登陆成功之后已保存好
		String keys = request.getParameter("keys");//要解析的资源文件key值
		String busiName = request.getParameter("businame");//业务名称
		String busiType = request.getParameter("busitype");//业务类型
		String xmls = "";
		if(null != keys && !"".equals(keys)){
			xmls = getI18nVal(keys,null == lang ? "zh" : lang,null == busiName ? "" : busiName, null == busiType ? "" : busiType);
		}else{
			xmls = "parameter error";
		}
		ClientOutPut.printout(response, xmls, "xml");
	}
	
	/**
	 * 解析参数值
	 * @param key		资源键值，多个用英文','进行分割
	 * @param lang		当前语音环境
	 * @param busiName	业务名称
	 * @param busiType	业务类型
	 * @return
	 */
	private String getI18nVal(String key,String lang,String busiName,String busiType){
		/**
		 * return data format:
		 * <?xml version="1.0" encoding="UTF-8"?> 
		 * 	<rows>
		 * 		<row groupid="1" groupname="administrator" memo="" ></row>
		 * 	</rows>
		 */
		String xml = "";
		com.tsd.service.util.I18n i18n = new com.tsd.service.util.I18n(lang,busiName,busiType);
		Properties props = new Properties();
		String[] keyarr = key.split(",");
		for(String keys : keyarr){
			props.setProperty(keys, "resource");
		}
		i18n.getI18n(props);//加载资源文件
		for(String val : keyarr){
			xml += val+"=\""+props.getProperty(val)+"\" ";//获取资源文件值
		}
		xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><rows><row "+xml+"></row></rows>";
		return xml;
	}
}
