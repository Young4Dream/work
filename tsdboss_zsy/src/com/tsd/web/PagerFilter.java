package com.tsd.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;


public class PagerFilter implements Filter {
	public static final String PAGE_SIZE_NAME = "ps";
	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		
		// 客户端请求的页面 是第几页
		String page = httpRequest.getParameter("page");
		//每页显示多少条记录
		String rows = httpRequest.getParameter("rows");
		
		int offSet = 0;//偏移量
		int pageSize = 10;
		
		if(page!=null){
			//得到开始的记录数
			String pagerStart = String.valueOf((Integer.valueOf(page)-1)*Integer.valueOf(rows));
			offSet = Integer.parseInt(pagerStart);
		}
		if(rows!=null){
			pageSize  = Integer.parseInt(rows);
		}
		
		SystemContext.setOffset(offSet);
		SystemContext.setPagesize(pageSize);
		try{
			chain.doFilter(request, response);
		}finally{
			SystemContext.removeOffset();
			SystemContext.removePagesize();
		}
	}
	
//	private int getOffset(HttpServletRequest request){
//		int offset = 0;
//		try {
//			offset = Integer.parseInt(request.getParameter("pager.offset"));
//		} catch (Exception ignore) {
//		}
//		return offset;
//	}
//	
//	private int getPagesize(HttpServletRequest httpRequest){
////		return 10;
//		
//		//首先判断request中是否有pagesize参数，如果有这个参数，证明客户端正在请求改变每页显示的行数
//		String psvalue = httpRequest.getParameter("pagesize");
//		if(psvalue != null && !psvalue.trim().equals("")){
//			Integer ps = 0;
//			try {
//				ps = Integer.parseInt(psvalue);
//			} catch (Exception e) {
//			}
//			if(ps != 0){
//				httpRequest.getSession().setAttribute(PAGE_SIZE_NAME, ps);
//			}
//		}
//		
//		//判断当前session中是否有pagesize的值
//		Integer pagesize = (Integer)httpRequest.getSession().getAttribute(PAGE_SIZE_NAME);
//		if(pagesize == null){
//			httpRequest.getSession().setAttribute(PAGE_SIZE_NAME, 10);
//			return 10;
//		}
//		
//		return pagesize;
//	}

	public void init(FilterConfig arg0) throws ServletException {

	}

}
