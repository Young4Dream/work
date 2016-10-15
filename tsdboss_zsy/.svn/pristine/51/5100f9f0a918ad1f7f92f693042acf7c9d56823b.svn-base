package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tsd.domain.RateSalePolicy;

public class RateSalePolicyDao {

	public List<RateSalePolicy> findPackageAll(Connection conn) throws Exception{
		
		List<RateSalePolicy> result = new ArrayList<RateSalePolicy>();
		
		String sql = "select ID, SALE_NAME from OCS_RATE_SALE_POLICY where SALE_AREA = 2";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			RateSalePolicy rateSalePolicy = new RateSalePolicy();
			rateSalePolicy.setId(rs.getLong("ID"));
			rateSalePolicy.setSaleName(rs.getString("SALE_NAME"));
			result.add(rateSalePolicy);
		}
		
		return result;
	}
}
