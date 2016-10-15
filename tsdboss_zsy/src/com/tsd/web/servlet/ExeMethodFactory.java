package com.tsd.web.servlet;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExeMethodFactory {
	public static void executeMethod(HttpServletRequest request, HttpServletResponse resp,String clsName, String methodName) throws ClassNotFoundException, InstantiationException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
			Class cls =Class.forName(clsName);
			Object obj=cls.newInstance();
			Method[] methods = cls.getDeclaredMethods();
			for (Method method : methods) {
				if (method.getName().equalsIgnoreCase(methodName)) {
					method.invoke(obj, new Object[]{request,resp});
					break;
				}
			}
	}
}