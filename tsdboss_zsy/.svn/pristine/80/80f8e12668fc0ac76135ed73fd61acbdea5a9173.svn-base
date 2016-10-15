package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tsd.domain.PackageMain;
import com.tsd.domain.PageObject;

public class PackageMainDao {

	//PackageMainDbHelper dbHelper = new PackageMainDbHelper();
	
	public PackageMain findById(Connection conn, int id) throws Exception{
		
		List<PackageMain> result = new ArrayList<PackageMain>();
		
		String sql = "select ID, PACKAGE_NAME, PACKAGE_TYPE, PACKAGE_FEE, PACKAGE_STATUS, PAG_FREE_NUM, GID, CREATE_TIME, UPDATE_TIME, REMARK,OPERATOR,SERVICE_TYPE,SUB_SERVICE_TYPE from OCS_PACKAGE_MAIN where ID = ?";
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageMain packageMain = new PackageMain();
			packageMain.setId(rs.getInt("ID"));
			packageMain.setPackageName(rs.getString("PACKAGE_NAME"));
			packageMain.setPackageType(rs.getInt("PACKAGE_TYPE"));
			packageMain.setPackageFee(rs.getDouble("PACKAGE_FEE"));
			packageMain.setPackageStatus(rs.getInt("PACKAGE_STATUS"));
			packageMain.setPagFreeNum(rs.getInt("PAG_FREE_NUM"));
			packageMain.setGid(rs.getInt("GID"));
			packageMain.setCreateTime(rs.getDate("CREATE_TIME"));
			packageMain.setUpdateTime(rs.getDate("UPDATE_TIME"));
			packageMain.setRemark(rs.getString("REMARK"));
			packageMain.setOperator(rs.getInt("OPERATOR"));
			packageMain.setServiceType(rs.getString("SERVICE_TYPE"));
			packageMain.setSubServiceType(rs.getString("SUB_SERVICE_TYPE"));
			result.add(packageMain);
			
		}
		pst.close();
		return result.get(0);
	}
	
	/**
	 * 分页查询套餐
	 * @param pageObject
	 * @return
	 */
	public List<PackageMain> findPackageMainByPage(Connection conn, PageObject pageObject) throws Exception{
		
		List<PackageMain> result = new ArrayList<PackageMain>();
		
		//查询总数量
		String countsql = "SELECT count(*) as count from OCS_PACKAGE_MAIN ";
		
		PreparedStatement pstcount = conn.prepareStatement(countsql);
		
		ResultSet rscount = pstcount.executeQuery();
		
		while(rscount.next()){
			pageObject.setSumCloum(rscount.getInt("count"));
		}
		
		String sql = "SELECT *"+
		"FROM (SELECT tt.ID, tt.PACKAGE_NAME, tt.PACKAGE_TYPE, tt.PACKAGE_FEE, tt.PACKAGE_STATUS, tt.PAG_FREE_NUM, tt.GID, tt.CREATE_TIME, tt.UPDATE_TIME, tt.REMARK,tt.OPERATOR,tt.SERVICE_TYPE, tt.SUB_SERVICE_TYPE, ROWNUM AS rowno "+
        "FROM ( select ID, PACKAGE_NAME, PACKAGE_TYPE, PACKAGE_FEE, PACKAGE_STATUS, PAG_FREE_NUM, GID, CREATE_TIME, UPDATE_TIME, REMARK,OPERATOR,SERVICE_TYPE, SUB_SERVICE_TYPE from OCS_PACKAGE_MAIN  order by CREATE_TIME desc) tt "+
        "WHERE ROWNUM <= "+pageObject.getCurrentPage()*pageObject.getPageSize()+") table_alias "+
        "WHERE table_alias.rowno > "+(pageObject.getCurrentPage()-1)*pageObject.getPageSize();
		
		PreparedStatement pst = conn.prepareStatement(sql);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next()){
			PackageMain packageMain = new PackageMain();
			packageMain.setId(rs.getInt("ID"));
			packageMain.setPackageName(rs.getString("PACKAGE_NAME"));
			packageMain.setPackageType(rs.getInt("PACKAGE_TYPE"));
			packageMain.setPackageFee(rs.getDouble("PACKAGE_FEE"));
			packageMain.setPackageStatus(rs.getInt("PACKAGE_STATUS"));
			packageMain.setPagFreeNum(rs.getInt("PAG_FREE_NUM"));
			packageMain.setGid(rs.getInt("GID"));
			packageMain.setCreateTime(rs.getTimestamp("CREATE_TIME"));
			packageMain.setUpdateTime(rs.getTimestamp("UPDATE_TIME"));
			packageMain.setRemark(rs.getString("REMARK"));
			packageMain.setOperator(rs.getInt("OPERATOR"));
			packageMain.setServiceType(rs.getString("SERVICE_TYPE"));
			packageMain.setSubServiceType(rs.getString("SUB_SERVICE_TYPE"));
			result.add(packageMain);
			
		}
		pst.close();
		return result;
	}
	
	/**
	 * 新增
	 * @param packageMain
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public int insert(PackageMain packageMain, Connection conn) throws Exception{
		String vsql = "select OCS_PACKAGE_MAIN_SEQ.nextval as id from dual";  
	    PreparedStatement pstmt =(PreparedStatement)conn.prepareStatement(vsql);  
	    ResultSet rs=pstmt.executeQuery();  
	    rs.next();  
	    int id=rs.getInt(1);  
	    rs.close();
	    
		String sql = "insert into OCS_PACKAGE_MAIN(ID, PACKAGE_NAME, PACKAGE_TYPE, PACKAGE_FEE, PACKAGE_STATUS, PAG_FREE_NUM, GID, CREATE_TIME, UPDATE_TIME, REMARK,SERVICE_TYPE,SUB_SERVICE_TYPE) values(?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, id);
		pst.setString(2, packageMain.getPackageName());
		pst.setInt(3, packageMain.getPackageType());
		pst.setDouble(4, packageMain.getPackageFee());
		pst.setInt(5, packageMain.getPackageStatus());
		pst.setInt(6, packageMain.getPagFreeNum());
		pst.setInt(7, packageMain.getGid());
		pst.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
		pst.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
		pst.setString(10, packageMain.getRemark());
		//pst.setInt(11, packageMain.getOperator());
		pst.setString(11, packageMain.getServiceType());
		pst.setString(12, packageMain.getSubServiceType());
		pst.executeQuery();
		pst.close();
		return id;
	}
	
	/**
	 * 修改
	 * @param conn
	 * @param packageMain
	 */
	public void update(Connection conn, PackageMain packageMain) throws Exception{
		String sql = "update OCS_PACKAGE_MAIN set PACKAGE_NAME = ?, PACKAGE_TYPE = ?, PACKAGE_FEE = ?, PACKAGE_STATUS = ?, PAG_FREE_NUM = ?, GID = ?, UPDATE_TIME = ?, REMARK = ?,SERVICE_TYPE=?,SUB_SERVICE_TYPE=? where ID = ?";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setString(1, packageMain.getPackageName());
		pst.setInt(2, packageMain.getPackageType());
		pst.setDouble(3, packageMain.getPackageFee());
		pst.setInt(4, packageMain.getPackageStatus());
		pst.setInt(5, packageMain.getPagFreeNum());
		pst.setInt(6, packageMain.getGid());
		Date date = new Date();
		pst.setDate(7, new java.sql.Date(date.getTime()));
		pst.setString(8, packageMain.getRemark());
		//pst.setInt(9, packageMain.getOperator());
		pst.setString(9, packageMain.getServiceType());
		pst.setString(10, packageMain.getSubServiceType());
		pst.setInt(11, packageMain.getId());
		pst.executeQuery();
		
		pst.close();
	}
	
	/**
	 * 删除
	 * @param conn
	 * @param packageMain
	 */
	public void delete(Connection conn, int id) throws Exception{
		String sql = "delete from OCS_PACKAGE_MAIN where ID = ?";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1, id);
		pst.executeQuery();
		pst.close();
	}
}
