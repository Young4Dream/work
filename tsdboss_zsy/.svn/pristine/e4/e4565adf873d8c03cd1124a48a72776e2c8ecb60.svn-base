package com.tsd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.StringUtil;

/*******************************************************************************
 * 黑名单 白名单
 * 
 * @author Dangchengcheng
 * 
 */
public class BlackWhite {
	List<Map<String, Object>> list = null;
	public void query(HttpServletRequest request, HttpServletResponse response) {
		String flag = request.getParameter("flag");
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		String unitelno = request.getSession().getAttribute("unitelno").toString();
		if (!StringUtil.isNotEmpty(rows)||"0".equals(rows)) {
			rows="10";
		}
		if (!StringUtil.isNotEmpty(page)||"0".equals(page)) {
				page="1";
		}
		
		
		String sql="select * from unicall_blackwhite where 1=1 ";
		if (StringUtil.isNotEmpty(flag)) {
			sql+=" and flag="+flag;
		}
		if (StringUtil.isNotEmpty(unitelno)) {
			sql+=" and unitelno='"+unitelno+"'";
		}else{return;}
		int limits = Integer.parseInt(rows); //获取要提取的行数
		int ipage = Integer.parseInt(page);//获取当前页码
		int count = getCount(sql);
		int total_pages=0;
		if (count>0){
			total_pages = (int) Math.ceil((double)count/(double)limits);			
		}
		if (total_pages==0){
			total_pages=1;
		}
		if (ipage > total_pages){
			ipage=total_pages;
			page=Integer.toString(ipage);
		}
		Integer istart = limits*ipage - limits;
		sql+="limit "+rows+" offset "+istart;
		list = DBhelper.jdbcTemplate.queryForList(sql);
		int len = list.size();
		String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
		xmls+="<rows page=\""+page+"\" total=\""+total_pages+"\" records=\""+count+"\">";
		for (int i = 0; i < len; i++) { 
			Map map = list.get(i);
			xmls+="<cell id=\""+map.get("id")+"\" unitelno=\""+map.get("unitelno")+"\" caller=\""+map.get("caller")+"\" />";
		}
		xmls+="</rows>";
		ClientOutPut.printout(response, xmls, "xml");
	}
	private int getCount(String sql) {
		
		return DBhelper.jdbcTemplate.queryForList(sql).size();
	}
	/****
	 * 删除黑白名单
	 * @param request
	 * @param response
	 */
	public  void del(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String sql = "delete from unicall_blackwhite where";
		if (StringUtil.isNotEmpty(id)) {
			sql+=" id ="+id;
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		DBhelper.jdbcTemplate.execute(sql);
		ClientOutPut.printout(response, "true", "");
	}
	/******
	 * 添加黑白名单
	 * @param request
	 * @param response
	 */
	public void add(HttpServletRequest request, HttpServletResponse response){
		String caller = request.getParameter("caller");
		String flag = request.getParameter("falg");
		String unitelno = request.getSession().getAttribute("unitelno").toString();
		String sql = "INSERT INTO unicall_blackwhite(unitelno, caller, flag) VALUES (";
		
		if (StringUtil.isNotEmpty(unitelno)) {
			sql+="'"+unitelno+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(caller)) {
			sql+=",'"+caller+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(flag)) {
			sql+=","+flag+")";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		DBhelper.jdbcTemplate.execute(sql);
		ClientOutPut.printout(response, "true", "");
	}
	/******
	 * 修改黑白名单
	 * @param request
	 * @param response
	 */
	public void modify(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id");
		String caller = request.getParameter("caller");
		String flag = request.getParameter("falg");
		String unitelno = request.getSession().getAttribute("unitelno").toString();
		String sql = "UPDATE unicall_blackwhite  SET ";
		
		if (StringUtil.isNotEmpty(unitelno)) {
			sql+="unitelno= '"+unitelno+"'";
		}
		if (StringUtil.isNotEmpty(caller)) {
			sql+=",caller='"+caller+"'";
		}
		if (StringUtil.isNotEmpty(flag)) {
			sql+=",flag="+flag;
		}
		if (StringUtil.isNotEmpty(id)) {
			sql+=" where id="+id;
		}else{
			ClientOutPut.printout(response, "false", "");
		}
		DBhelper.jdbcTemplate.execute(sql);
		ClientOutPut.printout(response, "true", "");
	}
}
