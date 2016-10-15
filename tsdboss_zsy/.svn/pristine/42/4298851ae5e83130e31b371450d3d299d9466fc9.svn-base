package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tsd.domain.PackageBusiness;
import com.tsd.domain.PageObject;

public class PackageBusinessDao {

	//PackageMainDbHelper dbHelper = new PackageMainDbHelper();
	
	public PackageBusiness findById(Connection conn, int id) throws Exception{
		
		List<PackageBusiness> result = new ArrayList<PackageBusiness>();
		
		String sql = "select ID, PB_NAME, BID, CID, BUSINESS_UNIT, BUSINESS_NUM, BUSINESS_VIEW, COST_PRICE, STATUS, CREATE_TIME, UPDATE_TIME, REMARK from OCS_PACKAGE_BUSINESS where ID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageBusiness packageBusiness = new PackageBusiness();
			packageBusiness.setId(rs.getInt("ID"));
			packageBusiness.setBid(rs.getInt("BID"));
			packageBusiness.setBusinessNum(rs.getInt("BUSINESS_NUM"));
			packageBusiness.setBusinessUnit(rs.getInt("BUSINESS_UNIT"));
			packageBusiness.setBusinessView(rs.getString("BUSINESS_VIEW"));
			packageBusiness.setCid(rs.getInt("CID"));
			packageBusiness.setCostPrice(rs.getDouble("COST_PRICE"));
			packageBusiness.setPbName(rs.getString("PB_NAME"));
			packageBusiness.setStatus(rs.getInt("STATUS"));
			packageBusiness.setCreateTime(rs.getDate("CREATE_TIME"));
			packageBusiness.setRemark(rs.getString("REMARK"));
			packageBusiness.setUpdateTime(rs.getDate("UPDATE_TIME"));
			
			result.add(packageBusiness);
			
		}
		
		return result.get(0);
	}
	
	/**
	 * 分页查询
	 * @param pageObject
	 * @return
	 */
	public List<PackageBusiness> findAll(Connection conn) throws Exception{
		
		List<PackageBusiness> result = new ArrayList<PackageBusiness>();
		
		String sql = "select p.ID, p.PB_NAME, p.BID, p.CID, p.BUSINESS_UNIT, p.BUSINESS_NUM, p.BUSINESS_VIEW, p.COST_PRICE, p.STATUS, p.CREATE_TIME, p.UPDATE_TIME, p.REMARK,t.B_TYPE from OCS_PACKAGE_BUSINESS p left join ocs_business_dict t on bid=t.id";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageBusiness packageBusiness = new PackageBusiness();
			packageBusiness.setId(rs.getInt("ID"));
			packageBusiness.setBid(rs.getInt("BID"));
			packageBusiness.setBusinessNum(rs.getInt("BUSINESS_NUM"));
			packageBusiness.setBusinessUnit(rs.getInt("BUSINESS_UNIT"));
			packageBusiness.setBusinessView(rs.getString("BUSINESS_VIEW"));
			packageBusiness.setCid(rs.getInt("CID"));
			packageBusiness.setCostPrice(rs.getDouble("COST_PRICE"));
			packageBusiness.setPbName(rs.getString("PB_NAME"));
			packageBusiness.setStatus(rs.getInt("STATUS"));
			packageBusiness.setCreateTime(rs.getDate("CREATE_TIME"));
			packageBusiness.setRemark(rs.getString("REMARK"));
			packageBusiness.setUpdateTime(rs.getDate("UPDATE_TIME"));
			packageBusiness.setBType(rs.getInt("B_TYPE"));
			result.add(packageBusiness);
		}
		
		return result;
	}
	
}
