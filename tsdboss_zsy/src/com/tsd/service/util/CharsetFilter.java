/*****************************************************************
 * name: CharsetFilter.java
 * author: 
 * version: 
 * description: 编码过滤器
 * modify: 2010-11-22 luoyulong 添加注释
 *****************************************************************/
package com.tsd.service.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class CharsetFilter implements Filter {
	private String encoding;
	public void destroy() {
		this.encoding = null;
	}

	public void doFilter(ServletRequest sreq, ServletResponse sresp,
			FilterChain fchain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)sreq;
		request.setCharacterEncoding(this.encoding);
		fchain.doFilter(sreq,sresp);
	}

	public void init(FilterConfig fconfig) throws ServletException {
		this.encoding = fconfig.getInitParameter("encoding");
		/**
		 * 开始加载过滤器
		 */
	}
}
