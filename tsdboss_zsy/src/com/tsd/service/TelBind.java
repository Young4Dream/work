package com.tsd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.StringUtil;

public class TelBind {
	/**
	 * 执行添删改方法
	 * 
	 * @param request
	 * @param response
	 */
	public void operation(HttpServletRequest request,
			HttpServletResponse response) {
		String unitelno = request.getSession().getAttribute("unitelno")
				.toString();

		// List bindList =new ArrayList<Map>();
		try {
			for (int i = 1; i <= 5; i++) {
				String id = request.getParameter("id" + i);
				String bandtel = request.getParameter("bandtel" + i);
				String callpri = request.getParameter("callpri" + i);
				String sql = "select * from unicall_band where id=";
				if (!StringUtil.isNotEmpty(id)) {
					sql += "-1" + " and unitelno='" + unitelno + "'";
				} else {
					sql += id + " and unitelno='" + unitelno + "'";
				}
				int count = GetCount(sql);
				// ////////////////////////////////////////////
				// 如果数据库存在
				// //////////////////////////////////////////////
				if (count > 0) {

					if (StringUtil.isNotEmpty(id)) {
						// ////////////////////////////////////////////
						// 如果数据库存在并现有参数同样存在 则进行修改操作
						// //////////////////////////////////////////////
						if (StringUtil.isNotEmpty(bandtel)
								&& StringUtil.isNotEmpty(callpri)) {
							edit(id, unitelno, bandtel, callpri);
						} else {
							// ////////////////////////////////////////////
							// 如果数据库存在而现有参数为空 则进行删除操作
							// //////////////////////////////////////////////
							del(id);
						}
					}
				} else {
					// /////////////////////////////
					// 如果之前不存在则新增
					// /////////////////////////////
					if (StringUtil.isNotEmpty(bandtel)) {
						if (StringUtil.isNotEmpty(callpri)) {
							add(unitelno, bandtel, callpri);
						}
					}
				}
			}
		} catch (Exception ex) {
			ClientOutPut.printout(response, "false", "");
			throw new RuntimeException(ex.getMessage());
		}
		ClientOutPut.printout(response, "true", "");
	}

	/***************************************************************************
	 * 删除绑定电话
	 * 
	 * @param request
	 * @param response
	 */
	public void del(String id) {
		String sql = "delete from unicall_band where id=" + id;
		DBhelper.jdbcTemplate.execute(sql);
	}

	/***************************************************************************
	 * 修改绑定电话
	 * 
	 * @param request
	 * @param response
	 */
	public void edit(String id, String unitelno, String bandtel, String callpri) {
		String sql = "update unicall_band set id=id";
		if (StringUtil.isNotEmpty(unitelno)) {
			sql += " ,unitelno='" + unitelno + "'";
		}
		if (StringUtil.isNotEmpty(bandtel)) {
			sql += " ,bandtel='" + bandtel + "'";
		}
		if (StringUtil.isNotEmpty(callpri)) {
			sql += " ,callpri='" + callpri + "'";
		}
		sql += "where id=" + id + "and unitelno ='" + unitelno + "'";
		DBhelper.jdbcTemplate.execute(sql);
	}

	/***************************************************************************
	 * 新增绑定电话
	 * 
	 * @param request
	 * @param response
	 */
	public void add(String unitelno, String bandtel, String callpri) {

		String sql = "insert into unicall_band(unitelno,bandtel,callpri) values("
				+ "'" + unitelno + "','" + bandtel + "','" + callpri + "')";
		DBhelper.jdbcTemplate.execute(sql);
	}

	List list = null;

	public void query(HttpServletRequest request, HttpServletResponse response) {
		String unitelno = request.getSession().getAttribute("unitelno")
				.toString();
		String sql = "select * from unicall_band where unitelno='" + unitelno
				+ "'";

		list = DBhelper.jdbcTemplate.queryForList(sql);
		int len = list.size();
		String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
		// String xmls="";
		xmls += "<rows>";
		for (int i = 0; i < len; i++) {
			Map telmap = (Map) list.get(i);
			Object id = telmap.get("id");
			Object bandtel = telmap.get("bandtel");
			Object callpri = telmap.get("callpri");
			xmls += "<row id=\"" + id + "\" bandtel=\"" + bandtel
					+ "\" callpri=\"" + callpri + "\" />";
		}
		xmls += "</rows>";
		ClientOutPut.printout(response, xmls, "xml");
		//System.out.println(xmls);
	}

	private Integer GetCount(String sql) {
		try {
			int num = DBhelper.jdbcTemplate.queryForList(sql).size();
			return num;
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		}
		return 0;
	}
}
