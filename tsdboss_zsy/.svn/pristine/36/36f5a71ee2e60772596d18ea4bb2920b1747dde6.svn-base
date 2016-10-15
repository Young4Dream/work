package com.tsd.service.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.tsd.dao.DBhelper;
import com.tsd.entity.HfhzLog;

public class Log {
	public Log() {
	}

	/**
	 * 记录汇总日志到数据库
	 * @param log
	 * @param dataSourceName
	 */
	public static void writeHzLog(HfhzLog log,String dataSourceName){
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DBUtil.openConnection();
			String sql = "insert into hfhz_log (lg_time,lg_proc,lg_desc,lg_userid,lg_system) values(sysdate,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, log.getLgProc());
			pstmt.setString(2, log.getLgDesc());
			pstmt.setString(3, log.getLgUserid());
			pstmt.setString(4, log.getLgSystem());
			pstmt.execute();
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
				try {
					DBUtil.closeConnection(conn, pstmt, null);
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}
	
	/**
	 * 取当前用户登陆的真实ip
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 取当前系统时间，到秒
	 * @return
	 */
	public static String getThisTime() {
		java.util.TimeZone tz = java.util.TimeZone.getTimeZone("ETC/GMT-8");//设置下时区否则获取的时间不准确
		java.util.TimeZone.setDefault(tz);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String thislogtime = format.format(now);
		return thislogtime;
	}

	/**
	 * 取当前系统时间，到天
	 * @return
	 */
	public static String getSysTime() {
		java.util.TimeZone tz = java.util.TimeZone.getTimeZone("ETC/GMT-8");//设置下时区否则获取的时间不准确
		java.util.TimeZone.setDefault(tz);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String thislogtime = format.format(now);
		return thislogtime;
	}
	
	/**
	 * 取当前系统时间，到天
	 * @return
	 */
	public static String getSysTime(String formatstr) {
		java.util.TimeZone tz = java.util.TimeZone.getTimeZone("ETC/GMT-8");//设置下时区否则获取的时间不准确
		java.util.TimeZone.setDefault(tz);
		SimpleDateFormat format = new SimpleDateFormat(formatstr);
		Date now = new Date();
		String thislogtime = format.format(now);
		return thislogtime;
	}

	//获得明天的日期   
	public static String getNextDay() {
		java.util.TimeZone tz = java.util.TimeZone.getTimeZone("ETC/GMT-8");//设置下时区否则获取的时间不准确
		java.util.TimeZone.setDefault(tz);
		String str = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar lastDate = Calendar.getInstance();
		lastDate.add(Calendar.DAY_OF_MONTH, 1);//减一个月   
		//lastDate.set(Calendar.DATE, 1);//把日期设置为当月第一天    
		str = sdf.format(lastDate.getTime());
		return str;
	}

	//获得下个月第一天的日期   
	public static String getNextMonthFirst() {
		java.util.TimeZone tz = java.util.TimeZone.getTimeZone("ETC/GMT-8");//设置下时区否则获取的时间不准确
		java.util.TimeZone.setDefault(tz);
		String str = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Calendar lastDate = Calendar.getInstance();
		lastDate.add(Calendar.MONTH, 1);//减一个月   
		lastDate.set(Calendar.DATE, 1);//把日期设置为当月第一天    
		str = sdf.format(lastDate.getTime());
		return str;
	}

	/**
	 * 是否为空判断
	 * @param str
	 * @return
	 */
	public static String isNull(String str) {
		if (null == str) {
			str = "";
		}
		return str;
	}

	public static String physicalAddress = "read MAC error!";

	//取小区域内的局域网mac地址
	public static String checkPhysicalAddress() {
		try {
			String line;
			Process process = Runtime.getRuntime().exec("cmd /c ipconfig /all");
			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(process.getInputStream()));
			while ((line = bufferedReader.readLine()) != null) {
				if (line.indexOf("Physical Address. . . . . . . . . :") != -1) {
					if (line.indexOf(":") != -1) {
						physicalAddress = line.substring(line.indexOf(":") + 2);
						break; // 找到MAC,推出循环   
					}
				}
			}
			process.waitFor();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return physicalAddress;
	}

	public static void main(String[] args) {
		System.out.println("本机的MAC地址是: " + Log.checkPhysicalAddress());
		System.out.println("下个月第一天日期: " + Log.getNextMonthFirst());
		System.out.println("明天的日期: " + Log.getNextDay());
		System.out.println("当前的日期: " + Log.getSysTime("yyyy-MM-dd"));

	}
}
