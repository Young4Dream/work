package com.tsd.service.util;

import javax.servlet.http.HttpServlet;

import org.apache.log4j.PropertyConfigurator;

public class log4jIni extends HttpServlet{
    public void init() {
        /*找到在web.xml中指定的log4j.properties文件并读取配置信息*/
        String prefix =  getServletContext().getRealPath("/");
        String file = getInitParameter("log4j");
        System.out.println("................log4j start");
        if(file != null) {
            PropertyConfigurator.configure(prefix+file);
        }
    }
}