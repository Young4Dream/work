/*****************************************************************
 * name: RowMappers.java
 * author: dangchengcheng
 * version: 
 * description: 此类为 ProcedureExeFoctory 类服务
 * modify: 2010-11-22 luoyulong 添加注释
 *****************************************************************/
package com.tsd.dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;

public class RowMappers implements RowMapper  {
	public Object mapRow(ResultSet rs, int rowNum){
		Map objMap = new HashMap();
		ResultSetMetaData rsmd;
		try {
			rsmd = rs.getMetaData();
		
		int size = rs.getMetaData().getColumnCount();
		for (int i = 0; i <size; i++) {
			objMap.put(rsmd.getColumnName(i),rs.getObject(i));
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return objMap;
	}

}
