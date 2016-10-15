package com.tsd.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import com.tsd.dao.DBhelper;
import com.tsd.dao.DataObj;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.HTMLFilter;
import com.tsd.service.util.I18n;

public class phone_querydate extends HttpServlet {
	
	public String sChoose;

	public phone_querydate() {
		super();
	}

	public void destroy() {
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		this.doPost(request, response);
	}
	/**
	 * 静态常量里有"--[choose]--"需要从资源文件里取出值替换
	 * lvkui
	 */
	public String getDataDict(String sKey)
	{
		String sVal;
		sVal = (String)LoadAllDataDict.tableMap.get(sKey);
		if (!sChoose.equals(""))
		{
			sVal = sVal.replace("--[choose]--", "--"+sChoose+"--");
		}
		return sVal; 
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//Connection conn = null;
		//CallableStatement call = null;
		//PreparedStatement ps=null;
		//ResultSet rs_bz2 = null;
		//ResultSet rs_dhlx = null;
		//ResultSet rs_tsdini = null;
		//String paramters="";
		String syhlb="", sdhlx="", sCallPayType="",sznjbz="",sasys_area="",scusttype="",sbz2="";
		String s_pl_type = "";
		String s_pl_endpoint = "";
		
		HttpSession session = request.getSession();
		if (session.getAttribute("userid")==null)
		{
			ClientOutPut.printout(response, "session invalid", "");
			return;
		}
		//工号
		//String sUserID = (String)session.getAttribute("userid");
		//营业区域
		//String sArea = (String)session.getAttribute("chargearea");
		
		//获取国际化资源
		String sLang =(String) session.getAttribute("languageType");
//		I18n i18n = new I18n(sLang,"","");
		Properties props = new Properties();
		props.setProperty("choose", "请选择");
//		i18n.getI18n(props);
		System.out.println(props.getProperty("choose"));
		//将获取到的值赋给成员变量sChoose，供函数getDataDict使用。
		//所以在使用函数getDataDict前必须要取得国际化资源。
		sChoose = props.getProperty("choose");
		props.clear();
		
		//conn = DBhelper.getConnection("tsdboss");//根据配置的数据源获得连接
		//String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
		
		String zd_hthdang = getDataDict("FINAL.hthdang_zh");//合同号当信息
		String zd_yhdang = getDataDict("FINAL.yhdang_zh");//用户当信息
		String zd_yhlb =  getDataDict("FINAL.yhlb");//用户类别
		String zd_CallPayType = getDataDict("FINAL.CallPayType");//付费策略
		String zd_ZnjBz = getDataDict("FINAL.ZnjBz");//滞纳金标志
		String zd_asys_area = getDataDict("FINAL.asys_area");//收费地点
		String zd_custtype = getDataDict("FINAL.custtype");//客户类型
		String zd_yhxz = getDataDict("FINAL.yhxz");//用户性质
		String zd_tjcl = getDataDict("FINAL.Hwjb_Shedule_Base");//调级策略
		String zd_cjcl = getDataDict("FINAL.CallPay_Shedule_Base");//催缴策略
		String zd_dhgn = getDataDict("FINAL.Dhgn");//电话功能
		String zd_ywarea = getDataDict("FINAL.area_ywsl");//业务区域
		String zd_idtype = getDataDict("FINAL.tsd_ini_idtype");//证件类型
		String zd_dhlx = getDataDict("FINAL.Dhlx");//电话类型
		String zd_gdfeetype = getDataDict("FINAL.attachprice");//固定费用类型 月租/特服
		String Zd_bytcfeetype = getDataDict("FINAL.monthfeegroup");//包月套餐
		String zd_yhlb_text = getDataDict("FINAL.yhlb_text");//用户类别只有类别的
		String zd_radpkg_text = getDataDict("dbsql_rad.radpkg");//宽带上网套餐		
		String zd_radAccessType_text = getDataDict("FINAL.tsd_ini_radAccessType");//宽带接入类型
		String zd_radpayitem_text = getDataDict("dbsql_rad.payitem");//宽带付费方式
		String zd_routetype = getDataDict("dbsql_route.GetRouteType");//号线管理-业务类型
		String zd_linemode = getDataDict("dbsql_route.GetLineMode");//号线管理-配线方式
		String zd_objstate = getDataDict("dbsql_route.GetObjState");//号线管理-对象状态
		String zd_attachprice_hth = getDataDict("FINAL.attachprice_hth");//合同号月租表
		String pl_type = getDataDict("FINAL.pl_type"); // 专线类型
		String pl_endpoint = getDataDict("FINAL.pl_endpoint"); // 专线端点
		try
		{		
				// 专线类型
				s_pl_type = "<pl_type=" + pl_type + "pl_type/>";
				// 专线端点
				s_pl_endpoint = "<pl_endpoint=" + pl_endpoint + "pl_endpoint/>";
				//用户类别
				syhlb = "<yhlb="+zd_yhlb+"yhlb/>";
				//电话类型
				sdhlx = "<dhlx="+zd_dhlx+"dhlx/>";
				//付费策略
				sCallPayType = "<CallPayType="+zd_CallPayType+"CallPayType/>";
				//滞纳金标志
				sznjbz = "<znjbz="+zd_ZnjBz+"znjbz/>";
				//收费地点
				sasys_area = "<asys_area="+zd_asys_area+"asys_area/>";
				//客户类型
				scusttype = "<custtype="+zd_custtype+"custtype/>";
				//用户性质
				zd_yhxz = "<yhxz="+zd_yhxz+"yhxz/>";
				//合同号当信息
				zd_hthdang = "<hthdang="+zd_hthdang+"hthdang/>";
				//用户当信息
				zd_yhdang = "<yhdang="+zd_yhdang+"yhdang/>";
				//调级策略
				zd_tjcl = "<AdjustSheduleNo="+zd_tjcl+"AdjustSheduleNo/>";
				//催缴策略
				zd_cjcl = "<CallSheduleNo="+zd_cjcl+"CallSheduleNo/>";
				//电话功能
				zd_dhgn = "<dhgn="+zd_dhgn+"dhgn/>";
				//业务区域
				zd_ywarea = "<ywarea="+zd_ywarea+"ywarea/>";
				//证件类型
				zd_idtype = "<idtype="+zd_idtype+"idtype/>";
				//固定费用
				zd_gdfeetype = "<gdfeetype="+zd_gdfeetype+"gdfeetype/>";
				//包月套餐
				Zd_bytcfeetype = "<bytcfeetype="+Zd_bytcfeetype+"bytcfeetype/>";
				//合同号月租
				zd_attachprice_hth = "<attachprice_hth="+zd_attachprice_hth+"attachprice_hth/>";
				//用户类别只有中文类别没有ID值
				zd_yhlb_text = "<yhlb_text="+zd_yhlb_text+"yhlb_text/>";
				zd_radpkg_text = "<radpkg="+zd_radpkg_text+"radpkg/>";				
				zd_radAccessType_text = "<radacc="+zd_radAccessType_text+"radacc/>";
				zd_radpayitem_text = "<radpayitem="+zd_radpayitem_text+"radpayitem/>";		
				zd_routetype = "<routetype="+zd_routetype+"routetype/>";
				zd_linemode = "<linemode="+zd_linemode+"linemode/>";
				zd_objstate = "<objstate="+zd_objstate+"objstate/>";
				ClientOutPut.printout(response, 
						zd_hthdang+zd_yhdang+syhlb+sdhlx+
						sCallPayType+sznjbz+sasys_area+
						scusttype+sbz2+zd_yhxz+zd_tjcl+
						zd_cjcl+zd_dhgn+zd_ywarea+
						zd_idtype+zd_gdfeetype+Zd_bytcfeetype+
						zd_yhlb_text+zd_radpkg_text+zd_radAccessType_text+
						zd_radpayitem_text+zd_routetype+zd_linemode+
						zd_objstate+zd_attachprice_hth+
						s_pl_type+s_pl_endpoint, "");								

		//} catch (SQLException e) {
		} catch (Exception e) {
			sdhlx = "<dhlx="+"FAILED:"+e+"dhlx/>";
			syhlb = "<yhlb="+"FAILED:"+e+"yhlb/>";
			sCallPayType = "<CallPayType="+"FAILED:"+e+"CallPayType/>";
			sznjbz = "<znjbz="+"FAILED:"+e+"znjbz/>";
			sasys_area = "<asys_area="+"FAILED:"+e+"asys_area/>";
			scusttype = "<custtype="+"FAILED:"+e+"custtype/>";
			zd_yhxz = "<yhxz="+"FAILED:"+e+"yhxz/>";
			zd_hthdang = "<hthdang="+"FAILED:"+e+"hthdang/>";
			zd_yhdang = "<yhdang="+"FAILED:"+e+"yhdang/>";
			zd_tjcl = "<AdjustSheduleNo="+"FAILED:"+e+"AdjustSheduleNo/>";
			zd_cjcl = "<CallSheduleNo="+"FAILED:"+e+"CallSheduleNo/>";
			zd_dhgn = "<dhgn="+"FAILED:"+e+"dhgn/>";
			zd_ywarea = "<ywarea="+"FAILED:"+e+"ywarea/>";
			zd_idtype = "<idtype="+"FAILED:"+e+"idtype/>";
			zd_gdfeetype = "<gdfeetype="+"FAILED:"+e+"gdfeetype/>";
			Zd_bytcfeetype = "<bytcfeetype="+"FAILED:"+e+"bytcfeetype/>";
			zd_yhlb_text = "<yhlb_text="+"FAILED:"+e+"yhlb_text/>";
			zd_radpkg_text = "<radpkg="+"FAILED:"+e+"radpkg/>";				
			zd_radAccessType_text = "<radacc="+"FAILED:"+e+"radacc/>";
			zd_radpayitem_text = "<radpayitem="+"FAILED:"+e+"radpayitem/>";	
			zd_routetype = "<routetype="+zd_routetype+"routetype/>";
			zd_linemode = "<linemode="+zd_linemode+"linemode/>";	
			zd_objstate = "<objstate="+zd_objstate+"objstate/>";
			ClientOutPut.printout(response, zd_hthdang+zd_yhdang+syhlb+sdhlx+sCallPayType+sznjbz+sasys_area+scusttype+sbz2+zd_yhxz+zd_tjcl+zd_cjcl+zd_dhgn+zd_ywarea+zd_idtype+zd_gdfeetype+Zd_bytcfeetype+zd_yhlb_text+zd_radpkg_text+zd_radAccessType_text+zd_radpayitem_text+zd_routetype+zd_linemode+zd_objstate, "");
			throw new RuntimeException("request exception:" + e);			
		} finally {
/*			try {
				if (rs_dhlx != null) {
					rs_dhlx.close();
					rs_dhlx=null;
				}
				if (rs_bz2 != null) {
					rs_bz2.close();
					rs_bz2=null;
				}
				if (call != null) {
					call.close();
					call=null;
				}
				if(conn !=null){
					conn.close();
					conn=null;
				}
				
			} catch (SQLException e) {
				throw new RuntimeException("close database exception:" + e);
			}*/
		}
			
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
