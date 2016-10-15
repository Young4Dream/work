/*****************************************************************
 * name: DBhelper.java
 * author: 
 * version: 
 * description: 对数据源操作的助手类，提供获取数据库连接对象等方法
 * modify: 2010-11-19 luoyulong 添加注释
 *         2010-12-3  chenze    系统启动时启用工单调用
 *****************************************************************/
package com.tsd.dao;

import java.sql.Connection;
import java.sql.SQLException;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.tsd.jobschedule.jobmanage;
import com.tsd.service.UserManager;
import com.tsd.service.util.LoadProperties;

/**
 * 加载Spring配置文件时，如果Spring配置文件中所定义的Bean类，如果该类实现了ApplicationContextAware接口，
 * 那么在加载Spring配置文件时
 * ，会自动调用ApplicationContextAware接口中的setApplicationContext(ApplicationContext
 * context)方法 <br>
 * 这里DBhelper类，实现了ApplicationContextAware接口，会将spring应用程序上下文对象保存在 DBhelper.context 静态属性中
 * 
 */
public class DBhelper implements ApplicationContextAware {
	//获取日志输出等级，chenliang ，2012-09-06
	private static final int printLevel = Integer.parseInt(LoadProperties.getKeyValues("mainSystem", "tsdLogPrint"));
	public static Boolean tsdSQLPrint = false;
	public static Boolean tsdResultPrint = false;
	/**
	 * spring 的jdbc模板，提供很多常用的包装好的jdbc操作
	 */
	public static JdbcTemplate jdbcTemplate;
	/**
	 * spring 的hibernate模板，提供很多常用的包装好的hibernate操作
	 */
	public static HibernateTemplate hibernateTemplate;
	/**
	 * spring应用程序上下文对象
	 */
	public static ApplicationContext context;

	/***
	 * 此方法更改数据源
	 * 
	 * @param dataSourceName
	 *            Spring配置文件中的数据源
	 */
	private static ComboPooledDataSource getDataSources(String dataSourceName) {
		return (ComboPooledDataSource) context.getBean(dataSourceName);
	}

	/**
	 * 获得指定连接对象的数据库产品的名称
	 * 
	 * @param conn
	 *            连接对象
	 * @return 对应配置文件的名称
	 */
	public static String getDatabaseProductName(java.sql.Connection conn) {
		String name = "";
		try {
			name = conn.getMetaData().getDatabaseProductName();
		} catch (SQLException e) {
			String printInfo = "[Exception]，[DBhelper.getDatabaseProductName()]SQLException，Parmas：databaseName="+name;
			System.out.println(printInfo);
			e.printStackTrace();
		}
		if ("Microsoft SQL Server".equals(name)) {
			return "mssql";
		} else if ("MySQL".equals(name)) {
			return "mysql";
		} else if ("Oracle".equals(name)) {
			return "oracle";
		} else if ("PostgreSQL".equals(name)) {
			return "postgresql";
		} else if ("EnterpriseDB".equals(name)) {
			return "enterprisedb";
		} else {
			return "";
		}
	}

	/**
	 * 在Spring启动时自动获得Spring 的 ApplicationContext
	 */
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		DBhelper.context = applicationContext;
		jdbcTemplate = (JdbcTemplate) context.getBean("jdbcTemplate");
		hibernateTemplate = (HibernateTemplate) context
				.getBean("hibernateTemplate");

		//Tomcat重启时进行将所有用户的是否登陆变更为false，chenliang
		UserManager uManager = new UserManager();
		uManager.updateLogined();// tomcat重启更新所有用户的登陆状态
		//增加工单自动汇总，lvkui
		jobmanage jbm = new jobmanage();
		jbm.getNewJob();//启动加载用户系统工单
		//获取日志打印等级，chenliang
		logPrint(printLevel);
	}

	/**
	 * 根据数据源名称，获得数据库连接对象
	 * @param dataSourceName Spring配置文件中的c3p0数据源名称
	 * @return 数据库连接对象
	 */
	public static synchronized Connection getConnection(String dataSourceName) {
		ComboPooledDataSource dataSource = null;
		try {
			dataSource = ((ComboPooledDataSource) context.getBean(dataSourceName));
			// System.out.println("已用连接数: "+dataSource.getNumBusyConnections()+";空闲连接数: "+dataSource.getNumIdleConnections()+";目前总连接数: "+dataSource.getNumConnections()
			// +";数据源: "+dataSource.getJdbcUrl());
			// +";数据源: "+dataSource.toString();
			return dataSource.getConnection();
		} catch (SQLException e1) {
			String printInfo = "[Exception]，[DBhelper.getConnection()]SQLException，Parmas：datasourceName="+dataSourceName;
			System.out.println(printInfo);
			e1.printStackTrace();
		}
		return null;
	}
	
	//日志打印输出级别
	private void logPrint(int printLevel){
		switch(printLevel){
			case 1:
				tsdSQLPrint = false;
				tsdResultPrint = false;
				break;
			case 2:
				tsdSQLPrint = true;
				break;
			case 3:
				tsdSQLPrint = true;
				tsdResultPrint = true;
				break;
			default:
				System.out.println("[SQL Print Level]: "+printLevel);
				break;
		}
	}
}