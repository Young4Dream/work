package com.tsd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.StringUtil;

public class TimeCall {
	List<Map<String, Object>> list = null;
	public void query(HttpServletRequest request, HttpServletResponse response){
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		String bandtel = request.getParameter("bandtel");
		String unitelno = request.getSession().getAttribute("unitelno").toString();
		if (!StringUtil.isNotEmpty(rows)||"0".equals(rows)) {
			rows="10";
		}
		if (!StringUtil.isNotEmpty(page)||"0".equals(page)) {
				page="1";
		}
		
		
		String sql="select * from unicall_timecall where 1=1 ";
		if (StringUtil.isNotEmpty(unitelno)) {
			sql+=" and unitelno='"+unitelno+"'";
		}else{return;}
		if (StringUtil.isNotEmpty(bandtel)) {
			sql+=" and bandtel='"+bandtel+"'";
		}
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
			xmls+="<cell id=\""+map.get("id")+"\" unitelno=\""+map.get("unitelno")+"\" bandtel=\""+map.get("bandtel")+"\" starttime=\""+map.get("starttime")+"\"  endtime=\""+map.get("endtime")+"\" />";
		}
		xmls+="</rows>";
		ClientOutPut.printout(response, xmls, "xml");
	}
	//获取总记录数
	private int getCount(String sql) {
		return DBhelper.jdbcTemplate.queryForList(sql).size();
	}
	/****
	 * 删除外拨时段
	 * @param request
	 * @param response
	 */
	public  void del(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String sql = "delete from unicall_timecall where";
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
	 * 添加外拨时段
	 * @param request
	 * @param response
	 */
	public void add(HttpServletRequest request, HttpServletResponse response){
		String bandtel = request.getParameter("bandtel");
		String starttime = request.getParameter("starttime");
		String endtime = request.getParameter("endtime");
		String unitelno = request.getSession().getAttribute("unitelno").toString();
		String sql = "INSERT INTO unicall_timecall(unitelno, bandtel, starttime, endtime) VALUES(";
		
		if (StringUtil.isNotEmpty(unitelno)) {
			sql+="'"+unitelno+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(bandtel)) {
			sql+=",'"+bandtel+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(starttime)) {
			sql+=",'"+starttime+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(endtime)) {
			sql+=",'"+endtime+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		//System.out.println("1>>>"+sql);
		sql+=")";
		//System.out.println("2>>>"+sql);
		//测试是否存在此外拨时段
//		String testsql = ;
		DBhelper.jdbcTemplate.execute(sql);
		ClientOutPut.printout(response, "true", "");
	}
	/***
	 * 用过id获取单个外拨时段
	 * @param request
	 * @param response
	 */
	public void getTimeCall(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String sql = "select * from unicall_timecall where id = "+id;
		Map map=DBhelper.jdbcTemplate.queryForMap(sql);
		String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
		xmls+="<row>";
		xmls+="<cell bandtel=\""+map.get("bandtel")+"\"  starttime=\""+map.get("starttime")+"\"  endtime=\""+map.get("endtime")+"\" />";
		xmls+="</row>";
		ClientOutPut.printout(response, xmls, "xml");
		
	}
	
	/******
	 * 添加外拨时段
	 * @param request
	 * @param response
	 */
	public void modify(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id");
		String bandtel = request.getParameter("bandtel");
		String starttime = request.getParameter("starttime");
		String endtime = request.getParameter("endtime");
		String unitelno = request.getSession().getAttribute("unitelno").toString();
		String sql = "UPDATE unicall_timecall SET id=id ";
		if (StringUtil.isNotEmpty(bandtel)) {
			sql+=",bandtel='"+bandtel+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(starttime)) {
			sql+=",starttime='"+starttime+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(endtime)) {
			sql+=",endtime='"+endtime+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(unitelno)) {
			sql+=" where  unitelno='"+unitelno+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		if (StringUtil.isNotEmpty(id)) {
			sql+=" and  id='"+id+"'";
		}else{
			ClientOutPut.printout(response, "false", "");
			return;
		}
		//测试是否存在此外拨时段
		DBhelper.jdbcTemplate.execute(sql);
		ClientOutPut.printout(response, "true", "");
	}
}
