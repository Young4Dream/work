package com.tsd.web.servlet;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tsd.service.UserManager;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.StringUtil;

public class UserLogin {
	private HttpServletRequest request = null;
	private HttpServletResponse response = null;
	private HttpSession session = null;
	public UserLogin(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		session = this.request.getSession();
	}
	/***
	 * 用户登录
	 * @param unitelno
	 * @param passwd
	 * @return
	 */
	public void login(String username,String passwd,String suserip,HttpServletRequest request){
		if (StringUtil.isNotEmpty(username)) {
			if (StringUtil.isNotEmpty(passwd)) {
				UserManager user = new UserManager(); 
				//往Session里面添加jqGrid配置信息
				Map jqgridsetting = user.getjqGridRow();
				session.setAttribute("jqGridRowList", jqgridsetting.get("rowlist"));
				session.setAttribute("jqGridRowNum", jqgridsetting.get("rownum"));
				Map map=new HashMap();
				map=user.queryUser(username, passwd,suserip,request);
				String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
				String strinfo = null;
				if(map!=null){
					//判断是否校验当前用户登陆成功
					strinfo = (String)map.get("checkfalse");
					if(strinfo==null){
						//保存session
						setUserSession(request,map.get("userid"),map.get("username"),map.get("password"),map.get("userarea"),
									map.get("managearea"),map.get("chargearea"),map.get("departname"),map.get("groupid"),map.get("canloginip"),map.get("userloginip"),map.get("custom"));
						xmls+="<row>success</row>";
					}else{
						xmls+="<row>"+strinfo+"</row>";
					}
				}else{xmls+="<row>notexists</row>";}
				ClientOutPut.printout(response, xmls,"xml");
			}
		}
	}
	//用户是否登陆参数
	public boolean onlogin() {
		//判断用户是否进行了登录
		String userState = (String) session.getAttribute("userState");
		if ("online".equalsIgnoreCase(userState)) {
			return true;
		}
		return false;
	}
	
	/**
	 * 保存用户session
	 * @param usdeid
	 * @param username
	 * @param password
	 * @param userarea
	 * @param departname
	 * @param groupid
	 */
	public void setUserSession(HttpServletRequest request,Object userid,Object username,Object password,Object userarea,Object managearea,Object chargearea,Object departname,Object groupid,Object canloginip,Object userloginip,Object custom) {
		session.setAttribute("userid", userid);
		session.setAttribute("username", username);
		session.setAttribute("password", password);
		session.setAttribute("managearea", managearea);
		session.setAttribute("departname", departname);
		session.setAttribute("groupid", groupid);
		session.setAttribute("canloginip", canloginip);
		session.setAttribute("userState", "online");
		session.setAttribute("chargearea", chargearea);
		session.setAttribute("userarea", userarea);
		session.setAttribute("custom", custom);
		//记录当前工号登陆IP
		session.setAttribute("userloginip", userloginip);
		//modify by chenliang on 2009-12-06
		UserManager uManager =  new UserManager();
		//modify by chenliang on 2009-12-30
		//超时时间默认设置为25分钟
		int theTime = Integer.parseInt(uManager.getSessionTime(request))*60;
		session.setAttribute("sessiontime", theTime);
		session.setMaxInactiveInterval(theTime);
	}
	//用户退出时调用
	public void userExit() {
		//移除登陆时记录的当前工号sessio
		session.removeAttribute("userid");
		session.removeAttribute("username");
		session.removeAttribute("password");
		session.removeAttribute("userarea");
		session.removeAttribute("departname");
		session.removeAttribute("groupid");
		session.removeAttribute("canloginip");
		session.removeAttribute("userState");
		session.removeAttribute("managearea");
		session.removeAttribute("chargearea");
		session.removeAttribute("sessiontime");
		session.removeAttribute("userloginip");
		//移除会话超时监听器
		session.removeAttribute("listener");
	}
}
