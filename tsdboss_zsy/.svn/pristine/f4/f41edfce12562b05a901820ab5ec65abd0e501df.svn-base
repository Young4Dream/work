package com.tsd.service;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Pattern;

import com.tsd.entity.AttachfeeHthHz;
import com.tsd.entity.AttachfeeTemp;
import com.tsd.entity.Butieitem;
import com.tsd.entity.Bymx;
import com.tsd.entity.FreeGrade;
import com.tsd.entity.HfhzAttachfeeCfg;
import com.tsd.entity.HfhzLog;
import com.tsd.entity.HthdangHz;
import com.tsd.entity.HthhfHzTmp;
import com.tsd.entity.HuizongHf;
import com.tsd.entity.HuizongTmp;
import com.tsd.entity.JfglHfhzUseing;
import com.tsd.entity.KemuDef;
import com.tsd.entity.Mxmonth;
import com.tsd.entity.OtherDhedit;
import com.tsd.entity.Teljob;
import com.tsd.entity.YhdangHz;
import com.tsd.entity.Yhlb;
import com.tsd.entity.YwslDhGuoHu;
import com.tsd.service.util.DBUtil;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.Log;

/**
 * 汇总方法实现类
 * @author donglei 2015-10-22 
 *
 */
public class IHuiZongImpls implements IHuiZong {

	/** 数据库名称 **/ 
	private String ds;
	private String userId;
	
	public IHuiZongImpls(){
		
	}
	
	public IHuiZongImpls(String userId){
		this.userId = userId;
	}
	
	/**
	 * 获取数据库时间
	 */
	public Date getDbTime(){
		
		Connection conn = null;
		Date dbSysTime = null;
		
		try {
			
			conn = DBUtil.openConnection();
			
			List<Map<String, Object>> sysDateList = DBUtil.queryMapList(conn,"select sysdate from dual");
			dbSysTime = (Date) sysDateList.get(0).get("sysdate".toUpperCase());
			
		} catch (Exception e) {
			
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取数据库时间异常","hfhz",userId,"hfhz"), null);
			
		}finally{
				try {
					DBUtil.closeConnection(conn, null, null);
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		return dbSysTime; 
	}
	
	/**
	 * 检查是否有其他人正在汇总
	 * @param userId 用户id
	 * @param dataSourceName 
	 * @return boolean true:表示没有人占用  false:表示有人正在占用汇总程序
	 */
	public boolean checkUsing(String userId,Date dbSysTime) {
		
		//最大汇总时间
		Date maxHzTime = null;
		Connection conn = null;
		
		try {
			
			conn = DBUtil.openConnection();
			
			//获取汇总过程使用表最大汇总时间
			List<JfglHfhzUseing> maxHztimelist = DBUtil.queryBeanList(conn,"select max(HzTime) as HZTIME from Jfgl_HfhzUseing",JfglHfhzUseing.class);
			for (int i=0;i<maxHztimelist.size();i++){
				maxHzTime = maxHztimelist.get(i).getHzTime();
			}
			//如果没有最大汇总时间表示没人使用
			if (maxHzTime == null){
				Object[] params = new Object[]{userId};
				DBUtil.execute(conn,"insert into Jfgl_HfhzUseing(UserID,HzTime) values(?,sysdate)",params);
				return true;
			}
			//判断上次汇总时间与数据库当前时间如果大于15分钟,判断为汇总异常清除汇总使用表数据
			else if(dbSysTime.after(maxHzTime) && (dbSysTime.getTime()-maxHzTime.getTime())/1000/60 > 15){
				DBUtil.execute(conn,"truncate table Jfgl_HfhzUseing");
				Object[] params = new Object[]{userId};
				DBUtil.execute(conn,"insert into Jfgl_HfhzUseing(UserID,HzTime) values(?,sysdate)",params);
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("检查汇总程序是否闲置异常","hfhz",userId,"hfhz"), ds);
		} finally{
			  
				try {
					DBUtil.closeConnection(conn, null, null);
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return false;
	}

	/**
	 * 检查是否存在汇总的起止时间
	 * @param conn	数据库连接
	 * @param conn	汇总月份
	 * @return Mxmonth
	 */
	public Mxmonth checkStartAndEndTime(String hzyf) throws Exception{
		
		Connection conn = null;
		
		try {
			conn = DBUtil.openConnection();
		
			Object[] params = new Object[]{hzyf};
			return	DBUtil.queryBean(conn,"select month,begindate,enddate,to_char(begindate,'yyyy-mm-dd hh24:mi:ss') as sbegindate,"
					+ "to_char(enddate, 'yyyy-mm-dd hh24:mi:ss') as senddate,"
					+ "ENDDATE - BEGINDATE as days,"
					+ "TO_CHAR(BEGINDATE, 'yyyymmdd') || '-' ||TO_CHAR(ENDDATE, 'yyyymmdd') as hzqj "
					+ "from mxmonth where month=? and rownum<=1",Mxmonth.class,params);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("检查是否存在汇总的起止时间出现异常","hfhz",userId,"hfhz"), null);
			throw e;			
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
		
	}

	/**
	 * 清除90以前做拆机标志的电话 
	 * @param conn	数据库连接
	 */
	public void cleanDhByTag() throws Exception{
		
		Connection conn = null;
		
		try {
			conn = DBUtil.openConnection();
			
			/*中石油定制 办公用户电话拆机回收号源时只判断拆机日期，不判断余额，因为办公用户每月出帐，但没有销帐，所以余额一直不为0.
			办公用户通过合同号判断，不通过用户类型，FH开头合同号为私人用户，其他的为办公用户*/
//			DBUtil.execute(conn,"delete from yhdang where delbz='delete' and hth not like 'FH%' and trunc(SYSDATE)-trunc(nvl(DelDate,sysdate)) > 90");
			DBUtil.execute(conn,LoadProperties.getKeyValues("oracle_hz", "delete90dh"));
			
			List<Map<String, Object>> dhDeleteList = DBUtil.queryMapList(conn,"select dh,hth from yhdang where delbz='delete' and hth like 'FH%' AND trunc(SYSDATE)-trunc(nvl(DelDate,sysdate)) > 90");
			for (int i=0;i<dhDeleteList.size();i++){
				String dh = (String) dhDeleteList.get(i).get("DH".toUpperCase());
				String hth = (String) dhDeleteList.get(i).get("HTH".toUpperCase());
				
				if(dh.trim() != null && dh.trim().length()>0 && hth.trim() != null && hth.trim().length()>0){
				
					//更新需要回收的电话不是所在合同号下的最后一部电话的数据
					Object[] params = new Object[]{hth};
					int count = DBUtil.queryObject(conn,"select count(*) as count from yhdang where hth=?",Integer.class,params);
					//不是最后一部电话的，直接回收，不判断余额
					if(count > 1){
						params = new Object[]{dh};
						DBUtil.execute(conn,"DELETE from yhdang where dh=?",params);
					}
					//最后一部电话需要判断余额，余额为0时才能回收
					else{
						params = new Object[]{dh};
						DBUtil.execute(conn,"DELETE from yhdang where dh=? and hth in(select hth from hthhfadd where hfmax=0)",params);
					}
				}
			}
			//删除hthdang数据
			DBUtil.execute(conn,"delete from hthdang where lower(delbz)=lower('destroy') and hth in (select hth from hthhfadd where hfmax=0) and hth not in(select distinct hth from yhdang)");
			//改号用户原号保留两个月（改号月，下一个出帐月）。
			DBUtil.execute(conn,"delete from dh_change where changetime<last_day(trunc(sysdate, 'month')+interval '-2' month)+1-1/86400");
			
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("删除90天以前的拆机用户时异常","hfhz",userId,"hfhz"), null);
			throw e;			
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
		
	}
	
	/**
	 * 检查是否汇总工单费用配置
	 * @return boolean Y为汇总
	 */
	public boolean isTrue(String sql){
		
		Connection conn = null;
		
		try {
			conn = DBUtil.openConnection();
			List<Map<String,Object>> tvalueslist = DBUtil.queryMapList(conn,sql);
			String tvalues = (String) tvalueslist.get(0).get("TVALUES".toUpperCase());
					
			if ("Y".endsWith(tvalues)){
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("检查是否汇总工单费用配置异常","hfhz",userId,"hfhz"), ds);
		} finally{
			  
				try {
					DBUtil.closeConnection(conn, null, null);
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return false;
		
		
	}

	/**
	 * 获取属于停机标志组的数据
	 * @param conn
	 * @return List<String>
	 * @throws Exception
	 */
	public List<String> getTjbzGroupList() throws Exception{
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql="select tjbztype from tjbzgroup";
			List<String> tjbzlist= DBUtil.queryObjectList(conn, sql, String.class);
			return tjbzlist;
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取属于停机标志组的数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取用户类别配置表数据
	 * @param conn
	 * @return List<Yhlb>
	 * @throws Exception
	 */
	public List<Yhlb> getYhlbList() throws Exception{
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql="select id,yhlb from yhlb";
			return DBUtil.queryBeanList(conn, sql, Yhlb.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取用户类别配置表数据数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
		
	}
	
	/**
	 * 获取在汇总时间段的有效用户月租
	 * @param conn
	 * @param mxmonth
	 * @param timematch
	 * @param hthLimit
	 * @return List<AttachfeeTemp>
	 * @throws Exception
	 */
	public List<AttachfeeTemp> getAttachfeeTempList(Mxmonth mxmonth,
			String hthLimit,boolean timematch) throws Exception{
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sbegindate = mxmonth.getSbegindate();
			String enddate = mxmonth.getSenddate();
			String hzyf = mxmonth.getMonth();
			String sql = null;
			
			if(timematch){
				
				sql="select a.dh, a.dhid, a.feecode, a.feename, a.feetype, a.price, a.tjprice, a.qtprice,a.startmonth,a.endmonth, a.startdate,"
						+ "CASE WHEN NVL(y.delbz,'tsd')='delete' and y.deldate is not null THEN CASE WHEN y.deldate < a.enddate THEN y.deldate ELSE a.enddate END ELSE a.enddate END AS enddate,"
						+ "a.ifexec,a.devnum,a.devlength,a.Cunit "
						+ "FROM attachfee a,yhdang y "
						+ "where a.dhid=y.dhid and a.ifexec=0 AND (a.price<>0 OR tjprice<>0) "
								+ "and to_date('"+enddate+"', 'yyyy-mm-dd hh24:mi:ss')>=a.StartDate "
								+ "and a.EndDate>=to_date('"+sbegindate+"', 'yyyy-mm-dd hh24:mi:ss') ";
			}else{
				
					sql="select a.dh, a.dhid, a.feecode, a.feename, a.feetype, a.price, a.tjprice, a.qtprice,a.startmonth,a.endmonth, a.startdate,"
							+ "CASE WHEN NVL(y.delbz,'tsd')='delete' and y.deldate is not null THEN CASE WHEN y.deldate < a.enddate THEN y.deldate ELSE a.enddate END ELSE a.enddate END AS enddate,"
							+ "a.ifexec,a.devnum,a.devlength,a.Cunit "
							+ "FROM attachfee_billing a,yhdang_billing y "
							+ "where a.billingmonth="+hzyf+" and y.billingmonth="+hzyf+" "
									+ "and a.dhid=y.dhid and a.ifexec=0 AND (a.price<>0 OR tjprice<>0) "
									+ "and to_date('"+enddate+"', 'yyyy-mm-dd hh24:mi:ss')>=a.StartDate "
									+ "and a.EndDate>=to_date('"+sbegindate+"', 'yyyy-mm-dd hh24:mi:ss') ";
			}
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and y.hth in "+hthLimit;
			}
			
			return DBUtil.queryBeanList(conn,sql,AttachfeeTemp.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取在汇总时间段的有效用户月租时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}

	/**
	 * 获取合同号档数据
	 * @param conn
	 * @param hzyf
	 * @param timematch
	 * @param hthLimit
	 * @return List<HthdangHz>
	 * @throws Exception
	 */
	public List<HthdangHz> getHthdangHzList(String hzyf,
			String hthLimit, boolean timematch) throws Exception{
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql = null;
			
			if(timematch){
				
				sql="select hth, dh, yhmc, bm1, bm2, bm3, bm4, bmbh, yhxz, yhlb, sflx, area, "
						+ "yhdz, idcard,youbian, znjbz,delbz, deldate, hthmfjb, hthdjjb, djhth, "
						+ "callpaytype, dhsl, hthmima, bz1,bz2, bz3, bz4, bz5, bz6, bz7, bz8,bz9, "
						+ "bz10, id, custtype, creditgrade, boss_name,linktel, fixcode, tradetype, "
						+ "comptype, homepage, email,manageid,creditpoint from hthdang where 1=1 ";		
				
			}else{
				
				sql="select hth, dh, yhmc, bm1, bm2, bm3, bm4, bmbh, yhxz, yhlb, sflx, area, "
						+ "yhdz, idcard,youbian, znjbz,delbz, deldate, hthmfjb, hthdjjb, djhth, "
						+ "callpaytype, dhsl, hthmima, bz1,bz2, bz3, bz4, bz5, bz6, bz7, bz8,bz9, "
						+ "bz10, id, custtype, creditgrade, boss_name,linktel, fixcode, tradetype, "
						+ "comptype, homepage, email,manageid,creditpoint from hthdang_billing "	
						+ "where billingmonth="+hzyf+" ";
				
			}
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and hth in "+hthLimit;
			}
			
			return DBUtil.queryBeanList(conn,sql,HthdangHz.class);	
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取合同号档数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
		
	}
	
	/**
	 * 获取合同号月租数据
	 * @param conn
	 * @param mxmonth
	 * @param timematch
	 * @param hthLimit
	 * @return List<AttachfeeHthHz>
	 * @throws Exception	 * 
	 */
	public List<AttachfeeHthHz> getAttachfeeHthHzList(Mxmonth mxmonth,
			String hthLimit,boolean timematch) throws Exception {
		
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String hzyf = mxmonth.getMonth();
			int i_hzyf = Integer.parseInt(hzyf);
			String sql = null;
			
			if (timematch) {
				
				sql = "select hth,feecode,feename,feetype,feenum,price,startmonth,endmonth "+
			              "from attachfee_hth where startmonth<="+i_hzyf+" and endmonth>="+i_hzyf;
				
			}else {
				
				sql = "select hth,feecode,feename,feetype,feenum,price,startmonth,endmonth "+
						"from attachfee_hth_billing where billingmonth="+hzyf
						+" and startmonth<="+i_hzyf+" and endmonth>="+i_hzyf;
			}
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and hth in "+hthLimit;
			}
			

			return DBUtil.queryBeanList(conn,sql,AttachfeeHthHz.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取合同号月租数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}

	/**
	 * 获取月租生效规则配置数据
	 * @param conn
	 * @return List<HfhzAttachfeeCfg>
	 * @throws Exception	 * 
	 */
	public List<HfhzAttachfeeCfg> getHfhzAttachfeeCfgList()
			throws Exception {
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql = "select * from hfhz_attachfee_cfg order by xuhao";
			return DBUtil.queryBeanList(conn,sql,HfhzAttachfeeCfg.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取月租生效规则配置数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取汇总所需要的用户数据
	 * @param conn
	 * @param mxmonth
	 * @param timematch
	 * @param hthLimit
	 * @return List<HuizongTmp>
	 * @throws Exception
	 */
	public List<HuizongTmp> getHuizongTmpList(Mxmonth mxmonth,
			String hthLimit,boolean timematch) throws Exception{
		
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String hzyf = mxmonth.getMonth();
			String bgindate = mxmonth.getSbegindate();
			String enddate = mxmonth.getSenddate();
			String hzqj = mxmonth.getHzqj();
			String sql=null;
			
			if(timematch){
				
				sql = "select 'tmp' as kemu, "+hzyf+" as hzyf, sysdate as hzsj, '"+hzqj+"' as hzqx,(case when (nvl(tjbz,'k'))='QT' then 'QT' end) sflx,Hth,Dh,Yhmc,Bm1,Bm2,Bm3,Bm4,Bmbh,Tjbz,TjDate,DhID,Zlh,"
						+ "Mfjb,Reg_Date,StartDate,(case when (nvl(DelBz,'tsd'))='delete' then deldate else EndDate end) EndDate,"
						+ "mokuaiju,usertype,fjdate,ywarea as area from Yhdang "
						+ "where to_date('"+enddate+"','yyyy-mm-dd hh24:mi:ss')>=StartDate and EndDate>=to_date('"+bgindate+"','yyyy-mm-dd hh24:mi:ss') "
						+ "and (nvl(DelBz,'tsd') <>'delete' or to_number(to_char(DelDate,'yyyymm'))>="+Integer.parseInt(hzyf)+") ";
			}else{
				
				sql = "select 'tmp' as kemu, "+hzyf+" as hzyf, sysdate as hzsj, '"+hzqj+"' as hzqx,(case when (nvl(tjbz,'k'))='QT' then 'QT' end) sflx,Hth,Dh,Yhmc,Bm1,Bm2,Bm3,Bm4,Bmbh,Tjbz,TjDate,DhID,Zlh,"
						+ "Mfjb,Reg_Date,StartDate,(case when (nvl(DelBz,'tsd'))='delete' then deldate else EndDate end) EndDate,"
						+ "mokuaiju,usertype,fjdate ,ywarea as area from Yhdang_billing "
						+ "where billingmonth="+hzyf+" "
						+ "and to_date('"+enddate+"','yyyy-mm-dd hh24:mi:ss')>=StartDate and EndDate>=to_date('"+bgindate+"','yyyy-mm-dd hh24:mi:ss') "
						+ "and (nvl(DelBz,'tsd') <>'delete' or to_number(to_char(DelDate,'yyyymm'))>="+Integer.parseInt(hzyf)+") ";
			}
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and hth in "+hthLimit;
			}
			
			return DBUtil.queryBeanList(conn,sql,HuizongTmp.class);
			
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取汇总所需要的用户数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取当月完工的工单表数据
	 * @param conn
	 * @param hzyf
	 * @return List<Teljob>
	 * @throws Exception	 
	 */
	public List<Teljob> getTeljobList (String hzyf,String hthLimit) throws Exception {

		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql = "SELECT xdh,sum(yjfee) as yjfee,sum(zjfee) as zjfee,sum(gjfee) as gjfee FROM teljob  "
					+ "WHERE to_char(wgrq,'yyyymm')="+hzyf+" and lower(iscomplete)='y' and ifcancel=0 "
					+ "AND (yjfee<>0 OR zjfee<>0 OR gjfee<>0)";
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and hth in "+hthLimit;
			}		
			sql +=" group by xdh";
			
			return DBUtil.queryBeanList(conn, sql, Teljob.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取当月完工的工单表数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取减免项目定义表数据
	 * @param conn
	 * @return List<Butieitem>
	 * @throws Exception
	 */
	public List<Butieitem> getbutieitemList() throws Exception {
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql  = "SELECT * FROM ButieItem";
			return DBUtil.queryBeanList(conn, sql, Butieitem.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取减免项目定义表数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取减免类别表数据
	 * @param conn
	 * @return List<FreeGrade>
	 * @throws Exception
	 */
	public List<FreeGrade> getfreeGradeList () throws Exception {
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql  = "SELECT * FROM Free_Grade";
			return DBUtil.queryBeanList(conn, sql, FreeGrade.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取减免类别表数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取上个月汇总用的补贴结余
	 * @param conn
	 * @param hzyf
	 * @param hthLimit
	 * @return List<HuizongTmp>
	 * @throws Exception
	 */
	public List<HuizongTmp> gethuizongPreList (int prehzyf,String hthLimit) throws Exception {
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql = "select dh,dhid,btjy,btjy1,btjy2,btjy3,btjy4,btjy5,btjy6,btjy7,btjy8,btjy9,btjy10 "
					+ "from huizong where hzyf="+prehzyf;
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and hth in "+hthLimit;
			}
			
			return DBUtil.queryBeanList(conn,sql,HuizongTmp.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取上个月汇总用的补贴结余时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取上个月合同号汇总表用的补贴结余
	 * @param conn
	 * @param prehzyf
	 * @param hthLimit
	 * @return List<HthhfHzTmp>
	 * @throws Exception
	 */
	public List<HthhfHzTmp> geththhfHzPreList (int prehzyf,String hthLimit) throws Exception {
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql = "select hth,dh,btjy,btjy1,btjy2,btjy3,btjy4,btjy5,btjy6,btjy7,btjy8,btjy9,btjy10 "
					+ "from hthhf where hzyf="+prehzyf;
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and hth in "+hthLimit;
			}
			
			return DBUtil.queryBeanList(conn,sql,HthhfHzTmp.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取上个月合同号汇总表用的补贴结余时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}	
	
	
	/**
	 * 获取汇总表中前期已经汇总完成的话费
	 * @param conn
	 * @param hzyf
	 * @return List<HuizongHf>
	 * @throws Exception
	 */
	public List<HuizongHf> getHuizongHfList(String hzyf,String hthLimit,boolean monthMatch) throws Exception {
		Connection conn = null;
		
		try {
			conn = DBUtil.openConnection();
			String sql = null;
			
			if(monthMatch){
				sql = "select * from huizong_hf h where h.hzyf="+hzyf;
			}else{
				sql = " select h.hzyf as hzyf,h.hzsj as hzsj ,h.hth as hth, h.dh as dh,h.kemu as kemu,y.dhid as dhid,"
						+ "h.zlh as zlh,h.yhxz as yhxz,h.sflx as sflx, h.hc1 as hc1,h.hc2 as hc2,h.hc3 as hc3,h.hc4 as hc4 ,"
						+ "h.hc5 as hc5 ,h.hc6 as hc6 ,h.hc7 as hc7 ,h.hc8 as hc8 ,h.hc9 as hc9,h.hc10 as hc10,h.hc11 as hc11,"
						+ "h.hc12 as hc12,h.hc13 as hc13,h.hc14 as hc14 ,h.hc15 as hc15,h.hc16 as hc16,h.hc17 as hc17,h.hc18 as hc18,"
						+ "h.hc19 as hc19,h.hc20 as hc20,h.hc21 as hc21,h.hc22 as hc22,h.hc23 as hc23,h.hc24 as hc24,h.hc25 as hc25,"
						+ "h.hc26 as hc26,h.hc27 as hc27,h.hc28 as hc28,h.hc29 as hc29,h.hc30 as hc30,h.hc31 as hc31,h.hc32 as hc32,"
						+ "h.hc33 as hc33,h.hc34 as hc34,h.hc35 as hc35,h.hc36 as hc36,h.hc37 as hc37,h.hc38 as hc38,h.hc39 as hc39,"
						+ "h.hc40 as hc40,h.hf1 as hf1,h.hf2 as hf2,h.hf3 as hf3,h.hf4 as hf4,h.hf5 as hf5,h.hf6 as hf6,h.hf7 as hf7,"
						+ "h.hf8 as hf8,h.hf9 as hf9 ,h.hf10 as hf10,h.hf11 as hf11,h.hf12 as hf12,h.hf13 as hf13,h.hf14 as hf14,"
						+ "h.hf15 as hf15,h.hf16 as hf16,h.hf17 as hf17,h.hf18 as hf18,h.hf19 as hf19,h.hf20 as hf20,h.hf21 as hf21,"
						+ "h.hf22 as hf22,h.hf23 as hf23,h.hf24 as hf24,h.hf25 as hf25,h.hf26 as hf26,h.hf27 as hf27,h.hf28 as hf28,"
						+ "h.hf29 as hf29,h.hf30 as hf30,h.hf31 as hf31,h.hf32 as hf32,h.hf33 as hf33,h.hf34 as hf34,h.hf35 as hf35,"
						+ "h.hf36 as hf36,h.hf37 as hf37,h.hf38 as hf38,h.hf39 as hf39,h.hf40 as hf40,h.fjf as fjf,h.fuf as fuf,h.hf as hf,h.heji as heji "
						+ "from huizong_hf h,yhdang_billing y where y.dh=h.dh and y.billingmonth=h.hzyf and y.billingmonth="+hzyf;
			}
			
			if (hthLimit != null && hthLimit.length()>0 ){	
				sql += " and h.hth in "+hthLimit;
			}
			
			return DBUtil.queryBeanList(conn, sql, HuizongHf.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取汇总表中前期已经汇总完成的话费时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	
	/**
	 * 汇总用户月租数据
	 * @param mxmonth			汇总月份
	 * @param hthLimit			合同号或者用户类型
	 * @param huizongTmplist	汇总所需的用户档数据
	 * @param attachfeeTemplist	汇总所需的用户月租数据
	 * @param hfhzattachfeecfglist 汇总月租规则配置数据
	 * @param hthdangHzMap		合同号档数据
	 * @param tjbzlist			停机标示所属类型
	 * @param yhlblist			用户类别数据
	 * @param conn				数据库连接
	 * @return Map<Object,HuizongTmp>
	 */
	public Map<Object,HuizongTmp> hzUserAttachFee(Mxmonth mxmonth,
			Map<Object,HuizongTmp> huizongTmpMap, List<AttachfeeTemp> attachfeeTemplist,
			List<HfhzAttachfeeCfg> hfhzattachfeecfglist,Map<Object,HthdangHz> hthdangHzMap,
			List<String> tjbzlist,Map<Object,Yhlb> yhlbmap,Date dbSysTime) throws Exception{
		// 如果月租信息为空，则直接返回
		if(attachfeeTemplist == null || attachfeeTemplist.size() <=0){
			return huizongTmpMap;
		}
		
		SimpleDateFormat yyyyMM = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat dd = new SimpleDateFormat("dd");
		//汇总开始时间
		Date v_sStartTime = mxmonth.getBegindate();
		//汇总结束时间
		Date v_sEndTime = mxmonth.getEnddate();
		//汇总月份
		String v_sHZYF = mxmonth.getMonth();
		//汇总月份总天数
		int v_days= Integer.parseInt(mxmonth.getDays());
		//汇总月份（数字类型）
		int v_iHZYF = Integer.parseInt(v_sHZYF);
		//数据库系统时间(日)
		int i_dbsystime_dd = Integer.parseInt(dd.format(dbSysTime));
		
		for (int i=0 ; i<attachfeeTemplist.size(); i++){
			
				AttachfeeTemp attachFee = attachfeeTemplist.get(i);
				HuizongTmp huizongtmp = huizongTmpMap.get(attachFee.getDh());
				//月租费用代码
				int afeecode = attachFee.getFeecode();
				// 月租表中电话
				String dh = attachFee.getDh();
				//月租表中电话id
				int adhid = attachFee.getDhid();
				//月租开始时间
				Date astartdate = attachFee.getStartdate();
				if(astartdate == null){
					continue;
				}
				int i_astartdate = Integer.parseInt(yyyyMM.format(astartdate));
				int i_astartdate_dd = Integer.parseInt(dd.format(astartdate));
				//月租结束时间
				Date aenddate = attachFee.getEnddate();
				if(aenddate == null){
					continue;
				}
				int i_aenddate = Integer.parseInt(yyyyMM.format(aenddate));
				int i_aenddate_dd = Integer.parseInt(dd.format(aenddate));
				//月租、停机月租、欠停月租 
				Double aprice = attachFee.getPrice();
				Double atjprice = attachFee.getTjprice();
				Double aqtprice = attachFee.getQtprice();
				int devnum = attachFee.getDevnum();
				int cunit = attachFee.getCunit();
				Double devlength = attachFee.getDevlength();
				
				//初始化临时变量price
				Double price = 0.0;
				if (huizongTmpMap.containsKey(dh) && huizongtmp.getDhid()==adhid){
					
					//用户档用户开始计费时间
					Date hstartdate = huizongtmp.getStartdate();
					int i_hstartdate = 0;
					int i_hstartdate_dd = 0;
					if (hstartdate != null) {
						i_hstartdate = Integer.parseInt(yyyyMM.format(hstartdate));
						i_hstartdate_dd = Integer.parseInt(dd.format(hstartdate));
					}
					//用户档用户结束计费时间 
					Date henddate = huizongtmp.getEnddate();
					int i_henddate = 0;
					int i_henddate_dd = 0;
					if(henddate != null){
						i_henddate = Integer.parseInt(yyyyMM.format(henddate));
						i_henddate_dd = Integer.parseInt(dd.format(henddate));
					}
					//用户档停机保号时间
					Date htjdate = huizongtmp.getTjdate();
					int i_htjdate = 0;
					int i_htjdate_dd = 0;
					if(htjdate != null){
						i_htjdate = Integer.parseInt(yyyyMM.format(htjdate));
						i_htjdate_dd = Integer.parseInt(dd.format(htjdate));
					}
					//用户档停机保号复机时间
					Date hfjdate = huizongtmp.getFjdate();
					int i_hfjdate = 0;
					int i_hfjdate_dd = 0;
					if(hfjdate != null){
						i_hfjdate = Integer.parseInt(yyyyMM.format(hfjdate));
						i_hfjdate_dd = Integer.parseInt(dd.format(hfjdate));
					}					
					
					//根据停机标志更新用户收费类型
					String tjbz = huizongtmp.getTjbz();
					if(tjbzlist.contains(tjbz)){
						huizongtmp.setSflx("T");
					}
					if("QT".equals(tjbz)){
						huizongtmp.setSflx("QT");
					}
					if("K".equals(tjbz)){
						huizongtmp.setSflx("K");
					}
					if("DEFAUL".equals(tjbz)){
						huizongtmp.setSflx("DEFAUL");
					}
					String sflx = huizongtmp.getSflx();
					//用户档合同号用户类型
					String hth = huizongtmp.getHth();
					
					if(yhlbmap != null && !yhlbmap.isEmpty() && hthdangHzMap.containsKey(hth) && yhlbmap.containsKey(hthdangHzMap.get(hth).getYhlb()) ){
						huizongtmp.setZlh(yhlbmap.get(hthdangHzMap.get(hth).getYhlb()).getId()+"");
					}
					String zlh = huizongtmp.getZlh();
					
						for (int j = 0; j < hfhzattachfeecfglist.size(); j++){
							
							//月租汇总配置表中月租类型
							String busitype = hfhzattachfeecfglist.get(j).getBusitype();
							//月租费用代码
							int cfeecode = hfhzattachfeecfglist.get(j).getFeecode();
							//月租汇总作用域开始的当月天数
							int cday_from =  hfhzattachfeecfglist.get(j).getDay_From();
							//月租汇总作用域结束的当月天数
							int cday_end =  hfhzattachfeecfglist.get(j).getDay_End();
							//月租配置表中用户类型
							String sql1 = hfhzattachfeecfglist.get(j).getSql1();
							if(sql1 != null){
								sql1 = sql1.trim();
							}
							//月租收取方式的百分率
							Double rate = hfhzattachfeecfglist.get(j).getRate();
							Double faciend = Math.ceil(devnum/cunit*devlength)*(rate/100);
							
							String columns = "zfs";
							Field f = null;
							/*处理using 按月*/
							if("using".equalsIgnoreCase(busitype) 
									&& (cfeecode == afeecode || cfeecode == 0) 
									&& cday_end == 0 
									&& i_astartdate < v_iHZYF && i_aenddate > v_iHZYF
									&& i_hstartdate != 0 && i_henddate != 0
									&& (i_hstartdate != v_iHZYF && i_henddate != v_iHZYF ) ){
									
								    if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh)) ){
											
										if("QT".equals(sflx)){
											price = aqtprice*faciend;
										}else if("T".equals(sflx)){
											price = atjprice*faciend;
										}else if ("K".equals(sflx)){
											price = aprice*faciend;
										}
										
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,Double.parseDouble(String.valueOf(f.get(huizongtmp)))+new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
							}
							
							/*处理current 按月*/
							if("current".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end == 0 
									&& i_hstartdate != 0 && i_henddate != 0
									&& ( i_astartdate == v_iHZYF || i_aenddate == v_iHZYF )
									&& (i_hstartdate != v_iHZYF && i_henddate != v_iHZYF ) ){
									
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh)) ){
										
										if("QT".equals(sflx)){
											price = aqtprice*faciend;
										}else if("T".equals(sflx)){
											price = atjprice*faciend;
										}else if ("K".equals(sflx)){
											price = aprice*faciend;
										}
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,Double.parseDouble(String.valueOf(f.get(huizongtmp)))+new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
							}
							
							/*处理current 按日*/	
							if("current".equalsIgnoreCase(busitype) 
									&& (cfeecode==afeecode || cfeecode==0)
									&& cday_end != 0
									&& i_hstartdate != 0 && i_henddate != 0
									&& ( i_astartdate == v_iHZYF || i_aenddate == v_iHZYF )
									&& (i_hstartdate != v_iHZYF && i_henddate != v_iHZYF )  
									&& ((i_astartdate_dd >= cday_from && i_astartdate_dd <= cday_end) ||(i_aenddate_dd >= cday_from && i_aenddate_dd <= cday_end)) ){
								
								
								int pricedays = 0;
								//在汇总月下面 即上月前装机当月拆机
								if(v_sStartTime.after(astartdate) && !v_sStartTime.after(aenddate) && !v_sEndTime.before(aenddate)){
									
									if(dbSysTime.after(aenddate)){
										pricedays = i_aenddate_dd;
									}else{
										pricedays = i_dbsystime_dd;
									}
								
								}
								//在汇总月上面 即当月装机当月未拆机
								else if(!v_sStartTime.after(astartdate) && v_sEndTime.before(aenddate) && v_sEndTime.after(astartdate)){
									
									if(dbSysTime.after(v_sEndTime)){
										 long diff = v_sEndTime.getTime()-astartdate.getTime();
										 pricedays = (int) (diff/(1000 * 60 * 60 * 24));
									}else{
										long diff = dbSysTime.getTime()-astartdate.getTime();
										pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
									}
									
								}
								//在汇总月中间 即当月装机当月拆机
								else if(!v_sStartTime.after(astartdate) && v_sEndTime.after(aenddate)){
									
									if(dbSysTime.after(aenddate)){
										long diff = aenddate.getTime()-astartdate.getTime();
										pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
									}else{
										long diff = dbSysTime.getTime()-astartdate.getTime();
										pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
									}
								}
								
								if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
									
									if("QT".equals(sflx)){
										price = aqtprice*faciend*pricedays/v_days;
									}else if("T".equals(sflx)){
										price = atjprice*faciend*pricedays/v_days;
									}else if ("K".equals(sflx)){
										price = aprice*faciend*pricedays/v_days;
									}
									columns  += afeecode;
									f = HuizongTmp.class.getDeclaredField(columns);
									f.setAccessible(true);
									f.set(huizongtmp,Double.parseDouble(String.valueOf(f.get(huizongtmp)))+new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
								}
							}
							
							/*处理stop 按月*/
							if("stop".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end == 0 
									&& "T".equals(huizongtmp.getSflx())
									&& i_htjdate == v_iHZYF ){
									
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
										price = atjprice*faciend;
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
							}
							/*处理stop 按日*/
							if("stop".equalsIgnoreCase(busitype) 
									&& (cfeecode==afeecode || cfeecode==0)
									&& cday_end != 0
									&& "T".equals(huizongtmp.getSflx())
									&& i_htjdate == v_iHZYF  
									&& (i_htjdate_dd >= cday_from && i_htjdate_dd <= cday_end) ){

									int pricedays = 0;
									//在汇总月下面 即上月前装机当月拆机
									if(v_sStartTime.after(astartdate) && !v_sStartTime.after(aenddate) && !v_sEndTime.before(aenddate)){
										
										if(dbSysTime.after(aenddate)){
											pricedays = i_aenddate_dd;
										}else{
											pricedays = i_dbsystime_dd;
										}
									
									}
									//在汇总月上面 即当月装机当月未拆机
									else if(!v_sStartTime.after(astartdate) && v_sEndTime.before(aenddate) && v_sEndTime.after(astartdate)){
										
										if(dbSysTime.after(v_sEndTime)){
											 long diff = v_sEndTime.getTime()-astartdate.getTime();
											 pricedays = (int) (diff/(1000 * 60 * 60 * 24));
										}else{
											long diff = dbSysTime.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}
										
									}
									//在汇总月中间 即当月装机当月拆机
									else if(!v_sStartTime.after(astartdate) && v_sEndTime.after(aenddate)){
										
										if(dbSysTime.after(aenddate)){
											long diff = aenddate.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}else{
											long diff = dbSysTime.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}
									}
									
									
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
										price = atjprice*faciend*pricedays/v_days;
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
								}
							
							/*处理restore 按月*/
							if("restore".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end == 0 
									&& "K".equals(huizongtmp.getSflx())
									&& i_hfjdate == v_iHZYF 
									&& ( i_astartdate == v_iHZYF || i_aenddate == v_iHZYF )
									&& (i_hstartdate != v_iHZYF && i_henddate != v_iHZYF ) ){
									
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
										price = aprice*faciend;
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
							}							
							/*处理restore 按日*/
							if("restore".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end != 0 
									&& "K".equals(huizongtmp.getSflx())
									&& i_hfjdate == v_iHZYF 
									&& ( i_astartdate == v_iHZYF || i_aenddate == v_iHZYF )
									&& (i_hstartdate != v_iHZYF && i_henddate != v_iHZYF ) 
									&& (i_hfjdate_dd >= cday_from && i_hfjdate_dd <= cday_end)){
								
								int pricedays = 0;
								//在汇总月下面 即上月前装机当月拆机
								if(v_sStartTime.after(astartdate) && !v_sStartTime.after(aenddate) && !v_sEndTime.before(aenddate)){
									
									if(dbSysTime.after(aenddate)){
										pricedays = i_aenddate_dd;
									}else{
										pricedays = i_dbsystime_dd;
									}
								
								}
								//在汇总月上面 即当月装机当月未拆机
								else if(!v_sStartTime.after(astartdate) && v_sEndTime.before(aenddate) && v_sEndTime.after(astartdate)){
									
									if(dbSysTime.after(v_sEndTime)){
										 long diff = v_sEndTime.getTime()-astartdate.getTime();
										 pricedays = (int) (diff/(1000 * 60 * 60 * 24));
									}else{
										long diff = dbSysTime.getTime()-astartdate.getTime();
										pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
									}
									
								}
								//在汇总月中间 即当月装机当月拆机
								else if(!v_sStartTime.after(astartdate) && v_sEndTime.after(aenddate)){
									
									if(dbSysTime.after(aenddate)){
										long diff = aenddate.getTime()-astartdate.getTime();
										pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
									}else{
										long diff = dbSysTime.getTime()-astartdate.getTime();
										pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
									}
								}		
								
								if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
									price = aprice*faciend*pricedays/v_days;
									columns  += afeecode;
									f = HuizongTmp.class.getDeclaredField(columns);
									f.setAccessible(true);
									f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
								}
								
							}							
							
							/*处理setup 按月*/
							if("setup".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end == 0 
									&& i_hstartdate == v_iHZYF ){
										
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
										
										if("QT".equals(sflx)){
											price = aqtprice*faciend;
										}else if("T".equals(sflx)){
											price = atjprice*faciend;
										}else if ("K".equals(sflx)){
											price = aprice*faciend;
										}
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
							}
							/*处理setup 按日*/
							if("setup".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end != 0
									&& "K".equals(sflx)
									&& i_hstartdate == v_iHZYF 
									&& i_hstartdate_dd >= cday_from && i_hstartdate_dd <= cday_end){
								
									int pricedays = 0;
									//在汇总月下面 即上月前装机当月拆机
									if(v_sStartTime.after(astartdate) && !v_sStartTime.after(aenddate) && !v_sEndTime.before(aenddate)){
										
										if(dbSysTime.after(aenddate)){
											pricedays = i_aenddate_dd;
										}else{
											pricedays = i_dbsystime_dd;
										}
									
									}
									//在汇总月上面 即当月装机当月未拆机
									else if(!v_sStartTime.after(astartdate) && v_sEndTime.before(aenddate) && v_sEndTime.after(astartdate)){
										
										if(dbSysTime.after(v_sEndTime)){
											 long diff = v_sEndTime.getTime()-astartdate.getTime();
											 pricedays = (int) (diff/(1000 * 60 * 60 * 24));
										}else{
											long diff = dbSysTime.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}
										
									}
									//在汇总月中间 即当月装机当月拆机
									else if(!v_sStartTime.after(astartdate) && v_sEndTime.after(aenddate)){
										
										if(dbSysTime.after(aenddate)){
											long diff = aenddate.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}else{
											long diff = dbSysTime.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}
									}	
									
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
											price = aprice*faciend*pricedays/v_days;
											columns += afeecode;
											f = HuizongTmp.class.getDeclaredField(columns);
											f.setAccessible(true);
											f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}	
								}								
								
							/*处理delete 按月*/
							if("delete".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end == 0 
									&& i_henddate == v_iHZYF ){
									
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
										
										if("QT".equals(sflx)){
											price = aqtprice*faciend;
										}else if("T".equals(sflx)){
											price = atjprice*faciend;
										}else if ("K".equals(sflx)){
											price = aprice*faciend;
										}
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
							}
							/*处理delete 按日*/
							if("delete".equalsIgnoreCase(busitype) 
									&& ( cfeecode == afeecode || cfeecode == 0 )
									&& cday_end != 0 
									&& i_henddate == v_iHZYF 
									&& i_henddate == v_iHZYF 
									&& (i_henddate_dd >= cday_from && i_hstartdate_dd <= cday_end) ){
								
									int pricedays = 0; 
									//在汇总月下面 即上月前装机当月拆机
									if(v_sStartTime.after(astartdate) && !v_sStartTime.after(aenddate) && !v_sEndTime.before(aenddate)){
										 
										if(dbSysTime.after(aenddate)){
											pricedays = i_aenddate_dd;
										}else{
											pricedays = i_dbsystime_dd;
										}
									
									}
									//在汇总月上面 即当月装机当月未拆机
									else if(!v_sStartTime.after(astartdate) && v_sEndTime.before(aenddate) && v_sEndTime.after(astartdate)){
										
										if(dbSysTime.after(v_sEndTime)){
											 long diff = v_sEndTime.getTime()-astartdate.getTime();
											 pricedays = (int) (diff/(1000 * 60 * 60 * 24));
										}else{
											long diff = dbSysTime.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}
										
									}
									//在汇总月中间 即当月装机当月拆机
									else if(!v_sStartTime.after(astartdate) && v_sEndTime.after(aenddate)){
										
										if(dbSysTime.after(aenddate)){
											long diff = aenddate.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}else{
											long diff = dbSysTime.getTime()-astartdate.getTime();
											pricedays = (int) (diff/(1000 * 60 * 60 * 24))+1;
										}
									}		
									
									if (sql1 == null || "".equals(sql1) || (zlh != null && zlh.length()>0 && sql1.endsWith(zlh))){
										
										if("QT".equals(sflx)){
											price = aqtprice*faciend*pricedays/v_days;
										}else if("T".equals(sflx)){
											price = atjprice*faciend*pricedays/v_days;
										}else if ("K".equals(sflx)){
											price = aprice*faciend*pricedays/v_days;
										}
										columns  += afeecode;
										f = HuizongTmp.class.getDeclaredField(columns);
										f.setAccessible(true);
										f.set(huizongtmp,new BigDecimal(price).setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue());
									}
							}							
							
						}
						
				}
				
		}
		//判断如果当月是否存在合同号月租 

		
		return huizongTmpMap;
	}
	
	/**
	 * 汇总合同号月租数据
	 * @param huizongTmpMap
	 * @param attachfeehthhzlist
	 * @param hthdangHzMap
	 * @throws Exception
	 */
	public Map<Object,HuizongTmp> hzHthAttachFee(Map<Object,HuizongTmp> huizongTmpMap, 
			List<AttachfeeHthHz> attachfeehthhzlist,Map<Object,HthdangHz> hthdangHzMap) throws Exception{
		
		if(attachfeehthhzlist != null && attachfeehthhzlist.size() > 0){
			
			for( int i = 0; i<attachfeehthhzlist.size(); i++){
				
				String hth = attachfeehthhzlist.get(i).getHth();
				int feecode = attachfeehthhzlist.get(i).getFeecode();
				Double Price = attachfeehthhzlist.get(i).getPrice();
				int FeeNum = attachfeehthhzlist.get(i).getFeenum();
				
				if (hth != null && hth.length()>0 && hthdangHzMap.containsKey(hth) && huizongTmpMap.containsKey(hthdangHzMap.get(hth).getDh())){
					String dh = hthdangHzMap.get(hth).getDh();
					HuizongTmp huizongTmp = huizongTmpMap.get(dh);
					//设置合同号话费
					String hthzfs = "hthzfs"+feecode;
					Field f_hthzfs = HuizongTmp.class.getDeclaredField(hthzfs);
					f_hthzfs.setAccessible(true);
					Double oldzfs = (Double) f_hthzfs.get(huizongTmp);
					f_hthzfs.set(huizongTmp,oldzfs+(Price*FeeNum));
					//设置合同号话次
					String hthzfc = "hthzfc"+feecode;
					Field f_hthzfc = HuizongTmp.class.getDeclaredField(hthzfc);
					f_hthzfc.setAccessible(true);
					int oldzfc = (Integer) f_hthzfc.get(huizongTmp);
					f_hthzfc.set(huizongTmp,(oldzfc+FeeNum));				
					huizongTmpMap.put(dh, huizongTmp);
				}
			}
		}
		
		return huizongTmpMap;
	}
	
	/**
	 * 汇总用户工单表装、移、购机费用(中石油项目定制)
	 * @param huizongTmpMap
	 * @param teljobList
	 * @return
	 * @throws Exception
	 */
	public Map<Object,HuizongTmp> hzUserTeljobFee(Map<Object,HuizongTmp> huizongTmpMap,List<Teljob> teljobList) throws Exception{
		
		if (teljobList != null && teljobList.size()>0){
			
			for (int i = 0; i < teljobList.size(); i++){
				
				String dh = teljobList.get(i).getXdh();
				
				BigDecimal zjfee = new BigDecimal(teljobList.get(i).getZjfee());
				BigDecimal yjfee = new BigDecimal(teljobList.get(i).getYjfee());
				BigDecimal gjfee = new BigDecimal(teljobList.get(i).getGjfee());
				
				if(huizongTmpMap.containsKey(dh)){
					HuizongTmp huizongTmp = huizongTmpMap.get(dh);
					
					if(yjfee.doubleValue() > 0){
						huizongTmp.setHf11(new BigDecimal(huizongTmp.getHf11()).add(yjfee).doubleValue());
					}
					if(zjfee.doubleValue() > 0){
						huizongTmp.setHf13(new BigDecimal(huizongTmp.getHf13()).add(zjfee).doubleValue());
					}
					if(gjfee.doubleValue() > 0){
						huizongTmp.setHf14(new BigDecimal(huizongTmp.getHf14()).add(gjfee).doubleValue());
					}
					huizongTmpMap.put(dh, huizongTmp);
				}
			}
		}
		
		return huizongTmpMap;
	}
	
	/**
	 * 汇总用户话费
	 * @param huizongTmpMap
	 * @param huizongHfList
	 * @return Map<Object,HuizongTmp>
	 * @throws Exception
	 */	
	public  Map<Object,HuizongTmp> hzUserHF(List<HuizongHf> huizongHfList,Map<Object,HuizongTmp> huizongTmpMap){
			
			if(huizongHfList == null || huizongHfList.size() <= 0){
				return huizongTmpMap;
			}
			
			for(int i = 0; i< huizongHfList.size(); i++){
				
				HuizongHf huizongHf = huizongHfList.get(i);
				String dh = huizongHf.getDh();
				int dhid = huizongHf.getDhid();
				
				if (huizongTmpMap.containsKey(dh) && huizongTmpMap.get(dh).getDhid() == dhid) {
					HuizongTmp huizongTmp = huizongTmpMap.get(dh);
					
					huizongTmp.setFjf(huizongHf.getFjf());
					huizongTmp.setFuf(huizongHf.getFuf());
					
					//更新hc
					huizongTmp.setHc1(huizongHf.getHc1());
					huizongTmp.setHc2(huizongHf.getHc2());
					huizongTmp.setHc3(huizongHf.getHc3());
					huizongTmp.setHc4(huizongHf.getHc4());
					huizongTmp.setHc5(huizongHf.getHc5());
					huizongTmp.setHc6(huizongHf.getHc6());
					huizongTmp.setHc7(huizongHf.getHc7());
					huizongTmp.setHc8(huizongHf.getHc8());
					huizongTmp.setHc9(huizongHf.getHc9());
					huizongTmp.setHc10(huizongHf.getHc10());
					huizongTmp.setHc11(huizongHf.getHc11());
					huizongTmp.setHc12(huizongHf.getHc12());
					huizongTmp.setHc13(huizongHf.getHc13());
					huizongTmp.setHc14(huizongHf.getHc14());
					huizongTmp.setHc15(huizongHf.getHc15());
					huizongTmp.setHc16(huizongHf.getHc16());
					huizongTmp.setHc17(huizongHf.getHc17());
					huizongTmp.setHc18(huizongHf.getHc18());
					huizongTmp.setHc19(huizongHf.getHc19());
					huizongTmp.setHc20(huizongHf.getHc20());
					huizongTmp.setHc21(huizongHf.getHc21());
					huizongTmp.setHc22(huizongHf.getHc22());
					huizongTmp.setHc23(huizongHf.getHc23());
					huizongTmp.setHc24(huizongHf.getHc24());
					huizongTmp.setHc25(huizongHf.getHc25());
					huizongTmp.setHc26(huizongHf.getHc26());
					huizongTmp.setHc27(huizongHf.getHc27());
					huizongTmp.setHc28(huizongHf.getHc28());
					huizongTmp.setHc29(huizongHf.getHc29());
					huizongTmp.setHc30(huizongHf.getHc30());
					huizongTmp.setHc31(huizongHf.getHc31());
					huizongTmp.setHc32(huizongHf.getHc32());
					huizongTmp.setHc33(huizongHf.getHc33());
					huizongTmp.setHc34(huizongHf.getHc34());
					huizongTmp.setHc35(huizongHf.getHc35());
					huizongTmp.setHc36(huizongHf.getHc36());
					huizongTmp.setHc37(huizongHf.getHc37());
					huizongTmp.setHc38(huizongHf.getHc38());
					huizongTmp.setHc39(huizongHf.getHc39());
					huizongTmp.setHc40(huizongHf.getHc40());
					//更新hf1-40
					huizongTmp.setHf1(huizongHf.getHf1());
					huizongTmp.setHf2(huizongHf.getHf2());
					huizongTmp.setHf3(huizongHf.getHf3());
					huizongTmp.setHf4(huizongHf.getHf4());
					huizongTmp.setHf5(huizongHf.getHf5());
					huizongTmp.setHf6(huizongHf.getHf6());
					huizongTmp.setHf7(huizongHf.getHf7());
					huizongTmp.setHf8(huizongHf.getHf8());
					huizongTmp.setHf9(huizongHf.getHf9());
					huizongTmp.setHf10(huizongHf.getHf10());
					huizongTmp.setHf11(huizongHf.getHf11());
					huizongTmp.setHf12(huizongHf.getHf12());
					huizongTmp.setHf13(huizongHf.getHf13());
					huizongTmp.setHf14(huizongHf.getHf14());
					huizongTmp.setHf15(huizongHf.getHf15());
					huizongTmp.setHf16(huizongHf.getHf16());
					huizongTmp.setHf17(huizongHf.getHf17());
					huizongTmp.setHf18(huizongHf.getHf18());
					huizongTmp.setHf19(huizongHf.getHf19());
					huizongTmp.setHf20(huizongHf.getHf20());
					huizongTmp.setHf21(huizongHf.getHf21());
					huizongTmp.setHf22(huizongHf.getHf22());
					huizongTmp.setHf23(huizongHf.getHf23());
					huizongTmp.setHf24(huizongHf.getHf24());
					huizongTmp.setHf25(huizongHf.getHf25());
					huizongTmp.setHf26(huizongHf.getHf26());
					huizongTmp.setHf27(huizongHf.getHf27());
					huizongTmp.setHf28(huizongHf.getHf28());
					huizongTmp.setHf29(huizongHf.getHf29());
					huizongTmp.setHf30(huizongHf.getHf30());
					huizongTmp.setHf31(huizongHf.getHf31());
					huizongTmp.setHf32(huizongHf.getHf32());
					huizongTmp.setHf33(huizongHf.getHf33());
					huizongTmp.setHf34(huizongHf.getHf34());
					huizongTmp.setHf35(huizongHf.getHf35());
					huizongTmp.setHf36(huizongHf.getHf36());
					huizongTmp.setHf37(huizongHf.getHf37());
					huizongTmp.setHf38(huizongHf.getHf38());
					huizongTmp.setHf39(huizongHf.getHf39());
					huizongTmp.setHf40(huizongHf.getHf40());
					
					huizongTmpMap.put(dh, huizongTmp);
				}
				
			}
		
		return huizongTmpMap;
	}

	/**
	 * 导入外部数据 
	 * @param yhDangHz		用户基本汇总信息
	 * @param huizongTmp    汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	
	public Map<Object,HuizongTmp> importExternalData(Map<Object, HuizongTmp> huizongTmpMap, 
			List<OtherDhedit> otherDheditList) throws Exception {
		if(otherDheditList == null || otherDheditList.size() <= 0){
			return huizongTmpMap;
		}
		
		for(int i=0;i<otherDheditList.size();i++){
			OtherDhedit other = otherDheditList.get(i);
			String dh = other.getDh();
			if(huizongTmpMap.containsKey(dh)){
				HuizongTmp temp = huizongTmpMap.get(dh);
				// zfs1-30
				temp.setZfs1(temp.getZfs1()+other.getZfs1());
				temp.setZfs2(temp.getZfs2()+other.getZfs2());
				temp.setZfs3(temp.getZfs3()+other.getZfs3());
				temp.setZfs4(temp.getZfs4()+other.getZfs4());
				temp.setZfs5(temp.getZfs5()+other.getZfs5());
				temp.setZfs6(temp.getZfs6()+other.getZfs6());
				temp.setZfs7(temp.getZfs7()+other.getZfs7());
				temp.setZfs8(temp.getZfs8()+other.getZfs8());
				temp.setZfs9(temp.getZfs9()+other.getZfs9());
				temp.setZfs10(temp.getZfs10()+other.getZfs10());
				temp.setZfs11(temp.getZfs11()+other.getZfs11());
				temp.setZfs12(temp.getZfs12()+other.getZfs12());
				temp.setZfs13(temp.getZfs13()+other.getZfs13());
				temp.setZfs14(temp.getZfs14()+other.getZfs14());
				temp.setZfs15(temp.getZfs15()+other.getZfs15());
				temp.setZfs16(temp.getZfs16()+other.getZfs16());
				temp.setZfs17(temp.getZfs17()+other.getZfs17());
				temp.setZfs18(temp.getZfs18()+other.getZfs18());
				temp.setZfs19(temp.getZfs19()+other.getZfs19());
				temp.setZfs20(temp.getZfs20()+other.getZfs20());
				temp.setZfs21(temp.getZfs21()+other.getZfs21());
				temp.setZfs22(temp.getZfs22()+other.getZfs22());
				temp.setZfs23(temp.getZfs23()+other.getZfs23());
				temp.setZfs24(temp.getZfs24()+other.getZfs24());
				temp.setZfs25(temp.getZfs25()+other.getZfs25());
				temp.setZfs26(temp.getZfs26()+other.getZfs26());
				temp.setZfs27(temp.getZfs27()+other.getZfs27());
				temp.setZfs28(temp.getZfs28()+other.getZfs28());
				temp.setZfs29(temp.getZfs29()+other.getZfs29());
				temp.setZfs30(temp.getZfs30()+other.getZfs30());
				
				// hf1-40
				temp.setHf1(temp.getHf1()+other.getHf1());
				temp.setHf2(temp.getHf2()+other.getHf2());
				temp.setHf3(temp.getHf3()+other.getHf3());
				temp.setHf4(temp.getHf4()+other.getHf4());
				temp.setHf5(temp.getHf5()+other.getHf5());
				temp.setHf6(temp.getHf6()+other.getHf6());
				temp.setHf7(temp.getHf7()+other.getHf7());
				temp.setHf8(temp.getHf8()+other.getHf8());
				temp.setHf9(temp.getHf9()+other.getHf9());
				temp.setHf10(temp.getHf10()+other.getHf10());
				temp.setHf11(temp.getHf11()+other.getHf11());
				temp.setHf12(temp.getHf12()+other.getHf12());
				temp.setHf13(temp.getHf13()+other.getHf13());
				temp.setHf14(temp.getHf14()+other.getHf14());
				temp.setHf15(temp.getHf15()+other.getHf15());
				temp.setHf16(temp.getHf16()+other.getHf16());
				temp.setHf17(temp.getHf17()+other.getHf17());
				temp.setHf18(temp.getHf18()+other.getHf18());
				temp.setHf19(temp.getHf19()+other.getHf19());
				temp.setHf20(temp.getHf20()+other.getHf20());
				
				temp.setHf21(temp.getHf21()+other.getHf21());
				temp.setHf22(temp.getHf22()+other.getHf22());
				temp.setHf23(temp.getHf23()+other.getHf23());
				temp.setHf24(temp.getHf24()+other.getHf24());
				temp.setHf25(temp.getHf25()+other.getHf25());
				temp.setHf26(temp.getHf26()+other.getHf26());
				temp.setHf27(temp.getHf27()+other.getHf27());
				temp.setHf28(temp.getHf28()+other.getHf28());
				temp.setHf29(temp.getHf29()+other.getHf29());
				temp.setHf30(temp.getHf30()+other.getHf30());
				temp.setHf31(temp.getHf31()+other.getHf31());
				temp.setHf32(temp.getHf32()+other.getHf32());
				temp.setHf33(temp.getHf33()+other.getHf33());
				temp.setHf34(temp.getHf34()+other.getHf34());
				temp.setHf35(temp.getHf35()+other.getHf35());
				temp.setHf36(temp.getHf36()+other.getHf36());
				temp.setHf37(temp.getHf37()+other.getHf37());
				temp.setHf38(temp.getHf38()+other.getHf38());
				temp.setHf39(temp.getHf39()+other.getHf39());
				temp.setHf40(temp.getHf40()+other.getHf40());
				
				// hc1-40
				temp.setHc1(temp.getHc1()+other.getHc1());
				temp.setHc2(temp.getHc2()+other.getHc2());
				temp.setHc3(temp.getHc3()+other.getHc3());
				temp.setHc4(temp.getHc4()+other.getHc4());
				temp.setHc5(temp.getHc5()+other.getHc5());
				temp.setHc6(temp.getHc6()+other.getHc6());
				temp.setHc7(temp.getHc7()+other.getHc7());
				temp.setHc8(temp.getHc8()+other.getHc8());
				temp.setHc9(temp.getHc9()+other.getHc9());
				temp.setHc10(temp.getHc10()+other.getHc10());
				temp.setHc11(temp.getHc11()+other.getHc11());
				temp.setHc12(temp.getHc12()+other.getHc12());
				temp.setHc13(temp.getHc13()+other.getHc13());
				temp.setHc14(temp.getHc14()+other.getHc14());
				temp.setHc15(temp.getHc15()+other.getHc15());
				temp.setHc16(temp.getHc16()+other.getHc16());
				temp.setHc17(temp.getHc17()+other.getHc17());
				temp.setHc18(temp.getHc18()+other.getHc18());
				temp.setHc19(temp.getHc19()+other.getHc19());
				temp.setHc20(temp.getHc20()+other.getHc20());
				
				temp.setHc21(temp.getHc21()+other.getHc21());
				temp.setHc22(temp.getHc22()+other.getHc22());
				temp.setHc23(temp.getHc23()+other.getHc23());
				temp.setHc24(temp.getHc24()+other.getHc24());
				temp.setHc25(temp.getHc25()+other.getHc25());
				temp.setHc26(temp.getHc26()+other.getHc26());
				temp.setHc27(temp.getHc27()+other.getHc27());
				temp.setHc28(temp.getHc28()+other.getHc28());
				temp.setHc29(temp.getHc29()+other.getHc29());
				temp.setHc30(temp.getHc30()+other.getHc30());
				temp.setHc31(temp.getHc31()+other.getHc31());
				temp.setHc32(temp.getHc32()+other.getHc32());
				temp.setHc33(temp.getHc33()+other.getHc33());
				temp.setHc34(temp.getHc34()+other.getHc34());
				temp.setHc35(temp.getHc35()+other.getHc35());
				temp.setHc36(temp.getHc36()+other.getHc36());
				temp.setHc37(temp.getHc37()+other.getHc37());
				temp.setHc38(temp.getHc38()+other.getHc38());
				temp.setHc39(temp.getHc39()+other.getHc39());
				temp.setHc40(temp.getHc40()+other.getHc40());
				
				// heji
				temp.setHeji(temp.getHeji()+other.getHeji());
				
				huizongTmpMap.put(dh+"",temp);
			}
		}
		return huizongTmpMap;
	}
	/*public void importExternalData(Map<Object,YhdangHz> yhDangHzMap,int hzyf,
			List<HuizongTmp> huizongTmps, Connection conn)throws Exception {
		Map<Integer, OtherDhedit> otherMap = getOtherDheditForMap(yhDangHzMap, hzyf, conn);
		if(otherMap != null && otherMap.size() > 0){
			for(int i=0;i<huizongTmps.size();i++){
				HuizongTmp temp = huizongTmps.get(i);
				if(otherMap.containsKey(temp.getDhid())){
					OtherDhedit other = otherMap.get(temp.getDhid());
					//zfs1-30
					temp.setZfs1(temp.getZfs1()+other.getZfs1());
					temp.setZfs2(temp.getZfs2()+other.getZfs2());
					temp.setZfs3(temp.getZfs3()+other.getZfs3());
					temp.setZfs4(temp.getZfs4()+other.getZfs4());
					temp.setZfs5(temp.getZfs5()+other.getZfs5());
					temp.setZfs6(temp.getZfs6()+other.getZfs6());
					temp.setZfs7(temp.getZfs7()+other.getZfs7());
					temp.setZfs8(temp.getZfs8()+other.getZfs8());
					temp.setZfs9(temp.getZfs9()+other.getZfs9());
					temp.setZfs10(temp.getZfs10()+other.getZfs10());
					temp.setZfs11(temp.getZfs11()+other.getZfs11());
					temp.setZfs12(temp.getZfs12()+other.getZfs12());
					temp.setZfs13(temp.getZfs13()+other.getZfs13());
					temp.setZfs14(temp.getZfs14()+other.getZfs14());
					temp.setZfs15(temp.getZfs15()+other.getZfs15());
					temp.setZfs16(temp.getZfs16()+other.getZfs16());
					temp.setZfs17(temp.getZfs17()+other.getZfs17());
					temp.setZfs18(temp.getZfs18()+other.getZfs18());
					temp.setZfs19(temp.getZfs19()+other.getZfs19());
					temp.setZfs20(temp.getZfs20()+other.getZfs20());
					temp.setZfs21(temp.getZfs21()+other.getZfs21());
					temp.setZfs22(temp.getZfs22()+other.getZfs22());
					temp.setZfs23(temp.getZfs23()+other.getZfs23());
					temp.setZfs24(temp.getZfs24()+other.getZfs24());
					temp.setZfs25(temp.getZfs25()+other.getZfs25());
					temp.setZfs26(temp.getZfs26()+other.getZfs26());
					temp.setZfs27(temp.getZfs27()+other.getZfs27());
					temp.setZfs28(temp.getZfs28()+other.getZfs28());
					temp.setZfs29(temp.getZfs29()+other.getZfs29());
					temp.setZfs30(temp.getZfs30()+other.getZfs30());
					
					//hf1-40
					temp.setHf1(temp.getHf1()+other.getHf1());
					temp.setHf2(temp.getHf2()+other.getHf2());
					temp.setHf3(temp.getHf3()+other.getHf3());
					temp.setHf4(temp.getHf4()+other.getHf4());
					temp.setHf5(temp.getHf5()+other.getHf5());
					temp.setHf6(temp.getHf6()+other.getHf6());
					temp.setHf7(temp.getHf7()+other.getHf7());
					temp.setHf8(temp.getHf8()+other.getHf8());
					temp.setHf9(temp.getHf9()+other.getHf9());
					temp.setHf10(temp.getHf10()+other.getHf10());
					temp.setHf11(temp.getHf11()+other.getHf11());
					temp.setHf12(temp.getHf12()+other.getHf12());
					temp.setHf13(temp.getHf13()+other.getHf13());
					temp.setHf14(temp.getHf14()+other.getHf14());
					temp.setHf15(temp.getHf15()+other.getHf15());
					temp.setHf16(temp.getHf16()+other.getHf16());
					temp.setHf17(temp.getHf17()+other.getHf17());
					temp.setHf18(temp.getHf18()+other.getHf18());
					temp.setHf19(temp.getHf19()+other.getHf19());
					temp.setHf20(temp.getHf20()+other.getHf20());
					
					temp.setHf21(temp.getHf21()+other.getHf21());
					temp.setHf22(temp.getHf22()+other.getHf22());
					temp.setHf23(temp.getHf23()+other.getHf23());
					temp.setHf24(temp.getHf24()+other.getHf24());
					temp.setHf25(temp.getHf25()+other.getHf25());
					temp.setHf26(temp.getHf26()+other.getHf26());
					temp.setHf27(temp.getHf27()+other.getHf27());
					temp.setHf28(temp.getHf28()+other.getHf28());
					temp.setHf29(temp.getHf29()+other.getHf29());
					temp.setHf30(temp.getHf30()+other.getHf30());
					temp.setHf31(temp.getHf31()+other.getHf31());
					temp.setHf32(temp.getHf32()+other.getHf32());
					temp.setHf33(temp.getHf33()+other.getHf33());
					temp.setHf34(temp.getHf34()+other.getHf34());
					temp.setHf35(temp.getHf35()+other.getHf35());
					temp.setHf36(temp.getHf36()+other.getHf36());
					temp.setHf37(temp.getHf37()+other.getHf37());
					temp.setHf38(temp.getHf38()+other.getHf38());
					temp.setHf39(temp.getHf39()+other.getHf39());
					temp.setHf40(temp.getHf40()+other.getHf40());
				}
			}
		}
	}*/
	
	/**
	 * 获取外部数据OtherDH_Edit 并且按照dhid分组统计费用，返回以dhid为key的map
	 * @param yhdangHzMap
	 * @param hzyf
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public List<OtherDhedit> getOtherDheditList(int hzyf) throws Exception{
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql = "SELECT * FROM  Other_DhEdit WHERE hzyf=? ";
			
			return DBUtil.queryBeanList(conn, sql, OtherDhedit.class, new Object[]{hzyf});
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取外部数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
		
	}
	/*public Map<Integer,OtherDhedit> getOtherDheditForMap(Map<Object, YhdangHz> yhdangHzMap,int hzyf,Connection conn) throws Exception{
		
		 * SELECT src.row_id,src.DhID, src.Hth FROM (SELECT a.ROWID row_id, Y.DhID, Y.Hth
              FROM Other_DhEdit a ,Yhdang_Hz Y ,Dh_Change c,(select dh,max(changetime) changetime from dh_change  group by dh) d
              WHERE a.Dh = c.Dh
                AND c.NewDh = Y.Dh
                AND c.dh=d.dh AND c.changetime=d.changetime
                AND a.DhID = 0 AND a.hzyf=v_iHzyf) src
		 * 
		 * 
		 * 
		 
		String sql = "select d.rowid,d.* from Other_DhEdit d where d.hzyf=?";
		
		List<OtherDhedit> otherList = DBUtil.queryBeanList(conn, sql, OtherDhedit.class, new Object[]{hzyf});
		sql = "SELECT src.row_id,src.DhID, src.Hth FROM (SELECT a.ROWID row_id, Y.DhID, Y.Hth "
              +" FROM Other_DhEdit a ,Yhdang_Hz Y ,Dh_Change c,(select dh,max(changetime) changetime from dh_change  group by dh) d "
              + "WHERE a.Dh = c.Dh AND c.NewDh = Y.Dh AND c.dh=d.dh AND c.changetime=d.changetime  AND a.DhID = 0 AND a.hzyf=?) src";
		List<Map<String, Object>> tempList = DBUtil.queryMapList(conn, sql, new Object[]{hzyf});
		
		if(otherList == null || otherList.size() == 0){
			return null;
		}
		Map<Integer, OtherDhedit> result = new HashMap<Integer, OtherDhedit>();
		for(int i=0;i<otherList.size();i++){
			OtherDhedit other = otherList.get(i);
			Object dh = other.getDh();
			if(yhdangHzMap.containsKey(dh)){
				other.setDhid(yhdangHzMap.get(dh).getDhid());
				other.setHth(yhdangHzMap.get(dh).getHth());
			}
			
			if(tempList != null && tempList.size() > 0){
				
				for(int j=0;j<tempList.size();j++){
					Map<String, Object> map = tempList.get(j);
					if(map.get("ROW_ID").equals(other.getRowid())){
						other.setDhid((Integer) map.get("DHID"));
						other.setHth((String) map.get("HTH"));
					}
				}
			}
			//实现group by dhid
			Integer dhid = other.getDhid();
			if(result.containsKey(dhid)){
				OtherDhedit o = result.get(dhid);
				o.setHth(other.getHth());
				
				//zfs1-30
				o.setZfs1(o.getZfs1()+other.getZfs1());
				o.setZfs2(o.getZfs2()+other.getZfs2());
				o.setZfs3(o.getZfs3()+other.getZfs3());
				o.setZfs4(o.getZfs4()+other.getZfs4());
				o.setZfs5(o.getZfs5()+other.getZfs5());
				o.setZfs6(o.getZfs6()+other.getZfs6());
				o.setZfs7(o.getZfs7()+other.getZfs7());
				o.setZfs8(o.getZfs8()+other.getZfs8());
				o.setZfs9(o.getZfs9()+other.getZfs9());
				o.setZfs10(o.getZfs10()+other.getZfs10());
				o.setZfs11(o.getZfs11()+other.getZfs11());
				o.setZfs12(o.getZfs12()+other.getZfs12());
				o.setZfs13(o.getZfs13()+other.getZfs13());
				o.setZfs14(o.getZfs14()+other.getZfs14());
				o.setZfs15(o.getZfs15()+other.getZfs15());
				o.setZfs16(o.getZfs16()+other.getZfs16());
				o.setZfs17(o.getZfs17()+other.getZfs17());
				o.setZfs18(o.getZfs18()+other.getZfs18());
				o.setZfs19(o.getZfs19()+other.getZfs19());
				o.setZfs20(o.getZfs20()+other.getZfs20());
				o.setZfs21(o.getZfs21()+other.getZfs21());
				o.setZfs22(o.getZfs22()+other.getZfs22());
				o.setZfs23(o.getZfs23()+other.getZfs23());
				o.setZfs24(o.getZfs24()+other.getZfs24());
				o.setZfs25(o.getZfs25()+other.getZfs25());
				o.setZfs26(o.getZfs26()+other.getZfs26());
				o.setZfs27(o.getZfs27()+other.getZfs27());
				o.setZfs28(o.getZfs28()+other.getZfs28());
				o.setZfs29(o.getZfs29()+other.getZfs29());
				o.setZfs30(o.getZfs30()+other.getZfs30());
				
				//hf1-40
				o.setHf1(o.getHf1()+other.getHf1());
				o.setHf2(o.getHf2()+other.getHf2());
				o.setHf3(o.getHf3()+other.getHf3());
				o.setHf4(o.getHf4()+other.getHf4());
				o.setHf5(o.getHf5()+other.getHf5());
				o.setHf6(o.getHf6()+other.getHf6());
				o.setHf7(o.getHf7()+other.getHf7());
				o.setHf8(o.getHf8()+other.getHf8());
				o.setHf9(o.getHf9()+other.getHf9());
				o.setHf10(o.getHf10()+other.getHf10());
				o.setHf11(o.getHf11()+other.getHf11());
				o.setHf12(o.getHf12()+other.getHf12());
				o.setHf13(o.getHf13()+other.getHf13());
				o.setHf14(o.getHf14()+other.getHf14());
				o.setHf15(o.getHf15()+other.getHf15());
				o.setHf16(o.getHf16()+other.getHf16());
				o.setHf17(o.getHf17()+other.getHf17());
				o.setHf18(o.getHf18()+other.getHf18());
				o.setHf19(o.getHf19()+other.getHf19());
				o.setHf20(o.getHf20()+other.getHf20());
				
				o.setHf21(o.getHf21()+other.getHf21());
				o.setHf22(o.getHf22()+other.getHf22());
				o.setHf23(o.getHf23()+other.getHf23());
				o.setHf24(o.getHf24()+other.getHf24());
				o.setHf25(o.getHf25()+other.getHf25());
				o.setHf26(o.getHf26()+other.getHf26());
				o.setHf27(o.getHf27()+other.getHf27());
				o.setHf28(o.getHf28()+other.getHf28());
				o.setHf29(o.getHf29()+other.getHf29());
				o.setHf30(o.getHf30()+other.getHf30());
				o.setHf31(o.getHf31()+other.getHf31());
				o.setHf32(o.getHf32()+other.getHf32());
				o.setHf33(o.getHf33()+other.getHf33());
				o.setHf34(o.getHf34()+other.getHf34());
				o.setHf35(o.getHf35()+other.getHf35());
				o.setHf36(o.getHf36()+other.getHf36());
				o.setHf37(o.getHf37()+other.getHf37());
				o.setHf38(o.getHf38()+other.getHf38());
				o.setHf39(o.getHf39()+other.getHf39());
				o.setHf40(o.getHf40()+other.getHf40());
				
				result.put(dhid, o);
			}else{
				result.put(dhid, other);
			}
		}
		return result;
	}*/

	/**
	 * 按科目归类费用
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @returnMap
	 */
	public List<HuizongTmp> groupByKemu(Map<Object, HuizongTmp> huizongTmpMap,List<KemuDef> kemus,
			Map<Object,Yhlb> yhlbmap, Map<Object,HthdangHz> hthdangHzMap) throws Exception{
		
		Field[] fields = HuizongTmp.class.getDeclaredFields();  //all fields
		List<HuizongTmp> list = new ArrayList<HuizongTmp>();
		// 科目为空时，讲所有费用字段的值设置为0
		if(kemus == null || kemus.size() <= 0){
			for(Entry<Object,HuizongTmp> entry : huizongTmpMap.entrySet()){
				HuizongTmp huizongTmp = entry.getValue();
				for(int k=0;k<fields.length;k++){
					Field f = fields[k];
					f.setAccessible(true);
					if("double".equals(f.getType())){
						f.set(huizongTmp, 0.0);
					}
				}
				list.add(huizongTmp);
			}
			return list;
		}
		
		for(int i=0;i<kemus.size();i++){
			KemuDef kemu = kemus.get(i);
			String hzfields = kemu.getHzFields().toLowerCase();
			String columns = ","+kemu.getBz().toLowerCase();
			columns += ","+hzfields;
			HuizongTmp temp = null;
			
			for(Entry<Object,HuizongTmp> entry : huizongTmpMap.entrySet()){
				HuizongTmp huizongTmp = entry.getValue();
				//temp = huizongTmp;
				temp = new HuizongTmp();
				
				for(int k=0;k<fields.length;k++){
					Field f = fields[k];
					f.setAccessible(true);
					if(columns.contains(","+f.getName().toLowerCase())){
						f.set(temp, f.get(huizongTmp));
					}
				}
				temp.setKemu(kemu.getKemu());
				//计算话费合计
				calculateTotalBill(temp,yhlbmap,hthdangHzMap);
				
				list.add(temp);
			}
			
		}
	/*public List<HuizongTmp> groupByKemu(List<HuizongTmp> huizongTmps,List<KemuDef> kemus,String hzyf, Connection conn) throws Exception{
		String columns = "Kemu,Hzyf,Hzsj,Hzqx,Hth,Dh,DhID,Zlh,Mfjb,Reg_Date,StartDate,EndDate,TjBz,Yhmc,Bm1,Bm2,Bm3,Bm4,Bmbh,Area,Yhxz,Sflx,tjdate";
		Field[] fields = HuizongTmp.class.getDeclaredFields();
		List<HuizongTmp> list = new ArrayList<HuizongTmp>();
		for(int i=0;i<kemus.size();i++){
			KemuDef kemu = kemus.get(i);
			String hzfields = kemu.getHzFields();
			columns += "," +hzfields;
			HuizongTmp temp = null;
			for(int j=0;j<huizongTmps.size();j++){
				HuizongTmp huizongTmp = huizongTmps.get(i);
				temp = huizongTmp;
				
				for(int k=0;k<fields.length;k++){
					Field f = fields[i];
					f.setAccessible(true);
					if(columns.contains(f.getName())){
						f.set(temp, f.get(huizongTmp));
					}
				}
				//处理中石油定制：装机，以及，拆机费用
				zsyToZjYjCj(temp, hzyf, conn);
				//计算话费合计
				calculateTotalBill(temp, conn);
				list.add(temp);
			}
			
		}*/
		return list;
	}

	/**
	 * 中石油定制，处理装机，移机，拆机等费用
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	public void zsyToZjYjCj(HuizongTmp huizongTmp, String hzyf)throws Exception {
		
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql = "SELECT b.sgnr,b.xdh,SUM(b.yjje) as yjje FROM teljob b WHERE  to_char(b.sgrq,'yyyymm')=? AND b.yjje<>0   group by b.xdh  ,b.sgnr";
			List<Teljob> teljobs = DBUtil.queryBeanList(conn, sql, Teljob.class, new Object[]{hzyf});
			if(teljobs != null && teljobs.size() > 0){
				for(int i=0;i<teljobs.size();i++){
					Teljob telJob = teljobs.get(i);
					if(huizongTmp.getDh().equals(telJob.getXdh())){
						
						if("p_setup".equalsIgnoreCase(telJob.getSgnr())){
							huizongTmp.setHf11(huizongTmp.getHf11()+telJob.getYjje());
						}
						if("p_movephone".equalsIgnoreCase(telJob.getSgnr())){
							huizongTmp.setHf13(huizongTmp.getHf13()+telJob.getYjje());
						}
						if("p_buyphone".equalsIgnoreCase(telJob.getSgnr())){
							huizongTmp.setHf14(huizongTmp.getHf14()+telJob.getYjje());
						}
						
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("处理拆机，装机，移机等费用时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
		
		
	}

	/**
	 * 计算话费合计
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	public void calculateTotalBill(HuizongTmp huizongTmp,Map<Object,Yhlb> yhlbmap,Map<Object,HthdangHz> hthdangHzMap) {
		
		//判断合同号是不是数字，如果是：中石油合同号小于200的 不收专网费
		String hth = huizongTmp.getHth();
		Pattern pattern = Pattern.compile("^[0-9]*$");
		if(pattern.matcher(hth).matches()){
		
			if(Integer.parseInt(hth) <200 ){
				huizongTmp.setHf9(0.0);
			}
		}
		
		BigDecimal bhf = new BigDecimal(huizongTmp.getHf1()).add(new BigDecimal(huizongTmp.getHf2())).add(new BigDecimal(huizongTmp.getHf3()))
				.add(new BigDecimal(huizongTmp.getHf4())).add(new BigDecimal(huizongTmp.getHf5())).add(new BigDecimal(huizongTmp.getHf6()))
				.add(new BigDecimal(huizongTmp.getHf7())).add(new BigDecimal(huizongTmp.getHf8())).add(new BigDecimal(huizongTmp.getHf9()))
				.add(new BigDecimal(huizongTmp.getHf10())).add(new BigDecimal(huizongTmp.getHf11())).add(new BigDecimal(huizongTmp.getHf12()))
				.add(new BigDecimal(huizongTmp.getHf13())).add(new BigDecimal(huizongTmp.getHf14())).add(new BigDecimal(huizongTmp.getHf15()))
				.add(new BigDecimal(huizongTmp.getHf16())).add(new BigDecimal(huizongTmp.getHf17())).add(new BigDecimal(huizongTmp.getHf18()))
				.add(new BigDecimal(huizongTmp.getHf19())).add(new BigDecimal(huizongTmp.getHf20())).add(new BigDecimal(huizongTmp.getHf21()))
				.add(new BigDecimal(huizongTmp.getHf22())).add(new BigDecimal(huizongTmp.getHf23())).add(new BigDecimal(huizongTmp.getHf24()))
				.add(new BigDecimal(huizongTmp.getHf25())).add(new BigDecimal(huizongTmp.getHf26())).add(new BigDecimal(huizongTmp.getHf27()))
				.add(new BigDecimal(huizongTmp.getHf28())).add(new BigDecimal(huizongTmp.getHf29())).add(new BigDecimal(huizongTmp.getHf30()))
				.add(new BigDecimal(huizongTmp.getHf31())).add(new BigDecimal(huizongTmp.getHf32())).add(new BigDecimal(huizongTmp.getHf33()))
				.add(new BigDecimal(huizongTmp.getHf34())).add(new BigDecimal(huizongTmp.getHf35())).add(new BigDecimal(huizongTmp.getHf36()))
				.add(new BigDecimal(huizongTmp.getHf37())).add(new BigDecimal(huizongTmp.getHf38())).add(new BigDecimal(huizongTmp.getHf39()))
				.add(new BigDecimal(huizongTmp.getHf40())).add(new BigDecimal(huizongTmp.getFjf())).add(new BigDecimal(huizongTmp.getFuf()));
		
		BigDecimal bzfs = new BigDecimal(huizongTmp.getZfs1()).add(new BigDecimal(huizongTmp.getZfs2())).add(new BigDecimal(huizongTmp.getZfs3())).add(new BigDecimal(huizongTmp.getZfs4())).add(new BigDecimal(huizongTmp.getZfs5()))
				.add(new BigDecimal(huizongTmp.getZfs6())).add(new BigDecimal(huizongTmp.getZfs7())).add(new BigDecimal(huizongTmp.getZfs8())).add(new BigDecimal(huizongTmp.getZfs9())).add(new BigDecimal(huizongTmp.getZfs10()))
				.add(new BigDecimal(huizongTmp.getZfs11())).add(new BigDecimal(huizongTmp.getZfs12())).add(new BigDecimal(huizongTmp.getZfs13())).add(new BigDecimal(huizongTmp.getZfs14())).add(new BigDecimal(huizongTmp.getZfs15()))
				.add(new BigDecimal(huizongTmp.getZfs16())).add(new BigDecimal(huizongTmp.getZfs17())).add(new BigDecimal(huizongTmp.getZfs18())).add(new BigDecimal(huizongTmp.getZfs19())).add(new BigDecimal(huizongTmp.getZfs20()))
				.add(new BigDecimal(huizongTmp.getZfs21())).add(new BigDecimal(huizongTmp.getZfs22())).add(new BigDecimal(huizongTmp.getZfs23())).add(new BigDecimal(huizongTmp.getZfs24())).add(new BigDecimal(huizongTmp.getZfs25()))
				.add(new BigDecimal(huizongTmp.getZfs26())).add(new BigDecimal(huizongTmp.getZfs27())).add(new BigDecimal(huizongTmp.getZfs28())).add(new BigDecimal(huizongTmp.getZfs29())).add(new BigDecimal(huizongTmp.getZfs30()));
		
		BigDecimal bhthzfs = new BigDecimal(huizongTmp.getHthzfs1()).add(new BigDecimal(huizongTmp.getHthzfs2())).add(new BigDecimal(huizongTmp.getHthzfs3())).add(new BigDecimal(huizongTmp.getHthzfs4())).add(new BigDecimal(huizongTmp.getHthzfs5()))
				.add(new BigDecimal(huizongTmp.getHthzfs6())).add(new BigDecimal(huizongTmp.getHthzfs7())).add(new BigDecimal(huizongTmp.getHthzfs8())).add(new BigDecimal(huizongTmp.getHthzfs9())).add(new BigDecimal(huizongTmp.getHthzfs10()))
				.add(new BigDecimal(huizongTmp.getHthzfs11())).add(new BigDecimal(huizongTmp.getHthzfs12())).add(new BigDecimal(huizongTmp.getHthzfs13())).add(new BigDecimal(huizongTmp.getHthzfs14())).add(new BigDecimal(huizongTmp.getHthzfs15()))
				.add(new BigDecimal(huizongTmp.getHthzfs16())).add(new BigDecimal(huizongTmp.getHthzfs17())).add(new BigDecimal(huizongTmp.getHthzfs18())).add(new BigDecimal(huizongTmp.getHthzfs19())).add(new BigDecimal(huizongTmp.getHthzfs20()));
		
		BigDecimal heji = bhf.add(bzfs).add(bhthzfs);
		
		huizongTmp.setHf(new BigDecimal(huizongTmp.getHf()).add(bhf).doubleValue());
		huizongTmp.setZfs(new BigDecimal(huizongTmp.getZfs()).add(bzfs).doubleValue());
		huizongTmp.setHthzfs(new BigDecimal(huizongTmp.getHthzfs()).add(bhthzfs).doubleValue());
		huizongTmp.setHeji(new BigDecimal(huizongTmp.getHeji()).add(heji).doubleValue());
		huizongTmp.setBtheji(new BigDecimal(huizongTmp.getBtheji()).add(heji).doubleValue());
		
		//设置合同号用户类别
		if(yhlbmap != null && !yhlbmap.isEmpty() && hthdangHzMap.containsKey(hth) && yhlbmap.containsKey(hthdangHzMap.get(hth).getYhlb()) ){
			huizongTmp.setZlh(yhlbmap.get(hthdangHzMap.get(hth).getYhlb()).getId()+"");
		}
	}

	/**
	 * 计算电话费减免
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	public List<HuizongTmp> calculateBillRelief(List<HuizongTmp> huizongTmpList,List<Butieitem> butieitemList,
			Map<Object,FreeGrade> freeGradeMap,List<HuizongTmp> huizongPreList,String hzyfmm ) throws Exception{
		
		if(butieitemList == null || butieitemList.size() <=0){
			
			return huizongTmpList;
		}
		
		Map<Object,HuizongTmp> huizongPreMap = null;
		if(huizongPreList != null && huizongPreList.size() >0){
			
			huizongPreMap = listToMap(huizongPreList,"dh");
		}
		
		//循环汇总数据
		for ( int i = 0; i< huizongTmpList.size(); i++){
			
			HuizongTmp huizongTmp = huizongTmpList.get(i);
			String hkemu = huizongTmp.getKemu();
			String hmfjb = huizongTmp.getMfjb();
			String hdh = huizongTmp.getDh();
			int hdhid = huizongTmp.getDhid();
//			double totalbutie = 0;
			BigDecimal totalbutie = new BigDecimal(0);
			
			//循环减免补贴定义数据
			for(int j=0;j<butieitemList.size();j++){
				
				Butieitem butieitem = butieitemList.get(j);
				int xuhao = butieitem.getXuhao();
				String bkemu = butieitem.getKemu();
				String bfeefields = butieitem.getFeefields();
				String zeromonth = butieitem.getZeromonth();
				
				if(xuhao > 0 && bkemu != null && bkemu.length()>0 && bfeefields != null && bfeefields.length()>0){
					
					//获取汇总表btfee字段数值
					Field hbtfeeF = HuizongTmp.class.getDeclaredField("btfee"+xuhao);
					hbtfeeF.setAccessible(true);
//					double hbtfee = Double.parseDouble(String.valueOf(hbtfeeF.get(huizongTmp)));
					
					BigDecimal hbtfee = new BigDecimal(Double.parseDouble(String.valueOf(hbtfeeF.get(huizongTmp))));
					//获取补贴减免项目的费用数值
					Field hbfeefieldsF = HuizongTmp.class.getDeclaredField(bfeefields.toLowerCase());
					hbfeefieldsF.setAccessible(true);
//					double hbfeefieldsfee = Double.parseDouble(String.valueOf(hbfeefieldsF.get(huizongTmp)));
					BigDecimal hbfeefieldsfee = new BigDecimal(Double.parseDouble(String.valueOf(hbfeefieldsF.get(huizongTmp))));
					//获取补贴结余
					Field hbtjyF = HuizongTmp.class.getDeclaredField("btjy"+xuhao);
					hbtjyF.setAccessible(true);
					
					//1.初始化各补贴项目组的补贴后的费用
					hbtfee = hbfeefieldsfee;
					
					if (hmfjb != null && hmfjb.length() > 0 && freeGradeMap != null && !freeGradeMap.isEmpty()
							&& freeGradeMap.containsKey(hmfjb) && hkemu.equals(bkemu)){
							
						FreeGrade freeGrade = freeGradeMap.get(hmfjb);
						Field hbutieF = HuizongTmp.class.getDeclaredField("butie"+xuhao);
						hbutieF.setAccessible(true);
						Field fblbutieF = FreeGrade.class.getDeclaredField("blbutie"+xuhao);
						fblbutieF.setAccessible(true);
						Field fbutieF = FreeGrade.class.getDeclaredField("butie"+xuhao);
						fbutieF.setAccessible(true);							
						
//						double hbutie = Double.parseDouble(String.valueOf(hbutieF.get(huizongTmp)));
//						double fblbutie = Double.parseDouble(String.valueOf(fblbutieF.get(freeGrade)));
//						double fbutie = Double.parseDouble(String.valueOf(fbutieF.get(freeGrade)));
						BigDecimal hbutie = new BigDecimal(Double.parseDouble(String.valueOf(hbutieF.get(huizongTmp))));
						BigDecimal fblbutie = new BigDecimal(Double.parseDouble(String.valueOf(fblbutieF.get(freeGrade))));
						BigDecimal fbutie = new BigDecimal(Double.parseDouble(String.valueOf(fbutieF.get(freeGrade))));
						
						//2.根据减免率计算补贴后费用和补贴费用
//						hbtfee = Math.round(hbtfee*(1-fblbutie));
//						hbutie = Math.round(hbtfee*fblbutie);
						hbtfee = hbtfee.subtract(hbtfee.multiply(fblbutie));
						hbutie = hbtfee.multiply(fblbutie);
						
//						double btfee = 0;
//						double butie = 0;
//						double btjy = 0;
						BigDecimal btfee;
						BigDecimal butie;
						BigDecimal btjy;
						
						//3.根据上月各补贴组补贴结余计算出各补贴项目组的补贴后话费、补贴值、补贴结余值
//						double prehbtjy = 0;
						BigDecimal prehbtjy = new BigDecimal(0);
						if (huizongPreMap != null && !huizongPreMap.isEmpty() 
								&& huizongPreMap.containsKey(hdh) && huizongPreMap.get(hdh).getDhid() == hdhid) {
							
							HuizongTmp huizongPre = huizongPreMap.get(hdh);
							Field hprebtjyF = HuizongTmp.class.getDeclaredField("btjy"+xuhao);
							hprebtjyF.setAccessible(true);
//							prehbtjy = Double.parseDouble(String.valueOf(hprebtjyF.get(huizongPre)));
							prehbtjy = new BigDecimal(Double.parseDouble(String.valueOf(hprebtjyF.get(huizongPre))));
							
							if(hbtfee.doubleValue() - prehbtjy.doubleValue() >= 0){
								btfee = hbtfee.subtract(prehbtjy);
								butie = hbutie.add(prehbtjy);
								btjy = new BigDecimal(0);
							}else{
								btfee = new BigDecimal(0);
								butie = hbutie.add(btfee);
								btjy = prehbtjy.subtract(hbtfee);
							}
						}else{
							btfee = hbtfee;
							butie = hbutie;
						}
						
						//4.根据补贴类别计算出各补贴项目组的补贴值、补贴结余值、补贴后话费
						if (btfee.doubleValue() - fbutie.doubleValue() >=0){
							btfee = btfee.subtract(fbutie);
							butie = butie.add(fbutie);
							btjy = new BigDecimal(0);
						}else{
							btfee = new BigDecimal(0);
							butie = butie.add(btfee);
							btjy = fbutie.subtract(btfee);								
						}
						if(zeromonth.contains(hzyfmm)){
							btjy = new BigDecimal(0);
						}
						hbtfeeF.set(huizongTmp, btfee.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
						hbutieF.set(huizongTmp, butie.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
						hbtjyF.set(huizongTmp, btjy.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
						totalbutie = totalbutie.add(butie) ;
						
					}else{
						hbtfeeF.set(huizongTmp, hbtfee.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
					}
				}
			}
			
			huizongTmp.setButie(totalbutie.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
			huizongTmp.setBtheji(new BigDecimal(huizongTmp.getHeji()).subtract(totalbutie).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
			
		}
		
		return huizongTmpList;
	}
	
	/**
	 * 计算合同号话费减免
	 * @param huizongTmp	汇总临时数据
	 * @param conn  		数据库连接
	 * @return
	 */
	public HthhfHzTmp hthCalculateBillRelief(HthhfHzTmp hthhfHzTmp, Map<Object,FreeGrade> freeGradeMap,
			List<Butieitem> butieitemList, List<HthhfHzTmp> hthhfHzPreList, String hzyfmm) throws Exception {
		
		if(butieitemList == null || butieitemList.size() <=0){
			return hthhfHzTmp;
		}
		String hthmfjb = hthhfHzTmp.getHthmfjb();
		String hkemu = hthhfHzTmp.getKemu();
		String hth = hthhfHzTmp.getHth();
		BigDecimal totalbutie = new BigDecimal(0);
		
		Map<Object,HthhfHzTmp> hthhfHzPreMap = null;
		if(hthhfHzPreList != null && hthhfHzPreList.size() >0){
			
			hthhfHzPreMap = listToMap(hthhfHzPreList,"hth");
		}
		
		for(int i = 0; i< butieitemList.size(); i++){
			
			Butieitem butieitem = butieitemList.get(i);
			String bkemu = butieitem.getKemu();
			int xuhao = butieitem.getXuhao();
			String bfeefields = butieitem.getFeefields();
			String zeromonth = butieitem.getZeromonth();
			
			if(xuhao > 0 && bkemu != null && bkemu.length()>0 && bfeefields != null && bfeefields.length()>0
					&& freeGradeMap != null && !freeGradeMap.isEmpty()
					&& freeGradeMap.containsKey(hthmfjb) && hkemu != null && hkemu.length() > 0 
					&& hkemu.equals(bkemu)){
					
					FreeGrade freeGrade = freeGradeMap.get(hthmfjb);
					
					Field hbtfeeF = HthhfHzTmp.class.getDeclaredField("btfee"+xuhao);
					hbtfeeF.setAccessible(true);
					//获取hthhf汇总表补贴后费用
//					double hbtfee = Double.parseDouble(String.valueOf(hbtfeeF.get(hthhfHzTmp)));
//					BigDecimal hbtfee = new BigDecimal(Double.parseDouble(String.valueOf(hbtfeeF.get(hthhfHzTmp))));
					BigDecimal hbtfee = new BigDecimal(0);
					
					Field hbutieF = HthhfHzTmp.class.getDeclaredField("butie"+xuhao);
					hbutieF.setAccessible(true);
					Field hbtjyF = HthhfHzTmp.class.getDeclaredField("btjy"+xuhao);
					hbtjyF.setAccessible(true);
					
					Field fblbutieF = FreeGrade.class.getDeclaredField("blbutie"+xuhao);
					fblbutieF.setAccessible(true);
					Field fbutieF = FreeGrade.class.getDeclaredField("butie"+xuhao);
					fbutieF.setAccessible(true);
					
					Field hbfeefieldsF = HthhfHzTmp.class.getDeclaredField(bfeefields.toLowerCase());
					hbfeefieldsF.setAccessible(true);
					//获取补贴减免项目的费用数值
//					double hbfeefieldsfee = Double.parseDouble(String.valueOf(hbfeefieldsF.get(hthhfHzTmp)));
					BigDecimal hbfeefieldsfee = new BigDecimal(Double.parseDouble(String.valueOf(hbfeefieldsF.get(hthhfHzTmp))));
					//获取hthhf汇总表butie数值 
//					double hbutie = Double.parseDouble(String.valueOf(hbutieF.get(hthhfHzTmp)));
					BigDecimal hbutie = new BigDecimal(Double.parseDouble(String.valueOf(hbutieF.get(hthhfHzTmp))));
					//获取补贴率
//					double fblbutie = Double.parseDouble(String.valueOf(fblbutieF.get(freeGrade)));
					BigDecimal fblbutie = new BigDecimal(Double.parseDouble(String.valueOf(fblbutieF.get(freeGrade))));
					//获取补贴额
//					double fbutie = Double.parseDouble(String.valueOf(fbutieF.get(freeGrade)));
					BigDecimal fbutie = new BigDecimal(Double.parseDouble(String.valueOf(fbutieF.get(freeGrade))));
					
					//1.初始化各补贴项目组的补贴后的费用
					hbtfee = hbfeefieldsfee.subtract(hbutie);
					
					//2.根据减免率计算补贴后费用和补贴费用
//					hbtfee = Math.round(hbtfee*(1-fblbutie));
//					hbutie = Math.round(hbtfee*fblbutie);
					hbtfee = hbtfee.subtract(hbtfee.multiply(fblbutie));
					hbutie = hbutie.add(hbtfee.multiply(fblbutie));	
					
//					double btfee = 0;
//					double butie = 0;
//					double btjy = 0;
					BigDecimal btfee;
					BigDecimal butie;
					BigDecimal btjy;					
					//3.根据上月各补贴组补贴结余计算出各补贴项目组的补贴后话费、补贴值、补贴结余值
//					double prehbtjy = 0;
					BigDecimal prehbtjy = new BigDecimal(0);
					if (!hthhfHzPreMap.isEmpty() && hthhfHzPreMap.containsKey(hth)) {
						
						HthhfHzTmp hthhfHzPre = hthhfHzPreMap.get(hth);
						Field hprebtjyF = HthhfHzTmp.class.getDeclaredField("btjy"+xuhao);
						hprebtjyF.setAccessible(true);
						prehbtjy = new BigDecimal(Double.parseDouble(String.valueOf(hprebtjyF.get(hthhfHzPre))));
						
						if(hbtfee.doubleValue() - prehbtjy.doubleValue() >= 0){
							btfee = hbtfee.subtract(prehbtjy);
							butie = hbutie.add(prehbtjy);
							btjy = new BigDecimal(0);
						}else{
							btfee = new BigDecimal(0);
							butie = hbutie.add(btfee);
							btjy = prehbtjy.subtract(hbtfee);
						}
					}else{
						btfee = hbtfee;
						butie = hbutie;
					}
					
					//3.根据补贴类别计算出各补贴项目组的补贴值、补贴结余值、补贴后话费
					if (btfee.doubleValue() - fbutie.doubleValue() >=0){
						btfee = btfee.subtract(fbutie);
						butie = butie.add(fbutie);
						btjy = new BigDecimal(0);
					}else{
						btfee = new BigDecimal(0);
						butie = butie.add(btfee);
						btjy = fbutie.subtract(btfee);								
					}
					
					if(zeromonth.contains(hzyfmm)){
						btjy = new BigDecimal(0);
					}
					
					hbtfeeF.set(hthhfHzTmp, btfee.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
					hbutieF.set(hthhfHzTmp, butie.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
					hbtjyF.set(hthhfHzTmp, btjy.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
					totalbutie = totalbutie.add(butie);
					
				}
		}			
		
		hthhfHzTmp.setButie(totalbutie.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
		hthhfHzTmp.setBtheji(new BigDecimal(hthhfHzTmp.getHeji()).subtract(totalbutie).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
		
		return hthhfHzTmp;
	}

	/**
	 * 按合同号统计 Huizong->Hthhf_Hz
	 * @param huizongTmps 	汇总临时数据
	 * @param mxmonth 		汇总时间设置
	 * @param hthdangHzMap 	合同号档信息map
	 * @param conn			数据库连接
	 * @return 合同号汇总list
	 * @throws Exception
	 */
	public List<HthhfHzTmp> groupByHth(List<HuizongTmp> huizongTmps,Mxmonth mxmonth,
			Map<Object,HthdangHz> hthdangHzMap, Map<Object,FreeGrade> freeGradeMap,
			List<Butieitem> butieitemList, List<HthhfHzTmp> hthhfHzPreList,String hzyfmm)throws Exception {
		Connection conn = null;
		
		try {
			conn = DBUtil.openConnection();
			String hzyf = mxmonth.getMonth();
			
			Map<String, HthhfHzTmp> map = new HashMap<String, HthhfHzTmp>();
			List<HthhfHzTmp> list = new ArrayList<HthhfHzTmp>();
			HthhfHzTmp hthTmp = null;
			for(int i=0;i<huizongTmps.size();i++){
				HuizongTmp temp = huizongTmps.get(i);
				String kemu = temp.getKemu();
				String hth = temp.getHth();
				if(map.containsKey(kemu+hth)){
					
					hthTmp = map.get(kemu+hth);
					if(temp.getDh() != null){
						hthTmp.setDhsl(hthTmp.getDhsl()+1);
					}
					//hc1-40
					hthTmp.setHc1(hthTmp.getHc1()+temp.getHc1());
					hthTmp.setHc2(hthTmp.getHc2()+temp.getHc2());
					hthTmp.setHc3(hthTmp.getHc3()+temp.getHc3());
					hthTmp.setHc4(hthTmp.getHc4()+temp.getHc4());
					hthTmp.setHc5(hthTmp.getHc5()+temp.getHc5());
					hthTmp.setHc6(hthTmp.getHc6()+temp.getHc6());
					hthTmp.setHc7(hthTmp.getHc7()+temp.getHc7());
					hthTmp.setHc8(hthTmp.getHc8()+temp.getHc8());
					hthTmp.setHc9(hthTmp.getHc9()+temp.getHc9());
					hthTmp.setHc10(hthTmp.getHc10()+temp.getHc10());
					hthTmp.setHc11(hthTmp.getHc11()+temp.getHc11());
					hthTmp.setHc12(hthTmp.getHc12()+temp.getHc12());
					hthTmp.setHc13(hthTmp.getHc13()+temp.getHc13());
					hthTmp.setHc14(hthTmp.getHc14()+temp.getHc14());
					hthTmp.setHc15(hthTmp.getHc15()+temp.getHc15());
					hthTmp.setHc16(hthTmp.getHc16()+temp.getHc16());
					hthTmp.setHc17(hthTmp.getHc17()+temp.getHc17());
					hthTmp.setHc18(hthTmp.getHc18()+temp.getHc18());
					hthTmp.setHc19(hthTmp.getHc19()+temp.getHc19());
					hthTmp.setHc20(hthTmp.getHc20()+temp.getHc20());
					hthTmp.setHc21(hthTmp.getHc21()+temp.getHc21());
					hthTmp.setHc22(hthTmp.getHc22()+temp.getHc22());
					hthTmp.setHc23(hthTmp.getHc23()+temp.getHc23());
					hthTmp.setHc24(hthTmp.getHc24()+temp.getHc24());
					hthTmp.setHc25(hthTmp.getHc25()+temp.getHc25());
					hthTmp.setHc26(hthTmp.getHc26()+temp.getHc26());
					hthTmp.setHc27(hthTmp.getHc27()+temp.getHc27());
					hthTmp.setHc28(hthTmp.getHc28()+temp.getHc28());
					hthTmp.setHc29(hthTmp.getHc29()+temp.getHc29());
					hthTmp.setHc30(hthTmp.getHc30()+temp.getHc30());
					hthTmp.setHc31(hthTmp.getHc31()+temp.getHc31());
					hthTmp.setHc32(hthTmp.getHc32()+temp.getHc32());
					hthTmp.setHc33(hthTmp.getHc33()+temp.getHc33());
					hthTmp.setHc34(hthTmp.getHc34()+temp.getHc34());
					hthTmp.setHc35(hthTmp.getHc35()+temp.getHc35());
					hthTmp.setHc36(hthTmp.getHc36()+temp.getHc36());
					hthTmp.setHc37(hthTmp.getHc37()+temp.getHc37());
					hthTmp.setHc38(hthTmp.getHc38()+temp.getHc38());
					hthTmp.setHc39(hthTmp.getHc39()+temp.getHc39());
					hthTmp.setHc40(hthTmp.getHc40()+temp.getHc40());
					//hf1-40
					hthTmp.setHf1(hthTmp.getHf1()+temp.getHf1());
					hthTmp.setHf2(hthTmp.getHf2()+temp.getHf2());
					hthTmp.setHf3(hthTmp.getHf3()+temp.getHf3());
					hthTmp.setHf4(hthTmp.getHf4()+temp.getHf4());
					hthTmp.setHf5(hthTmp.getHf5()+temp.getHf5());
					hthTmp.setHf6(hthTmp.getHf6()+temp.getHf6());
					hthTmp.setHf7(hthTmp.getHf7()+temp.getHf7());
					hthTmp.setHf8(hthTmp.getHf8()+temp.getHf8());
					hthTmp.setHf9(hthTmp.getHf9()+temp.getHf9());
					hthTmp.setHf10(hthTmp.getHf10()+temp.getHf10());
					hthTmp.setHf11(hthTmp.getHf11()+temp.getHf11());
					hthTmp.setHf12(hthTmp.getHf12()+temp.getHf12());
					hthTmp.setHf13(hthTmp.getHf13()+temp.getHf13());
					hthTmp.setHf14(hthTmp.getHf14()+temp.getHf14());
					hthTmp.setHf15(hthTmp.getHf15()+temp.getHf15());
					hthTmp.setHf16(hthTmp.getHf16()+temp.getHf16());
					hthTmp.setHf17(hthTmp.getHf17()+temp.getHf17());
					hthTmp.setHf18(hthTmp.getHf18()+temp.getHf18());
					hthTmp.setHf19(hthTmp.getHf19()+temp.getHf19());
					hthTmp.setHf20(hthTmp.getHf20()+temp.getHf20());
					hthTmp.setHf21(hthTmp.getHf21()+temp.getHf21());
					hthTmp.setHf22(hthTmp.getHf22()+temp.getHf22());
					hthTmp.setHf23(hthTmp.getHf23()+temp.getHf23());
					hthTmp.setHf24(hthTmp.getHf24()+temp.getHf24());
					hthTmp.setHf25(hthTmp.getHf25()+temp.getHf25());
					hthTmp.setHf26(hthTmp.getHf26()+temp.getHf26());
					hthTmp.setHf27(hthTmp.getHf27()+temp.getHf27());
					hthTmp.setHf28(hthTmp.getHf28()+temp.getHf28());
					hthTmp.setHf29(hthTmp.getHf29()+temp.getHf29());
					hthTmp.setHf30(hthTmp.getHf30()+temp.getHf30());
					hthTmp.setHf31(hthTmp.getHf31()+temp.getHf31());
					hthTmp.setHf32(hthTmp.getHf32()+temp.getHf32());
					hthTmp.setHf33(hthTmp.getHf33()+temp.getHf33());
					hthTmp.setHf34(hthTmp.getHf34()+temp.getHf34());
					hthTmp.setHf35(hthTmp.getHf35()+temp.getHf35());
					hthTmp.setHf36(hthTmp.getHf36()+temp.getHf36());
					hthTmp.setHf37(hthTmp.getHf37()+temp.getHf37());
					hthTmp.setHf38(hthTmp.getHf38()+temp.getHf38());
					hthTmp.setHf39(hthTmp.getHf39()+temp.getHf39());
					hthTmp.setHf40(hthTmp.getHf40()+temp.getHf40());
					//zfs1-30
					hthTmp.setZfs1(hthTmp.getZfs1()+temp.getZfs1());
					hthTmp.setZfs2(hthTmp.getZfs2()+temp.getZfs2());
					hthTmp.setZfs3(hthTmp.getZfs3()+temp.getZfs3());
					hthTmp.setZfs4(hthTmp.getZfs4()+temp.getZfs4());
					hthTmp.setZfs5(hthTmp.getZfs5()+temp.getZfs5());
					hthTmp.setZfs6(hthTmp.getZfs6()+temp.getZfs6());
					hthTmp.setZfs7(hthTmp.getZfs7()+temp.getZfs7());
					hthTmp.setZfs8(hthTmp.getZfs8()+temp.getZfs8());
					hthTmp.setZfs9(hthTmp.getZfs9()+temp.getZfs9());
					hthTmp.setZfs10(hthTmp.getZfs10()+temp.getZfs10());
					hthTmp.setZfs11(hthTmp.getZfs11()+temp.getZfs11());
					hthTmp.setZfs12(hthTmp.getZfs12()+temp.getZfs12());
					hthTmp.setZfs13(hthTmp.getZfs13()+temp.getZfs13());
					hthTmp.setZfs14(hthTmp.getZfs14()+temp.getZfs14());
					hthTmp.setZfs15(hthTmp.getZfs15()+temp.getZfs15());
					hthTmp.setZfs16(hthTmp.getZfs16()+temp.getZfs16());
					hthTmp.setZfs17(hthTmp.getZfs17()+temp.getZfs17());
					hthTmp.setZfs18(hthTmp.getZfs18()+temp.getZfs18());
					hthTmp.setZfs19(hthTmp.getZfs19()+temp.getZfs19());
					hthTmp.setZfs20(hthTmp.getZfs20()+temp.getZfs20());
					hthTmp.setZfs21(hthTmp.getZfs21()+temp.getZfs21());
					hthTmp.setZfs22(hthTmp.getZfs22()+temp.getZfs22());
					hthTmp.setZfs23(hthTmp.getZfs23()+temp.getZfs23());
					hthTmp.setZfs24(hthTmp.getZfs24()+temp.getZfs24());
					hthTmp.setZfs25(hthTmp.getZfs25()+temp.getZfs25());
					hthTmp.setZfs26(hthTmp.getZfs26()+temp.getZfs26());
					hthTmp.setZfs27(hthTmp.getZfs27()+temp.getZfs27());
					hthTmp.setZfs28(hthTmp.getZfs28()+temp.getZfs28());
					hthTmp.setZfs29(hthTmp.getZfs29()+temp.getZfs29());
					hthTmp.setZfs30(hthTmp.getZfs30()+temp.getZfs30());
					//btfee1-10Butie
					hthTmp.setBtfee1(new BigDecimal(hthTmp.getBtfee1()).add(new BigDecimal(temp.getBtfee1())).doubleValue());
					hthTmp.setBtfee2(new BigDecimal(hthTmp.getBtfee2()).add(new BigDecimal(temp.getBtfee2())).doubleValue());
					hthTmp.setBtfee3(new BigDecimal(hthTmp.getBtfee3()).add(new BigDecimal(temp.getBtfee3())).doubleValue());
					hthTmp.setBtfee4(new BigDecimal(hthTmp.getBtfee4()).add(new BigDecimal(temp.getBtfee4())).doubleValue());
					hthTmp.setBtfee5(new BigDecimal(hthTmp.getBtfee5()).add(new BigDecimal(temp.getBtfee5())).doubleValue());
					hthTmp.setBtfee6(new BigDecimal(hthTmp.getBtfee6()).add(new BigDecimal(temp.getBtfee6())).doubleValue());
					hthTmp.setBtfee7(new BigDecimal(hthTmp.getBtfee7()).add(new BigDecimal(temp.getBtfee7())).doubleValue());
					hthTmp.setBtfee8(new BigDecimal(hthTmp.getBtfee8()).add(new BigDecimal(temp.getBtfee8())).doubleValue());
					hthTmp.setBtfee9(new BigDecimal(hthTmp.getBtfee9()).add(new BigDecimal(temp.getBtfee9())).doubleValue());
					hthTmp.setBtfee10(new BigDecimal(hthTmp.getBtfee10()).add(new BigDecimal(temp.getBtfee10())).doubleValue());

					//Butie1-10
					hthTmp.setButie1(hthTmp.getButie1()+temp.getButie1());
					hthTmp.setButie2(hthTmp.getButie2()+temp.getButie2());
					hthTmp.setButie3(hthTmp.getButie3()+temp.getButie3());
					hthTmp.setButie4(hthTmp.getButie4()+temp.getButie4());
					hthTmp.setButie5(hthTmp.getButie5()+temp.getButie5());
					hthTmp.setButie6(hthTmp.getButie6()+temp.getButie6());
					hthTmp.setButie7(hthTmp.getButie7()+temp.getButie7());
					hthTmp.setButie8(hthTmp.getButie8()+temp.getButie8());
					hthTmp.setButie9(hthTmp.getButie9()+temp.getButie9());
					hthTmp.setButie10(hthTmp.getButie10()+temp.getButie10());
					//Btjy1-10
					hthTmp.setBtjy1(hthTmp.getBtjy1()+temp.getBtjy1());
					hthTmp.setBtjy2(hthTmp.getBtjy2()+temp.getBtjy2());
					hthTmp.setBtjy3(hthTmp.getBtjy3()+temp.getBtjy3());
					hthTmp.setBtjy4(hthTmp.getBtjy4()+temp.getBtjy4());
					hthTmp.setBtjy5(hthTmp.getBtjy5()+temp.getBtjy5());
					hthTmp.setBtjy6(hthTmp.getBtjy6()+temp.getBtjy6());
					hthTmp.setBtjy7(hthTmp.getBtjy7()+temp.getBtjy7());
					hthTmp.setBtjy8(hthTmp.getBtjy8()+temp.getBtjy8());
					hthTmp.setBtjy9(hthTmp.getBtjy9()+temp.getBtjy9());
					hthTmp.setBtjy10(hthTmp.getBtjy10()+temp.getBtjy10());
					
					//hthzfs1-20
					hthTmp.setHthzfs1(hthTmp.getHthzfs1()+temp.getHthzfs1());
					hthTmp.setHthzfs2(hthTmp.getHthzfs2()+temp.getHthzfs2());
					hthTmp.setHthzfs3(hthTmp.getHthzfs3()+temp.getHthzfs3());
					hthTmp.setHthzfs4(hthTmp.getHthzfs4()+temp.getHthzfs4());
					hthTmp.setHthzfs5(hthTmp.getHthzfs5()+temp.getHthzfs5());
					hthTmp.setHthzfs6(hthTmp.getHthzfs6()+temp.getHthzfs6());
					hthTmp.setHthzfs7(hthTmp.getHthzfs7()+temp.getHthzfs7());
					hthTmp.setHthzfs8(hthTmp.getHthzfs8()+temp.getHthzfs8());
					hthTmp.setHthzfs9(hthTmp.getHthzfs9()+temp.getHthzfs9());
					hthTmp.setHthzfs10(hthTmp.getHthzfs10()+temp.getHthzfs10());
					hthTmp.setHthzfs11(hthTmp.getHthzfs11()+temp.getHthzfs11());
					hthTmp.setHthzfs12(hthTmp.getHthzfs12()+temp.getHthzfs12());
					hthTmp.setHthzfs13(hthTmp.getHthzfs13()+temp.getHthzfs13());
					hthTmp.setHthzfs14(hthTmp.getHthzfs14()+temp.getHthzfs14());
					hthTmp.setHthzfs15(hthTmp.getHthzfs15()+temp.getHthzfs15());
					hthTmp.setHthzfs16(hthTmp.getHthzfs16()+temp.getHthzfs16());
					hthTmp.setHthzfs17(hthTmp.getHthzfs17()+temp.getHthzfs17());
					hthTmp.setHthzfs18(hthTmp.getHthzfs18()+temp.getHthzfs18());
					hthTmp.setHthzfs19(hthTmp.getHthzfs19()+temp.getHthzfs19());
					hthTmp.setHthzfs20(hthTmp.getHthzfs20()+temp.getHthzfs20());
					
					//hthzfsc1-20
					hthTmp.setHthzfc1(hthTmp.getHthzfc1()+temp.getHthzfc1());
					hthTmp.setHthzfc2(hthTmp.getHthzfc2()+temp.getHthzfc2());
					hthTmp.setHthzfc3(hthTmp.getHthzfc3()+temp.getHthzfc3());
					hthTmp.setHthzfc4(hthTmp.getHthzfc4()+temp.getHthzfc4());
					hthTmp.setHthzfc5(hthTmp.getHthzfc5()+temp.getHthzfc5());
					hthTmp.setHthzfc6(hthTmp.getHthzfc6()+temp.getHthzfc6());
					hthTmp.setHthzfc7(hthTmp.getHthzfc7()+temp.getHthzfc7());
					hthTmp.setHthzfc8(hthTmp.getHthzfc8()+temp.getHthzfc8());
					hthTmp.setHthzfc9(hthTmp.getHthzfc9()+temp.getHthzfc9());
					hthTmp.setHthzfc10(hthTmp.getHthzfc10()+temp.getHthzfc10());
					hthTmp.setHthzfc11(hthTmp.getHthzfc11()+temp.getHthzfc11());
					hthTmp.setHthzfc12(hthTmp.getHthzfc12()+temp.getHthzfc12());
					hthTmp.setHthzfc13(hthTmp.getHthzfc13()+temp.getHthzfc13());
					hthTmp.setHthzfc14(hthTmp.getHthzfc14()+temp.getHthzfc14());
					hthTmp.setHthzfc15(hthTmp.getHthzfc15()+temp.getHthzfc15());
					hthTmp.setHthzfc16(hthTmp.getHthzfc16()+temp.getHthzfc16());
					hthTmp.setHthzfc17(hthTmp.getHthzfc17()+temp.getHthzfc17());
					hthTmp.setHthzfc18(hthTmp.getHthzfc18()+temp.getHthzfc18());
					hthTmp.setHthzfc19(hthTmp.getHthzfc19()+temp.getHthzfc19());
					hthTmp.setHthzfc20(hthTmp.getHthzfc20()+temp.getHthzfc20());
					
					hthTmp.setFjf(hthTmp.getFjf()+temp.getFjf());
					hthTmp.setFuf(hthTmp.getFuf()+temp.getFuf());
					hthTmp.setHf(hthTmp.getHf()+temp.getHf());
					hthTmp.setZfs(hthTmp.getZfs()+temp.getZfs());
					hthTmp.setHthzfs(hthTmp.getHthzfs()+temp.getHthzfs());
					hthTmp.setHeji(hthTmp.getHeji()+temp.getHeji());
					hthTmp.setButie(hthTmp.getButie()+temp.getButie());
					hthTmp.setBtheji(hthTmp.getBtheji()+temp.getBtheji());
					hthTmp.setBtjy(hthTmp.getBtjy()+temp.getBtjy());
					
				}else{
					hthTmp = new HthhfHzTmp();
					hthTmp.setKemu(kemu);
					hthTmp.setHth(hth);
					hthTmp.setHzyf(Integer.parseInt(hzyf));
					hthTmp.setHzsj(new Date());
					hthTmp.setHzqx(mxmonth.getHzqj());
					if(temp.getDh() != null){
						hthTmp.setDhsl(hthTmp.getDhsl()+1);
					}
					//hc1-40
					hthTmp.setHc1(temp.getHc1());
					hthTmp.setHc2(temp.getHc2());
					hthTmp.setHc3(temp.getHc3());
					hthTmp.setHc4(temp.getHc4());
					hthTmp.setHc5(temp.getHc5());
					hthTmp.setHc6(temp.getHc6());
					hthTmp.setHc7(temp.getHc7());
					hthTmp.setHc8(temp.getHc8());
					hthTmp.setHc9(temp.getHc9());
					hthTmp.setHc10(temp.getHc10());
					hthTmp.setHc11(temp.getHc11());
					hthTmp.setHc12(temp.getHc12());
					hthTmp.setHc13(temp.getHc13());
					hthTmp.setHc14(temp.getHc14());
					hthTmp.setHc15(temp.getHc15());
					hthTmp.setHc16(temp.getHc16());
					hthTmp.setHc17(temp.getHc17());
					hthTmp.setHc18(temp.getHc18());
					hthTmp.setHc19(temp.getHc19());
					hthTmp.setHc20(temp.getHc20());
					hthTmp.setHc21(temp.getHc21());
					hthTmp.setHc22(temp.getHc22());
					hthTmp.setHc23(temp.getHc23());
					hthTmp.setHc24(temp.getHc24());
					hthTmp.setHc25(temp.getHc25());
					hthTmp.setHc26(temp.getHc26());
					hthTmp.setHc27(temp.getHc27());
					hthTmp.setHc28(temp.getHc28());
					hthTmp.setHc29(temp.getHc29());
					hthTmp.setHc30(temp.getHc30());
					hthTmp.setHc31(temp.getHc31());
					hthTmp.setHc32(temp.getHc32());
					hthTmp.setHc33(temp.getHc33());
					hthTmp.setHc34(temp.getHc34());
					hthTmp.setHc35(temp.getHc35());
					hthTmp.setHc36(temp.getHc36());
					hthTmp.setHc37(temp.getHc37());
					hthTmp.setHc38(temp.getHc38());
					hthTmp.setHc39(temp.getHc39());
					hthTmp.setHc40(temp.getHc40());
					//hf1-40
					hthTmp.setHf1(temp.getHf1());
					hthTmp.setHf2(temp.getHf2());
					hthTmp.setHf3(temp.getHf3());
					hthTmp.setHf4(temp.getHf4());
					hthTmp.setHf5(temp.getHf5());
					hthTmp.setHf6(temp.getHf6());
					hthTmp.setHf7(temp.getHf7());
					hthTmp.setHf8(temp.getHf8());
					hthTmp.setHf9(temp.getHf9());
					hthTmp.setHf10(temp.getHf10());
					hthTmp.setHf11(temp.getHf11());
					hthTmp.setHf12(temp.getHf12());
					hthTmp.setHf13(temp.getHf13());
					hthTmp.setHf14(temp.getHf14());
					hthTmp.setHf15(temp.getHf15());
					hthTmp.setHf16(temp.getHf16());
					hthTmp.setHf17(temp.getHf17());
					hthTmp.setHf18(temp.getHf18());
					hthTmp.setHf19(temp.getHf19());
					hthTmp.setHf20(temp.getHf20());
					hthTmp.setHf21(temp.getHf21());
					hthTmp.setHf22(temp.getHf22());
					hthTmp.setHf23(temp.getHf23());
					hthTmp.setHf24(temp.getHf24());
					hthTmp.setHf25(temp.getHf25());
					hthTmp.setHf26(temp.getHf26());
					hthTmp.setHf27(temp.getHf27());
					hthTmp.setHf28(temp.getHf28());
					hthTmp.setHf29(temp.getHf29());
					hthTmp.setHf30(temp.getHf30());
					hthTmp.setHf31(temp.getHf31());
					hthTmp.setHf32(temp.getHf32());
					hthTmp.setHf33(temp.getHf33());
					hthTmp.setHf34(temp.getHf34());
					hthTmp.setHf35(temp.getHf35());
					hthTmp.setHf36(temp.getHf36());
					hthTmp.setHf37(temp.getHf37());
					hthTmp.setHf38(temp.getHf38());
					hthTmp.setHf39(temp.getHf39());
					hthTmp.setHf40(temp.getHf40());
					//zfs1-30
					hthTmp.setZfs1(temp.getZfs1());
					hthTmp.setZfs2(temp.getZfs2());
					hthTmp.setZfs3(temp.getZfs3());
					hthTmp.setZfs4(temp.getZfs4());
					hthTmp.setZfs5(temp.getZfs5());
					hthTmp.setZfs6(temp.getZfs6());
					hthTmp.setZfs7(temp.getZfs7());
					hthTmp.setZfs8(temp.getZfs8());
					hthTmp.setZfs9(temp.getZfs9());
					hthTmp.setZfs10(temp.getZfs10());
					hthTmp.setZfs11(temp.getZfs11());
					hthTmp.setZfs12(temp.getZfs12());
					hthTmp.setZfs13(temp.getZfs13());
					hthTmp.setZfs14(temp.getZfs14());
					hthTmp.setZfs15(temp.getZfs15());
					hthTmp.setZfs16(temp.getZfs16());
					hthTmp.setZfs17(temp.getZfs17());
					hthTmp.setZfs18(temp.getZfs18());
					hthTmp.setZfs19(temp.getZfs19());
					hthTmp.setZfs20(temp.getZfs20());
					hthTmp.setZfs21(temp.getZfs21());
					hthTmp.setZfs22(temp.getZfs22());
					hthTmp.setZfs23(temp.getZfs23());
					hthTmp.setZfs24(temp.getZfs24());
					hthTmp.setZfs25(temp.getZfs25());
					hthTmp.setZfs26(temp.getZfs26());
					hthTmp.setZfs27(temp.getZfs27());
					hthTmp.setZfs28(temp.getZfs28());
					hthTmp.setZfs29(temp.getZfs29());
					hthTmp.setZfs30(temp.getZfs30());
					//btfee1-10Butie
					hthTmp.setBtfee1(temp.getBtfee1());
					hthTmp.setBtfee2(temp.getBtfee2());
					hthTmp.setBtfee3(temp.getBtfee3());
					hthTmp.setBtfee4(temp.getBtfee4());
					hthTmp.setBtfee5(temp.getBtfee5());
					hthTmp.setBtfee6(temp.getBtfee6());
					hthTmp.setBtfee7(temp.getBtfee7());
					hthTmp.setBtfee8(temp.getBtfee8());
					hthTmp.setBtfee9(temp.getBtfee9());
					hthTmp.setBtfee10(temp.getBtfee10());
					//Butie1-10
					hthTmp.setButie1(temp.getButie1());
					hthTmp.setButie2(temp.getButie2());
					hthTmp.setButie3(temp.getButie3());
					hthTmp.setButie4(temp.getButie4());
					hthTmp.setButie5(temp.getButie5());
					hthTmp.setButie6(temp.getButie6());
					hthTmp.setButie7(temp.getButie7());
					hthTmp.setButie8(temp.getButie8());
					hthTmp.setButie9(temp.getButie9());
					hthTmp.setButie10(temp.getButie10());
					//Btjy1-10
					hthTmp.setBtjy1(temp.getBtjy1());
					hthTmp.setBtjy2(temp.getBtjy2());
					hthTmp.setBtjy3(temp.getBtjy3());
					hthTmp.setBtjy4(temp.getBtjy4());
					hthTmp.setBtjy5(temp.getBtjy5());
					hthTmp.setBtjy6(temp.getBtjy6());
					hthTmp.setBtjy7(temp.getBtjy7());
					hthTmp.setBtjy8(temp.getBtjy8());
					hthTmp.setBtjy9(temp.getBtjy9());
					hthTmp.setBtjy10(temp.getBtjy10());
					
					//hthzfs1-20
					hthTmp.setHthzfs1(temp.getHthzfs1());
					hthTmp.setHthzfs2(temp.getHthzfs2());
					hthTmp.setHthzfs3(temp.getHthzfs3());
					hthTmp.setHthzfs4(temp.getHthzfs4());
					hthTmp.setHthzfs5(temp.getHthzfs5());
					hthTmp.setHthzfs6(temp.getHthzfs6());
					hthTmp.setHthzfs7(temp.getHthzfs7());
					hthTmp.setHthzfs8(temp.getHthzfs8());
					hthTmp.setHthzfs9(temp.getHthzfs9());
					hthTmp.setHthzfs10(temp.getHthzfs10());
					hthTmp.setHthzfs11(temp.getHthzfs11());
					hthTmp.setHthzfs12(temp.getHthzfs12());
					hthTmp.setHthzfs13(temp.getHthzfs13());
					hthTmp.setHthzfs14(temp.getHthzfs14());
					hthTmp.setHthzfs15(temp.getHthzfs15());
					hthTmp.setHthzfs16(temp.getHthzfs16());
					hthTmp.setHthzfs17(temp.getHthzfs17());
					hthTmp.setHthzfs18(temp.getHthzfs18());
					hthTmp.setHthzfs19(temp.getHthzfs19());
					hthTmp.setHthzfs20(temp.getHthzfs20());
					
					//hthzfc1-20
					hthTmp.setHthzfc1(temp.getHthzfc1());
					hthTmp.setHthzfc2(temp.getHthzfc2());
					hthTmp.setHthzfc3(temp.getHthzfc3());
					hthTmp.setHthzfc4(temp.getHthzfc4());
					hthTmp.setHthzfc5(temp.getHthzfc5());
					hthTmp.setHthzfc6(temp.getHthzfc6());
					hthTmp.setHthzfc7(temp.getHthzfc7());
					hthTmp.setHthzfc8(temp.getHthzfc8());
					hthTmp.setHthzfc9(temp.getHthzfc9());
					hthTmp.setHthzfc10(temp.getHthzfc10());
					hthTmp.setHthzfc11(temp.getHthzfc11());
					hthTmp.setHthzfc12(temp.getHthzfc12());
					hthTmp.setHthzfc13(temp.getHthzfc13());
					hthTmp.setHthzfc14(temp.getHthzfc14());
					hthTmp.setHthzfc15(temp.getHthzfc15());
					hthTmp.setHthzfc16(temp.getHthzfc16());
					hthTmp.setHthzfc17(temp.getHthzfc17());
					hthTmp.setHthzfc18(temp.getHthzfc18());
					hthTmp.setHthzfc19(temp.getHthzfc19());
					hthTmp.setHthzfc20(temp.getHthzfc20());
					
					hthTmp.setFjf(temp.getFjf());
					hthTmp.setFuf(temp.getFuf());
					hthTmp.setHf(temp.getHf());
					hthTmp.setZfs(temp.getZfs());
					hthTmp.setHthzfs(temp.getHthzfs());
					hthTmp.setHeji(temp.getHeji());
					hthTmp.setButie(temp.getButie());
					hthTmp.setBtheji(temp.getBtheji());
					hthTmp.setBtjy(temp.getBtjy());
					
				}
				map.put(kemu+hth, hthTmp);
			}
			
			//初始化话费转移数据
			Object[] params = new Object[]{hzyf,hzyf};
			String sql = "select  NewHth,sum(BtHeji) BtHeji from Ywsl_DhGuohu where IfGuohu=1 and Ghyf=? and Hzyf<? group by NewHth";
			List<YwslDhGuoHu> ghList1 = DBUtil.queryBeanList(conn, sql, YwslDhGuoHu.class, params);
			sql = "select  OldHth,sum(BtHeji) BtHeji from Ywsl_DhGuohu where IfGuohu=1 and Ghyf=? and Hzyf<? group by OldHth";
			List<YwslDhGuoHu> ghList2 = DBUtil.queryBeanList(conn, sql, YwslDhGuoHu.class, params);
			sql = "select  NewHth,sum(BtHeji) BtHeji from Ywsl_DhGuohu where IfGuohu=0 and Ghyf=? and Hzyf=? group by NewHth";
			List<YwslDhGuoHu> ghList3 = DBUtil.queryBeanList(conn, sql, YwslDhGuoHu.class, params);
			sql = "select  OldHth,sum(BtHeji) BtHeji from Ywsl_DhGuohu where IfGuohu=0 and Ghyf=? and Hzyf=? group by OldHth";
			List<YwslDhGuoHu> ghList4 = DBUtil.queryBeanList(conn, sql, YwslDhGuoHu.class, params);
			YwslDhGuoHu gh = null;
			
			for(Entry<String, HthhfHzTmp> entry:map.entrySet()){
				HthhfHzTmp tmp = entry.getValue();
				//更新用户名称，单位等信息
				//h.Dh,h.Yhmc,h.Bm1,h.Bm2,h.Bm3,h.Bm4,h.Bmbh,h.Area,
	            //h.ZnjBz,h.yhxz,h.Sflx,h.HthMfjb,h.HthDjjb,h.DjHth
				if(hthdangHzMap.containsKey(tmp.getHth())){
					HthdangHz hdh = hthdangHzMap.get(tmp.getHth());
					tmp.setDh(hdh.getDh());
					tmp.setYhmc(hdh.getYhmc());
					tmp.setBm1(hdh.getBm1());
					tmp.setBm2(hdh.getBm2());
					tmp.setBm3(hdh.getBm3());
					tmp.setBm4(hdh.getBm4());
					tmp.setBmbh(hdh.getBmbh());
					tmp.setArea(hdh.getArea());
					tmp.setZnjbz(hdh.getZnjbz());
					tmp.setYhxz(hdh.getYhlb());
					tmp.setSflx(hdh.getSflx());
					tmp.setHthmfjb(hdh.getHthmfjb());
					tmp.setHthdjjb(hdh.getHthdjjb());
					tmp.setDjhth(hdh.getBz9());
				}
				//合同号话费减免
				tmp = hthCalculateBillRelief(tmp,freeGradeMap,butieitemList,hthhfHzPreList,hzyfmm);
				//将转移到新户的旧月费用加到新户的新月
				if(ghList1 != null && ghList1.size() > 0){
					for(int i=0;i<ghList1.size();i++){
						gh = ghList1.get(i);
						if(tmp.getHth().equals(gh.getNewhth())){
							tmp.setGuohu(gh.getBtheji());
							tmp.setBtheji(tmp.getBtheji()+gh.getBtheji());
						}
					}
				}
				//将转移到新户的旧月费用从旧户的新月费用中扣除
				if(ghList2 != null && ghList2.size() > 0){
					for(int i=0;i<ghList2.size();i++){
						gh = ghList2.get(i);
						if(tmp.getHth().equals(gh.getNewhth())){
							tmp.setGuohu(-gh.getBtheji());
							tmp.setBtheji(tmp.getBtheji()-gh.getBtheji());
						}
					}
				}
				//将不转移到新户的新月过户前费用从新户的新月费用中扣除
				if(ghList3 != null && ghList3.size() > 0){
					for(int i=0;i<ghList3.size();i++){
						gh = ghList3.get(i);
						if(tmp.getHth().equals(gh.getNewhth())){
							tmp.setBtheji(tmp.getBtheji()-gh.getBtheji());
						}
					}
				}
				//将不转移到新户的新月过户前费用加到旧户的新月费用中
				if(ghList4 != null && ghList4.size() > 0){
					for(int i=0;i<ghList4.size();i++){
						gh = ghList4.get(i);
						if(tmp.getHth().equals(gh.getNewhth())){
							tmp.setBtheji(tmp.getBtheji()+gh.getBtheji());
						}
					}
				}
				
				list.add(tmp);
				
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("按合同号汇总数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}

	/**
	 * 生成最终汇总数据，并插入到汇总表中
	 * @param huizongTmp	汇总临时数据
	 * @param hthHzTmp		合同号汇总临时数据
	 * @param conn  		数据库连接
	 */
	public void createFinalData(String hthLimit,List<HuizongTmp> huizongTmps, List<HthhfHzTmp> hthHzTmps,List<Bymx> bymxs,int hzyf) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.openConnection();
			conn.setAutoCommit(false);
			//清楚之前汇总的数据
			List<String> sqlList = new ArrayList<String>();
			
			if (hthLimit != null && hthLimit.length()>0){
				
				sqlList.add("DELETE FROM huizong2 WHERE Hzyf="+hzyf+" and hth in"+hthLimit);
				sqlList.add("DELETE FROM hthhf_hz2 WHERE Hzyf="+hzyf+" and hth in"+hthLimit);
				sqlList.add("DELETE FROM bymx2 WHERE bymonth="+hzyf+" and hth in"+hthLimit);
				
			}else{
				
				sqlList.add("DELETE FROM huizong2 WHERE Hzyf="+hzyf);
				sqlList.add("DELETE FROM hthhf_hz2 WHERE Hzyf="+hzyf);
				sqlList.add("DELETE FROM bymx2 WHERE bymonth="+hzyf);
				
			}
			DBUtil.executeAsBatch(conn, sqlList);
			
			//插入huizong表 213个字段
			String sql = "INSERT  INTO huizong2 (hzyf, hzsj, hzqx, hth, dh, kemu, dhid, zlh, mfjb, reg_date, startdate, enddate, tjbz, tjdate,fjdate, yhmc, bm1, bm2, bm3, bm4, bmbh, area, yhxz, sflx, zfs1, zfs2, zfs3, zfs4, zfs5, zfs6, zfs7, zfs8, zfs9, zfs10, zfs11, zfs12, zfs13, zfs14, zfs15, zfs16, zfs17, zfs18, zfs19, zfs20, zfs21, zfs22, zfs23, zfs24, zfs25, zfs26, zfs27, zfs28, zfs29, zfs30, hthzfc1, hthzfc2, hthzfc3, hthzfc4, hthzfc5, hthzfc6, hthzfc7, hthzfc8, hthzfc9, hthzfc10, hthzfc11, hthzfc12, hthzfc13, hthzfc14, hthzfc15, hthzfc16, hthzfc17, hthzfc18, hthzfc19, hthzfc20, hthzfs1, hthzfs2, hthzfs3, hthzfs4, hthzfs5, hthzfs6, hthzfs7, hthzfs8, hthzfs9, hthzfs10, hthzfs11, hthzfs12, hthzfs13, hthzfs14, hthzfs15, hthzfs16, hthzfs17, hthzfs18, hthzfs19, hthzfs20, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12, hc13, hc14, hc15, hc16, hc17, hc18, hc19, hc20, hc21, hc22, hc23, hc24, hc25, hc26, hc27, hc28, hc29, hc30, hc31, hc32, hc33, hc34, hc35, hc36, hc37, hc38, hc39, hc40, hf1, hf2, hf3, hf4, hf5, hf6, hf7, hf8, hf9, hf10, hf11, hf12, hf13, hf14, hf15, hf16, hf17, hf18, hf19, hf20, hf21, hf22, hf23, hf24, hf25, hf26, hf27, hf28, hf29, hf30, hf31, hf32, hf33, hf34, hf35, hf36, hf37, hf38, hf39, hf40, fjf, fuf, zfs, hthzfs, hf, heji, butie, btheji, btjy, btfee1, butie1, btjy1, btfee2, butie2, btjy2, btfee3, butie3, btjy3, btfee4, butie4, btjy4, btfee5, butie5, btjy5, btfee6, butie6, btjy6, btfee7, butie7, btjy7, btfee8, butie8, btjy8, btfee9, butie9, btjy9, btfee10, butie10, btjy10)"
					+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			Field[] fields = HuizongTmp.class.getDeclaredFields();
			for(int i=0;i<huizongTmps.size();i++){
				HuizongTmp temp = huizongTmps.get(i);
				for(int j=0;j<fields.length;j++){
					fields[j].setAccessible(true);
					if(fields[j].getType().getName().equals("java.util.Date")  ){
						if(fields[j].get(temp) != null){
							pstmt.setTimestamp(j+1, new java.sql.Timestamp(((Date)fields[j].get(temp)).getTime()));

						}else{
							pstmt.setDate(j+1, null);
						}
					}else{
						pstmt.setObject(j+1, fields[j].get(temp));
					}
					
				}
				pstmt.addBatch();
				if((i+1) % 100 == 0){
					pstmt.executeBatch();
					pstmt.clearBatch();
				}
			}
			pstmt.executeBatch();
			pstmt.clearBatch();
			//插入hthhf_hz表 226个字段
			sql = "INSERT  INTO hthhf_hz2(hzyf, hzsj, hzqx, hth, kemu, dh, yhmc, bm1, bm2, bm3, bm4, bmbh, yhxz, sflx, area, znjbz, hthmfjb, hthdjjb, djhth, dhsl, zfs1, zfs2, zfs3, zfs4, zfs5, zfs6, zfs7, zfs8, zfs9, zfs10, zfs11, zfs12, zfs13, zfs14, zfs15, zfs16, zfs17, zfs18, zfs19, zfs20, zfs21, zfs22, zfs23, zfs24, zfs25, zfs26, zfs27, zfs28, zfs29, zfs30, hthzfc1, hthzfc2, hthzfc3, hthzfc4, hthzfc5, hthzfc6, hthzfc7, hthzfc8, hthzfc9, hthzfc10, hthzfc11, hthzfc12, hthzfc13, hthzfc14, hthzfc15, hthzfc16, hthzfc17, hthzfc18, hthzfc19, hthzfc20, hthzfs1, hthzfs2, hthzfs3, hthzfs4, hthzfs5, hthzfs6, hthzfs7, hthzfs8, hthzfs9, hthzfs10, hthzfs11, hthzfs12, hthzfs13, hthzfs14, hthzfs15, hthzfs16, hthzfs17, hthzfs18, hthzfs19, hthzfs20, hc1, hc2, hc3, hc4, hc5, hc6, hc7, hc8, hc9, hc10, hc11, hc12, hc13, hc14, hc15, hc16, hc17, hc18, hc19, hc20, hc21, hc22, hc23, hc24, hc25, hc26, hc27, hc28, hc29, hc30, hc31, hc32, hc33, hc34, hc35, hc36, hc37, hc38, hc39, hc40, hf1, hf2, hf3, hf4, hf5, hf6, hf7, hf8, hf9, hf10, hf11, hf12, hf13, hf14, hf15, hf16, hf17, hf18, hf19, hf20, hf21, hf22, hf23, hf24, hf25, hf26, hf27, hf28, hf29, hf30, hf31, hf32, hf33, hf34, hf35, hf36, hf37, hf38, hf39, hf40, fjf, fuf, zfs, hthzfs, hf, heji, butie, daijiao, daijiaofor, guohu, btheji, btjy, btfee1, butie1, btjy1, daijiao1, btfee2, butie2, btjy2, daijiao2, btfee3, butie3, btjy3, daijiao3, btfee4, butie4, btjy4, daijiao4, btfee5, butie5, btjy5, daijiao5, btfee6, butie6, btjy6, daijiao6, btfee7, butie7, btjy7, daijiao7, btfee8, butie8, btjy8, daijiao8, btfee9, butie9, btjy9, daijiao9, btfee10, butie10, btjy10, daijiao10, syye_ysk, byss, byye_ysk, jmhf)"
					+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			fields = HthhfHzTmp.class.getDeclaredFields();
			for(int i=0;i<hthHzTmps.size();i++){
				HthhfHzTmp temp = hthHzTmps.get(i);
				for(int j=0;j<fields.length;j++){
					fields[j].setAccessible(true);
					if(fields[j].getType().getName().equals("java.util.Date")  ){
						if(fields[j].get(temp) != null){
							pstmt.setTimestamp(j+1, new java.sql.Timestamp(((Date)fields[j].get(temp)).getTime()));
						}else{
							pstmt.setDate(j+1, null);
						}
					}else{
						pstmt.setObject(j+1, fields[j].get(temp));
					}
				}
				pstmt.addBatch();
				if((i+1) % 100 == 0){
					pstmt.executeBatch();
					pstmt.clearBatch();
				}
			}
			pstmt.executeBatch();
			pstmt.clearBatch();
			
			if(bymxs !=null && bymxs.size()>0){
				//插入bymx表 16个字段
				sql = "INSERT  INTO bymx2(hth, dh, dhid, feetype, thlx, thsc, ithsc, hfhj, style, bymonth, givenewfunc, pmode, totalfee, fee, giveheji, pkorder)"
						+ " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				fields = Bymx.class.getDeclaredFields();
				for(int i=0;i<bymxs.size();i++){
					Bymx temp = bymxs.get(i);
					for(int j=0;j<fields.length;j++){
						fields[j].setAccessible(true);
						if(fields[j].getType().getName().equals("java.util.Date")  ){
							if(fields[j].get(temp) != null){
								pstmt.setTimestamp(j+1, new java.sql.Timestamp(((Date)fields[j].get(temp)).getTime()));
							}else{
								pstmt.setDate(j+1, null);
							}
						}else{
							pstmt.setObject(j+1, fields[j].get(temp));
						}
					}
					pstmt.addBatch();
					if((i+1) % 100 == 0){
						pstmt.executeBatch();
						pstmt.clearBatch();
					}
				}
				pstmt.executeBatch();
				pstmt.clearBatch();
			}
			//清空汇总占用表
			sql = "truncate table  Jfgl_HfhzUseing";
			pstmt = conn.prepareStatement(sql);
			pstmt.execute();
			
			conn.commit();
		} catch (Exception e) {
			conn.rollback();
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("生成最终数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, pstmt, null);
		}
	}


	
	/**
	 * 获取用户档汇总信息
	 * @deprecated
	 * @param conn
	 * @param hzyf
	 * @param hthLimit
	 * @param timematch
	 * @return
	 * @throws Exception
	 */
	public List<YhdangHz> getYhdangHzList(Connection conn, String hzyf,
			String hthLimit,boolean timematch) throws Exception{
		
		List<YhdangHz> yhdanghzlist = null;
		String sql = null;
		
		if(timematch){
			
			sql="select hth, jxh, dh, yhmc, bm1, bm2, bm3, bm4, bmbh, yhdz, hwjb, hwjb0, hwjb1, lastadjustdate,"
					+ "callsheduleno, adjustsheduleno, zlh, jflb, mfjb, mima, mima2, reg_date, "
					+ "startdate, enddate, tjbz, tjdate,stopbz, delbz, deldate, dhlx, custtype, "
					+ "jhj_id, dhgn, bz1, bz2, bz3, bz4, bz5, bz6, bz7, bz8, bz9, bz10,mokuaiju, "
					+ "modual, port, typenum,jbkzlx, ywarea, dhid, mobile, creditgrade, creditpoint, usertype FROM yhdang where "+hthLimit;
			
			yhdanghzlist =  DBUtil.queryBeanList(conn,sql,YhdangHz.class);
			
		}else{
			
			sql="select hth, jxh, dh, yhmc, bm1, bm2, bm3, bm4, bmbh, yhdz, hwjb, hwjb0, hwjb1, lastadjustdate,"
					+ "callsheduleno, adjustsheduleno, zlh, jflb, mfjb, mima, mima2, reg_date, "
					+ "startdate, enddate, tjbz, tjdate,stopbz, delbz, deldate, dhlx, custtype, "
					+ "jhj_id, dhgn, bz1, bz2, bz3, bz4, bz5, bz6, bz7, bz8, bz9, bz10,mokuaiju, "
					+ "modual, port, typenum,jbkzlx, ywarea, dhid, mobile, creditgrade, creditpoint, usertype FROM yhdang_billing "
					+ "where billingmonth="+hzyf+" and "+hthLimit;
			
			yhdanghzlist =  DBUtil.queryBeanList(conn,sql,YhdangHz.class);
			
		}
		
		return yhdanghzlist;
	}




	/**
	 * list转map通用方法
	 * @param list
	 * @param key
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public <T> Map<Object,T> listToMap(List<T> list, String key) throws IllegalArgumentException, IllegalAccessException{
		Map<Object,T> map = null;
		if(list != null && list.size() >0){
			map =new HashMap<Object, T>();
			for(int i=0;i<list.size();i++){
				T t = list.get(i);
				Field[] fields = t.getClass().getDeclaredFields();
				
				for(int j=0;j<fields.length;j++){
					fields[j].setAccessible(true);
					if(key.equalsIgnoreCase(fields[j].getName())){
						map.put(fields[j].get(t), t);
					}
				}
			}
		}
		return map;
	}	
	
	


	/**
	 * 获取包月明细数据
	 * @return
	 * @throws Exception
	 */
	public List<Bymx> getBymxList() throws Exception{
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql="select * from bymx";
			return DBUtil.queryBeanList(conn, sql, Bymx.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取包月明细数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 获取科目定义数据
	 * @return
	 * @throws Exception
	 */
	public List<KemuDef> getKemuDefList() throws Exception{
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql="select * from kemudef";
			return DBUtil.queryBeanList(conn, sql, KemuDef.class);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("获取科目定义数据时出现异常","hfhz",userId,"hfhz"), null);
			throw e;
		}finally{
			DBUtil.closeConnection(conn, null, null);
		}
	}
	
	/**
	 * 清除汇总占用表
	 * @throws Exception
	 */
	public void truncateUsingTable(){
		Connection conn = null;
		try {
			conn = DBUtil.openConnection();
			String sql="TRUNCATE TABLE Jfgl_HfhzUseing";
			DBUtil.execute(conn, sql);
		} catch (Exception e) {
			e.printStackTrace();
			Log.writeHzLog(new HfhzLog("清空汇总占用表时出现异常","hfhz",userId,"hfhz"), null);
		}finally{
			try {
				DBUtil.closeConnection(conn, null, null);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
