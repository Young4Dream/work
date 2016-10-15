package com.tsd.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.tsd.dao.DBhelper;
import com.tsd.dao.PackageBusinessDao;
import com.tsd.dao.PackageFreeResDao;
import com.tsd.dao.PackageGiftDao;
import com.tsd.dao.PackageMainDao;
import com.tsd.dao.PackageRateDao;
import com.tsd.dao.PackageTypeDictDao;
import com.tsd.dao.RateSalePolicyDao;
import com.tsd.domain.PackageBusiness;
import com.tsd.domain.PackageGift;
import com.tsd.domain.PackageMain;
import com.tsd.domain.PackageRate;
import com.tsd.domain.PackageTypeDict;
import com.tsd.domain.PageObject;
import com.tsd.domain.RateSalePolicy;

public class PackageMainService {

	private PackageMainDao packageMainDao = new PackageMainDao();
	
	private PackageRateDao packageRateDao = new PackageRateDao();
	
	private PackageGiftDao packageGiftDao = new PackageGiftDao();
	
	PackageTypeDictDao packageTypeDao = new PackageTypeDictDao();
	
	PackageBusinessDao packageBusinessDao = new PackageBusinessDao();
	
	private PackageFreeResDao packageFreeResDao = new PackageFreeResDao();
	
	private RateSalePolicyDao rateSalePolicyDao = new RateSalePolicyDao();
	
	/**
	 * 查询新增页面基础数据
	 * @return
	 */
	public String initData(){
		
		Connection conn = null;
		
		try{
			conn = DBhelper.getConnection("tsdboss");
			
			List<PackageTypeDict> types = packageTypeDao.findAll(conn);
			
			List<PackageBusiness> businessses = packageBusinessDao.findAll(conn);
			
			List<PackageGift>  gifts = packageGiftDao.findAll(conn);
			
			List<RateSalePolicy> salePolicys = rateSalePolicyDao.findPackageAll(conn);
			
			String typesJson = JSONArray.toJSONString(types);
			
			String businesssesJson = JSONArray.toJSONString(businessses);
			
			String giftJson = JSONArray.toJSONString(gifts);
			
			String salePolicyJson = JSONArray.toJSONString(salePolicys);
			
			return typesJson + "/*/" + businesssesJson + "/*/" + giftJson + "/*/" + salePolicyJson;
			
		}catch(Exception e){
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	
	/**
	 * 根据页码查询套餐数据
	 */
	public List<PackageMain> queryPackageMainByPage(PageObject pageObject){
		
		Connection conn = null;
		
		List<PackageMain> result = null;
		
		try{
			conn = DBhelper.getConnection("tsdboss");
			
			result = packageMainDao.findPackageMainByPage(conn, pageObject);
			List<PackageTypeDict> types = packageTypeDao.findAll(conn);
			for(PackageMain main : result){
				
				for(PackageTypeDict dict : types){
					if(main.getPackageType() == dict.getId()){
						main.setPackageTypeName(dict.getPagShort());
						break;
					}
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}
	
	/**
	 * 根据主键查询套餐
	 * @param id
	 * @return
	 */
	public String queryPackageMainById(int id){
		Connection conn = null;
		
		String result = "";
		try{
			conn = DBhelper.getConnection("tsdboss");
			
			//页面初始化需要的数据
			List<PackageTypeDict> types = packageTypeDao.findAll(conn);
			
			List<PackageBusiness> businessses = packageBusinessDao.findAll(conn);
			
			List<PackageGift>  gifts = packageGiftDao.findAll(conn);
			
			List<RateSalePolicy> salePolicys = rateSalePolicyDao.findPackageAll(conn);
			
			String typesJson = JSONArray.toJSONString(types);
			
			String businesssesJson = JSONArray.toJSONString(businessses);
			
			String giftJson = JSONArray.toJSONString(gifts);
			
			String salePolicyJson = JSONArray.toJSONString(salePolicys);
			
			String initData = typesJson + "/*/" + businesssesJson + "/*/" + giftJson + "/*/" + salePolicyJson;
			
			
			//查询套餐
			PackageMain packageMain = packageMainDao.findById(conn, id);
			
			//根据pid查询费率
			List<PackageRate> rateList = packageRateDao.queryByPid(conn, id);
			
			//根据pid查询免费资源
			List<PackageRate> freeResList = packageFreeResDao.findByPid(conn, id);
			
			for(PackageRate rate : rateList){
				for(PackageBusiness bz : businessses){
					if(rate.getNid() == bz.getId()){
						rate.setNidName(bz.getPbName());
						break;
					}
				}
				
				for(PackageRate freeRes : freeResList){
					if(rate.getNid() == freeRes.getNid()){
						rate.setFreeResVolume(freeRes.getFreeResVolume());
						freeRes.setFreeResVolume(0);
						break;
					}
				}
			}
			
			String packageMainJson = JSON.toJSONString(packageMain);
			
			String rateListJson = JSONArray.toJSONString(rateList);
			
			result = initData + "/=/" + packageMainJson + "/*/" + rateListJson;
			
		}catch(Exception e){
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return result;
	}
	
	/**
	 * 新增套餐
	 * @param packageMain
	 * @return
	 */
	public int addPackageMain(ServletRequest request){
		Connection conn = null;
		try{
			
			conn = DBhelper.getConnection("tsdboss");
			
			conn.setAutoCommit(false);
			
			PackageMain packageMain = getPackageMain(request);
			
			int pid = packageMainDao.insert(packageMain, conn);
			
			//若套餐类型为标准自费或兜底
			String json1 = request.getParameter("json1");
			
			List<PackageRate> rateList = JSON.parseArray(json1, PackageRate.class); 
			
			//保存费率
			for(PackageRate packageRate : rateList){
				packageRate.setPid(pid);
				packageRateDao.insert(packageRate, conn);
			}
			
			//保存免费资源
			for(PackageRate packageRate : rateList){
				if(packageRate.getFreeResVolume() != 0){
					packageRate.setPid(pid);
					packageFreeResDao.insert(packageRate, conn);
				}
			}
			
			conn.commit();
		}catch(Exception e){
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return 1;
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}
	
	/**
	 * 修改套餐
	 * @param request
	 * @param response
	 * @return
	 */
	public int updatePackageMain(ServletRequest request){
		Connection conn = null;
		try{
			
			conn = DBhelper.getConnection("tsdboss");
			
			conn.setAutoCommit(false);
			
			PackageMain packageMain = getPackageMain(request);
			
			//删除旧的费率
			packageRateDao.deleteByPid(conn, packageMain.getId());
			
			//删除旧的免费资源
			packageFreeResDao.deleteByPid(conn, packageMain.getId());
			
			//修改套餐
			packageMainDao.update(conn, packageMain);
			
			//获取传入的费率
			String json1 = request.getParameter("json1");
			
			List<PackageRate> rateList = JSON.parseArray(json1, PackageRate.class); 
			
			for(PackageRate packageRate : rateList){
				packageRate.setPid(packageMain.getId());
				packageRateDao.insert(packageRate, conn);
			}
			
			//保存免费资源
			for(PackageRate packageRate : rateList){
				if(packageRate.getFreeResVolume() != 0){
					packageRate.setPid(packageMain.getId());
					packageFreeResDao.insert(packageRate, conn);
				}
			}
			
			conn.commit();
		}catch(Exception e){
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return 1;
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}
	
	/**
	 *  删除套餐
	 * @param id
	 * @return
	 */
	public int delPackageMain(ServletRequest request){
		Connection conn = null;
		try{
			
			conn = DBhelper.getConnection("tsdboss");
			
			conn.setAutoCommit(false);
			
			int packageMainId = Integer.parseInt(request.getParameter("id"));
			
			//删除旧的费率
			packageRateDao.deleteByPid(conn, packageMainId);
			
			//删除旧的免费资源
			packageFreeResDao.deleteByPid(conn, packageMainId);
		
			//删除套餐
			packageMainDao.delete(conn, packageMainId);
			
			conn.commit();
		}catch(Exception e){
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			return 1;
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return 0;
	}
	
	private PackageMain getPackageMain(ServletRequest request){
		int id = 0;
		String idStr = request.getParameter("keyId");
		if(idStr != null && !idStr.trim().equals("") && !idStr.trim().equals("null")){
			id = Integer.parseInt(idStr);
		}
		String packageName = request.getParameter("packageName");
		int packageType = Integer.valueOf(request.getParameter("packageType"));
		double packageFee = 0;
		String packageFeeStr = request.getParameter("packageFee");
		if(packageFeeStr != null && !packageFeeStr.trim().equals("") && !packageFeeStr.trim().equals("null")){
			packageFee = Double.parseDouble(packageFeeStr);
		}
		int packageStatus = Integer.valueOf(request.getParameter("packageStatus"));
		int pagFreeNum = 0;
		String pagFreeNumStr = request.getParameter("pagFreeNum");
		if(pagFreeNumStr != null && !pagFreeNumStr.trim().equals("") && !pagFreeNumStr.trim().equals("null")){
			pagFreeNum = Integer.parseInt(pagFreeNumStr);
		}
		int gid = 0;
		String gidStr = request.getParameter("gid");
		if(gidStr != null && !gidStr.trim().equals("") && !gidStr.trim().equals("null")){
			gid = Integer.parseInt(gidStr);
		}
		String remark = request.getParameter("remark");
		//int operator = Integer.valueOf(request.getParameter("operator"));
		int operator = 1;
		String serviceType = request.getParameter("serviceType");
		String subServiceType = request.getParameter("subServiceType");
		
		PackageMain packageMain = new PackageMain();
		packageMain.setId(id);
		packageMain.setPackageName(packageName);
		packageMain.setPackageType(packageType);
		packageMain.setPackageFee(packageFee);
		packageMain.setPackageStatus(packageStatus);
		packageMain.setPagFreeNum(pagFreeNum);
		packageMain.setGid(gid);
		packageMain.setRemark(remark);
		packageMain.setOperator(operator);
		packageMain.setServiceType(serviceType);
		packageMain.setSubServiceType(subServiceType);
		return packageMain;
	}
}
