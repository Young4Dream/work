package com.tsd.service.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class ClientOutPut {
	/***************************************************************************
	 * 对客户端进行相应输出
	 * 
	 * @param response
	 * @param values
	 * @param datatype
	 */
	public static void printout(HttpServletResponse response, String values,
			String datatype) {
		//System.out.println(values);
		if ("xml".equalsIgnoreCase(datatype)) {
			response.setContentType("application/XML,charset=UTF-8");
			response.setHeader("Charset", "UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/xml");
		}
		else
		{
			response.setContentType("text/html");
			response.setHeader("Charset", "UTF-8");
			response.setCharacterEncoding("UTF-8");
		}
		try {
			PrintWriter out = response.getWriter();

			out.write(values);// 回馈成功信息
			out.flush();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
