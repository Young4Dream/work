package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tsd.domain.PackageMain;
import com.tsd.domain.PackageRate;
import com.tsd.domain.PageObject;

public class PackageFreeResDao {

	/**
	 * 分页查询套餐
	 * @param pageObject
	 * @return
	 */
	public List<PackageRate> findByPid(Connection conn, int pid) throws Exception{
		
		List<PackageRate> result = new ArrayList<PackageRate>();
		
		String sql = "select ID, PID, NID, BN_UNIT, FREE_RES_VOLUME, CREATE_TIME, UPDATE_TIME, REMARK from OCS_PACKAGE_FREE_RES where PID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, pid);
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageRate packageRate = new PackageRate();
			packageRate.setId(rs.getInt("ID"));
			packageRate.setPid(rs.getInt("PID"));
			packageRate.setNid(rs.getInt("NID"));
			packageRate.setBnUnit(rs.getInt("BN_UNIT"));
			packageRate.setFreeResVolume(rs.getDouble("FREE_RES_VOLUME"));
			packageRate.setCreateTime(rs.getDate("CREATE_TIME"));
			packageRate.setUpdateTime(rs.getDate("UPDATE_TIME"));
			packageRate.setRemark(rs.getString("REMARK"));
			result.add(packageRate);
			
		}
		pst.close();
		return result;
	}
	
	/**
	 * 分页查询套餐
	 * @param pageObject
	 * @return
	 */
	public List<PackageRate> findAll(Connection conn, PageObject pageObject) throws Exception{
		
		List<PackageRate> result = new ArrayList<PackageRate>();
		
		String sql = "select ID, PID, NID, BN_UNIT, FREE_RES_VOLUME, CREATE_TIME, UPDATE_TIME, REMARK from OCS_PACKAGE_FREE_RES";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageRate packageRate = new PackageRate();
			packageRate.setId(rs.getInt("ID"));
			packageRate.setPid(rs.getInt("PID"));
			packageRate.setNid(rs.getInt("NID"));
			packageRate.setBnUnit(rs.getInt("BN_UNIT"));
			packageRate.setFreeResVolume(rs.getDouble("FREE_RES_VOLUME"));
			packageRate.setCreateTime(rs.getDate("CREATE_TIME"));
			packageRate.setUpdateTime(rs.getDate("UPDATE_TIME"));
			packageRate.setRemark(rs.getString("REMARK"));
			result.add(packageRate);
			
		}
		pst.close();
		return result;
	}
	
	/**
	 * 新增
	 * @param packageRate
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public int insert(PackageRate packageRate, Connection conn) throws Exception{
		String vsql = "select OCS_PACKAGE_FREE_RES_SEQ.nextval as id from dual";  
	    PreparedStatement pstmt =(PreparedStatement)conn.prepareStatement(vsql);  
	    ResultSet rs=pstmt.executeQuery();  
	    rs.next();  
	    int id=rs.getInt(1);  
	    rs.close();
	    
		String sql = "insert into OCS_PACKAGE_FREE_RES(ID, PID, NID, BN_UNIT, FREE_RES_VOLUME, CREATE_TIME, UPDATE_TIME, REMARK) values(?,?,?,?,?,?,?,?)";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, id);
		pst.setInt(2, packageRate.getPid());
		pst.setInt(3, packageRate.getNid());
		pst.setDouble(4, packageRate.getBnUnit());
		pst.setDouble(5, packageRate.getFreeResVolume());
		Date date = new Date();
		pst.setDate(6, new java.sql.Date(date.getTime()));
		pst.setDate(7, new java.sql.Date(date.getTime()));
		pst.setString(8, packageRate.getRemark());
		pst.executeQuery();
		pst.close();
		return id;
	}
	
	public void deleteByPid(Connection conn, int pid) throws Exception{
		
		String sql = "delete from OCS_PACKAGE_FREE_RES where PID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, pid);
		
		pst.executeQuery();
		
		pst.close();
	}
}
