package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tsd.domain.PackageRate;

public class PackageRateDao {

	/**
	 * 根据套餐id查询
	 * @param conn
	 * @param id
	 * @return
	 */
	public List<PackageRate> queryByPid(Connection conn, int pid) throws Exception{
		
		List<PackageRate> result = new ArrayList<PackageRate>();
		
		String sql = "select p.ID, p.PID, p.NID, p.BN_UNIT, p.BN_UNIT_NUM, p.BN_UNIT_VALUE, p.BN_THRESHOLD, p.COST_PRICE, p.BN_RATE_PRICE, p.RATE_STATUS, p.CREATE_TIME, p.UPDATE_TIME, p.REMARK,p.B_TYPE,p.BASIC_NUM_MIN,p.BASIC_NUM_MAX,p.BASIC_FEE,p.SPECIAL_RATE,s.id as policy_id,s.SALE_NAME from OCS_PACKAGE_RATE p left join OCS_RATE_SALE_POLICY s on p.policy_id = s.id where PID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, pid);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageRate packageRate = new PackageRate();
			packageRate.setId(rs.getInt("ID"));
			packageRate.setPid(rs.getInt("PID"));
			packageRate.setNid(rs.getInt("NID"));
			packageRate.setBnUnit(rs.getInt("BN_UNIT"));
			packageRate.setBnUnitNum(rs.getInt("BN_UNIT_NUM"));
			packageRate.setBnUnitValue(rs.getString("BN_UNIT_VALUE"));
			packageRate.setBnThreshold(rs.getDouble("BN_THRESHOLD"));
			packageRate.setCostPrice(rs.getDouble("COST_PRICE"));
			packageRate.setBnRatePrice(rs.getDouble("BN_RATE_PRICE"));
			packageRate.setRateStatus(rs.getInt("RATE_STATUS"));
			packageRate.setRateStatus(rs.getInt("RATE_STATUS"));
			packageRate.setCreateTime(rs.getDate("CREATE_TIME"));
			packageRate.setUpdateTime(rs.getDate("UPDATE_TIME"));
			packageRate.setRemark(rs.getString("REMARK"));
			packageRate.setBType(rs.getInt("B_TYPE"));
			packageRate.setBasicNumMin(rs.getInt("BASIC_NUM_MIN"));
			packageRate.setBasicNumMax(rs.getInt("BASIC_NUM_MAX"));
			packageRate.setBasicFee(rs.getDouble("BASIC_FEE"));
			packageRate.setSpecialRate(rs.getDouble("SPECIAL_RATE"));//特服费率
			packageRate.setRateSalePolicy(rs.getInt("policy_id")==0?-1:rs.getInt("policy_id"));
			packageRate.setRateSalePolicyName(rs.getString("sale_name")==null?"":rs.getString("sale_name"));
			result.add(packageRate);
		}
		pst.close();
		return result;
	}
	
	public void deleteByPid(Connection conn, int pid) throws Exception{
		
		String sql = "delete from OCS_PACKAGE_RATE where PID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, pid);
		
		pst.executeQuery();
		
		pst.close();
	}
	/**
	 * 
	 * @param packageRate
	 * @param conn
	 * @throws Exception
	 */
	public void insert(PackageRate packageRate, Connection conn) throws Exception{
		String vsql = "select OCS_PACKAGE_RATE_SEQ.nextval as id from dual";  
	    PreparedStatement pstmt =(PreparedStatement)conn.prepareStatement(vsql);  
	    ResultSet rs=pstmt.executeQuery();  
	    rs.next();  
	    int id=rs.getInt(1);
	    rs.close();
	    
		String sql = "insert into OCS_PACKAGE_RATE(ID, PID, NID, BN_UNIT, BN_UNIT_NUM, BN_UNIT_VALUE, BN_THRESHOLD, COST_PRICE, BN_RATE_PRICE, RATE_STATUS, CREATE_TIME, UPDATE_TIME, REMARK,B_TYPE,BASIC_NUM_MIN,BASIC_NUM_MAX,BASIC_FEE,POLICY_ID,SPECIAL_RATE) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, id);
		pst.setInt(2, packageRate.getPid());
		pst.setInt(3, packageRate.getNid());
		pst.setInt(4, packageRate.getBnUnit());
		pst.setInt(5, packageRate.getBnUnitNum());
		pst.setString(6, packageRate.getBnUnitValue());
		pst.setDouble(7, packageRate.getBnThreshold());
		pst.setDouble(8, packageRate.getCostPrice());
		pst.setDouble(9, packageRate.getBnRatePrice());
		pst.setDouble(10, packageRate.getRateStatus());
		Date date = new Date();
		pst.setDate(11, new java.sql.Date(date.getTime()));
		pst.setDate(12, new java.sql.Date(date.getTime()));
		pst.setDouble(13, packageRate.getBnThreshold());
		pst.setInt(14, packageRate.getBType());
		pst.setInt(15, packageRate.getBasicNumMin());
		pst.setInt(16, packageRate.getBasicNumMax());
		pst.setDouble(17, packageRate.getBasicFee());
		pst.setInt(18, packageRate.getRateSalePolicy());
		pst.setDouble(19, packageRate.getSpecialRate());
		pst.executeQuery();
		
		pst.close();
	}

}
