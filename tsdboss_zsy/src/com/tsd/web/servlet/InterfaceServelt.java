package com.tsd.web.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Holder;
import javax.xml.ws.WebServiceException;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;



import com.tsd.service.OperatorInfo;
import com.tsd.service.ResultInfo;
import com.tsd.service.impl.IUserAcct;
import com.tsd.ws.ZxisamClient;

/**
 * 对外提供一系列接口，该类中的方法不需要经过用户登录即可直接调用。
 * @author luoyulong
 * @version 1.0, 2010-8-1
 *
 */
public class InterfaceServelt extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static IUserAcct zteUserAcct = null;
	private static final OperatorInfo operatorInfo = new  OperatorInfo(0,"system","T-STAR");

	/**
	 * 控制器，根据传递的method参数来判断调用哪个方法。
	 */
	@Override
	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/plain; charset=utf-8");
		String method = request.getParameter("method");
		
		try{
			if(method==null) throw new Exception();
			ExeMethodFactory.executeMethod(request, response,"com.tsd.web.servlet.InterfaceServelt", method);
		}catch (Exception e) {
			response.getWriter().print("interface error.");
		}

	}

	/**
	 * 停/复机接口，需要有请求参数 account 和 status，接收到参数后会调用中兴的接口进行停/复机。
	 */
	public void changeStatus(HttpServletRequest request,HttpServletResponse response)
			throws ServletException, IOException {
		Object result = false;
		String userAccount;
		int status;
		try{
			userAccount = request.getParameter("account");
			if(userAccount==null){
				throw new Exception("error. account is not null.");
			}
			if(userAccount.length()<6 || userAccount.length()>20){
				throw new Exception("error. account length in 6 and 20.");
			}
			try{
				status = Integer.parseInt(request.getParameter("status"));
			}catch (NumberFormatException e) {
				throw new Exception("error. status is number");
			}
			if(status!=1 && status != 2 && status != 4 && status !=5){
				throw new Exception("error. status in 1,2,4,5");
			}

		}catch (Exception e) {
			response.getWriter().print(e.getMessage());
			return;
		}
		try{
			Holder<ResultInfo> resultInfo = ZxisamClient.newResultInfo();
			result = zteUserAcct.changeStatus(userAccount, status, operatorInfo, resultInfo);
			if((Boolean)result==false){
				result = resultInfo.value.getInfoStr();
			}
		}catch (WebServiceException wse) {
			if("Could not send Message.".equals(wse.getMessage()))
				result = "service_call_timeout";
		}
		response.getWriter().print(result);
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		//初始化的时候将中兴的业务接口对象加载至本类
		WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
		zteUserAcct = (IUserAcct)context.getBean("zxisamUserAcctClient");
		if(zteUserAcct==null){
			System.out.println("InterfaceServelt initialize error!");
		}else{
			System.out.println("InterfaceServelt initialize finish.");
		}
	}

}
