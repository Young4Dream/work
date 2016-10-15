package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tsd.domain.PackageGift;

public class PackageGiftDao {

	//PackageMainDbHelper dbHelper = new PackageMainDbHelper();
	
	public PackageGift findById(Connection conn, int id) throws Exception{
		
		List<PackageGift> result = new ArrayList<PackageGift>();
		
		String sql = "select ID, G_TYPE, GIFT_NAME, GIFT_ALL, G_REASON, G_IMG, CREATE_TIME, UPDATE_TIME, REMARK from OCS_PACKAGE_GIFT_LIST where ID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageGift packageGift = new PackageGift();
			packageGift.setId(rs.getInt("ID"));
			packageGift.setGType(rs.getInt("G_TYPE"));
			packageGift.setGiftName(rs.getString("GIFT_NAME"));
			packageGift.setGiftAll(rs.getString("GIFT_ALL"));
			packageGift.setGReason(rs.getString("G_REASON"));
			packageGift.setGImg(rs.getString("G_IMG"));
			packageGift.setCreateTime(rs.getDate("CREATE_TIME"));
			packageGift.setRemark(rs.getString("REMARK"));
			packageGift.setUpdateTime(rs.getDate("UPDATE_TIME"));
			result.add(packageGift);
			
		}
		
		return result.get(0);
	}
	
	/**
	 * 分页查询
	 * @param pageObject
	 * @return
	 */
	public List<PackageGift> findAll(Connection conn) throws Exception{
		
		List<PackageGift> result = new ArrayList<PackageGift>();
		
		String sql = "select ID, G_TYPE, GIFT_NAME, GIFT_ALL, G_REASON, G_IMG, CREATE_TIME, UPDATE_TIME, REMARK from OCS_PACKAGE_GIFT_LIST";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageGift packageGift = new PackageGift();
			packageGift.setId(rs.getInt("ID"));
			packageGift.setGType(rs.getInt("G_TYPE"));
			packageGift.setGiftName(rs.getString("GIFT_NAME"));
			packageGift.setGiftAll(rs.getString("GIFT_ALL"));
			packageGift.setGReason(rs.getString("G_REASON"));
			packageGift.setGImg(rs.getString("G_IMG"));
			packageGift.setCreateTime(rs.getDate("CREATE_TIME"));
			packageGift.setRemark(rs.getString("REMARK"));
			packageGift.setUpdateTime(rs.getDate("UPDATE_TIME"));
			
			result.add(packageGift);
		}
		
		return result;
	}
	
}
