package com.tsd.service.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

//获取配置文件中的键值
public class LoadProperties {
	//properties中配置的SQL语句
	public static String sql;
	/**
	 * 获取配置文件中的键值 并设置给sql
	 * @param configName 配置文件名称 不含路径
	 * @param key 键名
	 * @return 返回对应值
	 */
	public static String getKeyValues(String configName,String key){
		String value = null;
		Properties props = new Properties();
		InputStream ins = null;
		try {
			String path = LoadProperties.class.getProtectionDomain().getCodeSource().getLocation().getPath();
			int i = path.indexOf("WEB-INF");
			if(i>0){
				path = path.substring(0,i+8);
				path += ("mainSystem".equals(configName)?"classes/sysconfig/mainSystem.properties":"classes/config/"+configName+".properties");
				ins = new FileInputStream(new File(path));
				props.load(ins);
				ins.close();
				value = (String) props.get(key);
			}
		} catch (IOException e) {
			throw new RuntimeException("Load config file error："+e);
		}finally{
			/** 
			if (!"mainSystem".equals(configName)){
				System.out.println("[configName: " + configName + ", key: "+ key + ", value: " +value+"]");
			}
			*/
		}
		return value == null ? "" : value;
	}
	public static void getSql(String configName,String key){
		String value = null;
		Properties props = new Properties();
		InputStream ins = null;
		try {
			String path = LoadProperties.class.getProtectionDomain().getCodeSource().getLocation().getPath();
			int i = path.indexOf("WEB-INF");
			if(i>0){
				path = path.substring(0,i+8);
				path += ("mainSystem".equals(configName)?"classes/sysconfig/mainSystem.properties":"classes/config/"+configName+".properties");
				ins = new FileInputStream(new File(path));
				props.load(ins);
			}
			ins.close();
			value = (String) props.get(key);
		} catch (IOException e) {
			throw new RuntimeException("Load config file error："+e);
		}finally{
			/**
			if (!"mainSystem".equals(configName)){
				System.out.println("[configName: " + configName + ", key: "+ key + ", value: " +value+"]");
			}
			*/
		}
		LoadProperties.sql = (value==null ? "" :value);
	}
}
