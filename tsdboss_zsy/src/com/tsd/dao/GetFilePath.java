/*****************************************************************
 * name: GetFilePath.java
 * author: 
 * version: 
 * description: 获得指定文件的绝对路径
 * modify: 2010-11-22 luoyulong 添加注释
 *****************************************************************/
package com.tsd.dao;

public class GetFilePath {

	public static String getResourceFilePath(String sResourceName)
	{
	if (!sResourceName.startsWith("/"))
	{
	sResourceName = "/" + sResourceName;
	}
	java.net.URL classUrl = GetFilePath.class.getResource(sResourceName);
	if (classUrl == null)
	{
	System.out.println("\nResource '" + sResourceName + "' not found in \n'" 
	+ System.getProperty("java.class.path") + "'");

	return null;
	}
	else
	{
	System.out.println("\nResource '" + sResourceName + "' found in \n'" + classUrl.getFile() + "'");
	return classUrl.getFile();
	}
	}

	public static void main(String[] args) {
		GetFilePath g = new GetFilePath();
		g.getResourceFilePath("style/icon/79.gif");

	}

}
