package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tsd.domain.PackageTypeDict;
import com.tsd.domain.PageObject;

public class PackageTypeDictDao {

	//PackageMainDbHelper dbHelper = new PackageMainDbHelper();
	
	public PackageTypeDict findById(Connection conn, int id) throws Exception{
		
		List<PackageTypeDict> result = new ArrayList<PackageTypeDict>();
		
		String sql = "select ID, PAG_SHORT, PAG_DEPICT, OPERATOR, CREATE_TIME, UPDATE_TIME, REMARK from OCS_PACKAGE_TYPE_DICT where ID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageTypeDict packageTypeDict = new PackageTypeDict();
			packageTypeDict.setId(rs.getInt("ID"));
			packageTypeDict.setPagDepict(rs.getString("PAG_DEPICT"));
			packageTypeDict.setPagShort(rs.getString("PAG_SHORT"));
			packageTypeDict.setCreateTime(rs.getDate("CREATE_TIME"));
			packageTypeDict.setOperator(rs.getString("OPERATOR"));
			packageTypeDict.setRemark(rs.getString("REMARK"));
			packageTypeDict.setUpdateTime(rs.getDate("UPDATE_TIME"));
			
			result.add(packageTypeDict);
			
		}
		
		return result.get(0);
	}
	
	/**
	 * 分页查询
	 * @param pageObject
	 * @return
	 */
	public List<PackageTypeDict> findAll(Connection conn) throws Exception{
		
		List<PackageTypeDict> result = new ArrayList<PackageTypeDict>();
		
		String sql = "select ID, PAG_SHORT, PAG_DEPICT, OPERATOR, CREATE_TIME, UPDATE_TIME, REMARK from OCS_PACKAGE_TYPE_DICT order by id";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageTypeDict packageTypeDict = new PackageTypeDict();
			packageTypeDict.setId(rs.getInt("ID"));
			packageTypeDict.setPagDepict(rs.getString("PAG_DEPICT"));
			packageTypeDict.setPagShort(rs.getString("PAG_SHORT"));
			packageTypeDict.setCreateTime(rs.getDate("CREATE_TIME"));
			packageTypeDict.setOperator(rs.getString("OPERATOR"));
			packageTypeDict.setRemark(rs.getString("REMARK"));
			packageTypeDict.setUpdateTime(rs.getDate("UPDATE_TIME"));
			
			result.add(packageTypeDict);
		}
		
		return result;
	}
	
}
