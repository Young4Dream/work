package com.tsd.web.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
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
import com.tsd.entity.KemuDef;
import com.tsd.entity.Mxmonth;
import com.tsd.entity.OtherDhedit;
import com.tsd.entity.Teljob;
import com.tsd.entity.Yhlb;
import com.tsd.service.IHuiZong;
import com.tsd.service.IHuiZongImpls;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.Log;

/**
 * 话费汇总控制类 2015-10-14
 * 
 * @author tsd
 * 
 */
public class HzServlet extends HttpServlet {
	/** 汇总月份str **/
	private String hzyf;
	/** 汇总月份int **/
	private int ihzyf;
	/** 汇总合同号 **/
	private String hthLimit;
	/** 操作员ID **/
	private String userId;
	/** 数据库名称 **/
	private String ds;
	/** 用户类别 **/
	private String yhlb;
	
	private boolean monthMatch = false;
	private String dataSourceName;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 获取页面传来的参数
		getParameters(request,response);
//		System.out.println("UserId:"+userId+" ,Ds:"+ds+",hthLimit:"+hthLimit+" ,yhlb:"+yhlb+" ,Hzyf:"+hzyf);
		 //开始汇总
		huiZong(request,response);
		
	}

	private  void huiZong(HttpServletRequest request,HttpServletResponse response) {
		// 初始化工具类
		IHuiZong huizong = new IHuiZongImpls();
		
		try {
			Log.writeHzLog(new HfhzLog("开始汇总，参数：【汇总月份:"+hzyf+",操作员:"+userId+",汇总条件:"+hthLimit+"】","hfhz",userId,"hfhz"), dataSourceName);
			
			// 获取数据库时间
			Date dbTime = huizong.getDbTime();
			if(dbTime == null){
				Log.writeHzLog(new HfhzLog("获取数据库时间失败，汇总程序退出！","hfhz",userId,"hfhz"), null);
				ClientOutPut.printout(response, "fail", "");
				return ;
			}
			//判断汇总月份是否为当前月 
			SimpleDateFormat yyyyMM = new SimpleDateFormat("yyyyMM");
			SimpleDateFormat MM = new SimpleDateFormat("MM");
			String nowDate = yyyyMM.format(dbTime);
			if(nowDate.equals(hzyf)){
				monthMatch = true;
			}
			
			//汇总显示方式为 月份
			String hzyfmm = MM.format(MM.parse(hzyf));
			//获取汇总月份的上个月
			Date dhzyf = yyyyMM.parse(hzyf);
			Calendar cal = Calendar.getInstance();
	        cal.setTime(dhzyf);
	        cal.add(Calendar.MONTH, -1);
	        String pre = yyyyMM.format(cal.getTime());
	        int prehzyf = Integer.parseInt(pre);
			
			//根据汇总月份获取当月或历史月合同号用户类别
			if(yhlb != null){
				if(monthMatch){
					hthLimit = "(SELECT hth FROM hthdang WHERE yhlb IN (SELECT yhlb FROM yhlb WHERE ID IN "+yhlb+" ))";
				}else {
					hthLimit = "(SELECT hth FROM hthdang_billing WHERE billingmonth= '"+ihzyf+"' "
							+ "AND yhlb IN (SELECT yhlb FROM yhlb WHERE ID IN "+yhlb+" ) )";
				}
			}
			
			// 检查是否有其他人正在汇总
			boolean isUsing = huizong.checkUsing(userId, dbTime);
			if(!isUsing){
				Log.writeHzLog(new HfhzLog("其他用户正在进行汇总，请15分钟后尝试！","hfhz",userId,"hfhz"), null);
				ClientOutPut.printout(response, "fail", "");
				return;
			}
			
			// 检查是否存在汇总的起、 止时间
			Log.writeHzLog(new HfhzLog("检查汇总起始时间配置","hfhz",userId,"hfhz"), null);
			Mxmonth mxmonth = huizong.checkStartAndEndTime(hzyf);
			if(mxmonth == null || mxmonth.getBegindate() == null || mxmonth.getEnddate() == null){
				huizong.truncateUsingTable();
				Log.writeHzLog(new HfhzLog("汇总月起始时间参数设置无效,汇总退出","hfhz",userId,"hfhz"), null);
				ClientOutPut.printout(response, "fail", "");
				return;
			}
			
			// 清除90天以前做拆机标志的电话 
			Log.writeHzLog(new HfhzLog("清除90天以前拆机电话","hfhz",userId,"hfhz"), null);
			huizong.cleanDhByTag();
			
			//========================================== 准备基础数据STSRT ================================================
			
			//1.获取合同号档汇总信息
			Log.writeHzLog(new HfhzLog("获取合同号档数据","hfhz",userId,"hfhz"), null);
			List<HthdangHz> hthdangHzList = huizong.getHthdangHzList(hzyf, hthLimit, monthMatch);
			if(hthdangHzList == null || hthdangHzList.size() <=0){
				huizong.truncateUsingTable();
				Log.writeHzLog(new HfhzLog("获取合同号档数据失败，程序退出...","hfhz",userId,"hfhz"), null);
				ClientOutPut.printout(response, "fail", "");
				return ;
			}
			
			//2.获取汇总区间的用户档数据
			Log.writeHzLog(new HfhzLog("获取用户档数据","hfhz",userId,"hfhz"), null);
			List<HuizongTmp> huizongTmpList = huizong.getHuizongTmpList(mxmonth, hthLimit, monthMatch);
			
			if(huizongTmpList == null || huizongTmpList.size() <=0){
				huizong.truncateUsingTable();
				Log.writeHzLog(new HfhzLog("获取合同号档数据失败，程序退出...","hfhz",userId,"hfhz"), null);
				ClientOutPut.printout(response, "fail", "");
				return ;
			}
			
			//3.获取月租数据
			Log.writeHzLog(new HfhzLog("获取月租数据","hfhz",userId,"hfhz"), null);
			List<AttachfeeTemp> attachfeeTempList = huizong.getAttachfeeTempList(mxmonth, hthLimit, monthMatch);
			
			//是否汇总合同号费用
			boolean hthattachfee = huizong.isTrue(LoadProperties.getKeyValues("oracle_hz", "ishthattachfee"));
			List<AttachfeeHthHz> attachfeehthhzlist = null; 
			if(hthattachfee){
			//4.获取合同号月租数据
				Log.writeHzLog(new HfhzLog("获取合同号月租数据","hfhz",userId,"hfhz"), null);
				attachfeehthhzlist = huizong.getAttachfeeHthHzList(mxmonth, hthLimit, monthMatch);
			}
			
			//是否汇总工单费用
			boolean teljobfee = huizong.isTrue(LoadProperties.getKeyValues("oracle_hz", "isteljobfee"));
			List<Teljob> teljobList = null;
			if (teljobfee){
			//5.生成工单表数据
				Log.writeHzLog(new HfhzLog("获取工单数据","hfhz",userId,"hfhz"), null);
				teljobList = huizong.getTeljobList(hzyf,hthLimit);
			} 
			
			//6. 获取分拣程序原始话费信息 hf1-hf40
			Log.writeHzLog(new HfhzLog("获取用户话费数据","hfhz",userId,"hfhz"), null);
			List<HuizongHf> huizongHfList = huizong.getHuizongHfList(hzyf,hthLimit,monthMatch);
			
			//7. 获取月租生效规则数据
			Log.writeHzLog(new HfhzLog("获取月租配置规则","hfhz",userId,"hfhz"), null);
			List<HfhzAttachfeeCfg> hfhzAttachfeeCfgList = huizong.getHfhzAttachfeeCfgList();
			
			//8. 获取属于停机标志组的数据
			Log.writeHzLog(new HfhzLog("获取停机标志组数据","hfhz",userId,"hfhz"), null);
			List<String> tjbzGroupList = huizong.getTjbzGroupList();
			
			//9. 获取用户类别配置表数据
			Log.writeHzLog(new HfhzLog("获取用户类别表数据","hfhz",userId,"hfhz"), null);
			List<Yhlb> yhlbList = huizong.getYhlbList();
			
			//10. 获取科目定义数据
			Log.writeHzLog(new HfhzLog("获取收费科目规则","hfhz",userId,"hfhz"), null);
			List<KemuDef> kemuDefs = huizong.getKemuDefList();
			
			// 获取包月明细数据
//			Log.writeHzLog(new HfhzLog("正在准备包月明细信息...","hfhz",userId,"hfhz"), ds);
			List<Bymx> bymxList	= huizong.getBymxList();	
			
			//11. 获取外部话费数据
			Log.writeHzLog(new HfhzLog("获取外部话费数据","hfhz",userId,"hfhz"), null);
			List<OtherDhedit> otherDheditList = huizong.getOtherDheditList(ihzyf);
			
			//是否汇总补贴减免
			boolean butie = huizong.isTrue(LoadProperties.getKeyValues("oracle_hz", "isbutie"));
			List<Butieitem> butieitemList = null;
			if(butie){
			//12.获取减免项目定义表数据
				Log.writeHzLog(new HfhzLog("获取减免配置数据","hfhz",userId,"hfhz"), null);
				butieitemList = huizong.getbutieitemList();
			}
			
			List<FreeGrade> freeGradeList = null;
			List<HuizongTmp> huizongPreList = null;
			List<HthhfHzTmp> hthhfHzPreList = null;
			if (butieitemList != null && butieitemList.size()>0) {
				
				//获取减免类别表数据
				Log.writeHzLog(new HfhzLog("获取减免类别表数据","hfhz",userId,"hfhz"), null);
				freeGradeList = huizong.getfreeGradeList ();
				
				//获取上个月汇总用的补贴结余
				Log.writeHzLog(new HfhzLog("获取上个月汇总用的补贴结余","hfhz",userId,"hfhz"), null);
				huizongPreList = huizong.gethuizongPreList (prehzyf,hthLimit);
				
				//获取上个月合同号汇总表用的补贴结余
				Log.writeHzLog(new HfhzLog("获取上个月合同号汇总表用的补贴结余","hfhz",userId,"hfhz"), dataSourceName);
				hthhfHzPreList = huizong.geththhfHzPreList (prehzyf,hthLimit);
			}

			// 转换必要的map数据
			Map<Object, HthdangHz> hthdangHzMap = huizong.listToMap(hthdangHzList, "hth");
			Map<Object,HuizongTmp> huizongTmpMap= huizong.listToMap(huizongTmpList,"dh");
			Map<Object,FreeGrade> freeGradeMap = huizong.listToMap(freeGradeList,"freeCode");
			Map<Object,Yhlb> yhlbmap = huizong.listToMap(yhlbList,"yhlb");
			//========================================== 准备基础数据END ================================================
			
		
			// 1.汇总用户月租数据
			Log.writeHzLog(new HfhzLog("开始汇总用户月租数据...","hfhz",userId,"hfhz"), null);
			huizongTmpMap = huizong.hzUserAttachFee(mxmonth, huizongTmpMap, attachfeeTempList, 
					hfhzAttachfeeCfgList, hthdangHzMap, tjbzGroupList, yhlbmap, dbTime);
			
			//2. 汇总合同号月租数据
			if(hthattachfee){
				Log.writeHzLog(new HfhzLog("开始汇总合同号月租数据...","hfhz",userId,"hfhz"), null);
				huizongTmpMap = huizong.hzHthAttachFee(huizongTmpMap,attachfeehthhzlist,hthdangHzMap);
			}
			
			// 3.汇总用户话费
			Log.writeHzLog(new HfhzLog("开始汇总用户话费","hfhz",userId,"hfhz"), null);
			huizongTmpMap = huizong.hzUserHF(huizongHfList, huizongTmpMap);
			
			// 4.汇总工单表装、移、购机费用（中石油项目定制）
			if (teljobfee){
				Log.writeHzLog(new HfhzLog("开始汇总工单表装、移、购机费用...","hfhz",userId,"hfhz"), null);
				huizongTmpMap = huizong.hzUserTeljobFee(huizongTmpMap, teljobList);
			}

			// 外部话费导入
			Log.writeHzLog(new HfhzLog("开始汇总外部话费","hfhz",userId,"hfhz"), null);
			huizongTmpMap =huizong.importExternalData(huizongTmpMap,otherDheditList);
			
			// 按科目归类费用并计算话费合计
			Log.writeHzLog(new HfhzLog("按科目归类费用并计算话费合计...","hfhz",userId,"hfhz"), null);
			huizongTmpList = huizong.groupByKemu(huizongTmpMap, kemuDefs,yhlbmap,hthdangHzMap);
			
			// 处理电话话费减免
			Log.writeHzLog(new HfhzLog("开始处理电话话费减免...","hfhz",userId,"hfhz"), null);
			huizongTmpList = huizong.calculateBillRelief(huizongTmpList, butieitemList, freeGradeMap,huizongPreList,hzyfmm);
			
			// 按合同号统计
			Log.writeHzLog(new HfhzLog("开始按合同号统计话费...","hfhz",userId,"hfhz"), null);
			List<HthhfHzTmp> hthhfHzList = huizong.groupByHth(huizongTmpList, mxmonth, hthdangHzMap, 
					freeGradeMap,butieitemList,hthhfHzPreList, hzyfmm);
			
			// 生成最终汇总数据，并插入表中
			Log.writeHzLog(new HfhzLog("正在生成最终汇总数据...","hfhz",userId,"hfhz"), null);
			huizong.createFinalData(hthLimit,huizongTmpList, hthhfHzList, bymxList, ihzyf);
			
			// 记录日志和返回成功标志
			System.out.println("汇总成功！");
			Log.writeHzLog(new HfhzLog("汇总完成！","hfhz",userId,"hfhz"), null);
			ClientOutPut.printout(response, "success", "");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("------------------------------------汇总出现异常！");
			Log.writeHzLog(new HfhzLog("汇总出现异常！","hfhz",userId,"hfhz"), null);
			huizong.truncateUsingTable();
			ClientOutPut.printout(response, "fail", "");
		}
	}

	private void getParameters(HttpServletRequest request, HttpServletResponse response) {
		hzyf = request.getParameter("Hzyf");
		if(!StringUtils.isEmpty(hzyf.trim())){
			ihzyf = Integer.parseInt(hzyf);
		}else{
			ClientOutPut.printout(response, "fail", "");
			Log.writeHzLog(new HfhzLog("汇总月份无效,汇总程序退出","hfhz",userId,"hfhz"), null);
			return;
		}
		hthLimit = request.getParameter("HthLimit");
		userId = request.getParameter("UserID");
		yhlb = request.getParameter("Yhlb");
	}
	
	
	@SuppressWarnings("unused")
	private String createReturnXmlMsg(String tag,String msg){
		StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
		xmls.append("<rows>");
		xmls.append("<tag>");
		xmls.append(tag);
		xmls.append("</tag>");
		xmls.append("<msg>");
		xmls.append(msg);
		xmls.append("</msg>");
		xmls.append("</rows>");
		
		return xmls.toString();
	}

	
	
}
