package com.tsd.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.tsd.domain.PackageMain;
import com.tsd.domain.PageObject;
import com.tsd.service.PackageMainService;

/**
 * 套餐配置servlet
* <p>Title: PackageMainServlet</p>
* <p>Description: create PackageMainServlet</p>
* <p>Company: tsd</p> 
* @author yinyuelin
* @date Nov 20, 2015 / 4:42:44 PM
 */
public class PackageMainServlet extends HttpServlet {
	
	PageObject pageObject = new PageObject();
	
	//操作类型，默认为查询 1：新增页面，2：修改页面，3：删除，4：详细页面，5：新增操作，6：修改操作
	int cmd = 0;

	PackageMainService packageMainService = new PackageMainService();
	
	public void service(ServletRequest request, ServletResponse response) throws ServletException, IOException {  
        
        //防止   websphere 5.1  下乱码，对jboss没影响  
        response.setContentType("text/xml; charset=UTF-8");  
   
        String cmdStr = request.getParameter("cmd"); 
        if(cmdStr != null && !cmdStr.equals("")){
        	cmd = Integer.valueOf(cmdStr);
        }
        
        if(request.getParameter("pageSize") != null && !request.getParameter("pageSize").equals("")){
        	 pageObject = genPageObject(request);
        }
        
        try {  
        	
        	switch(cmd){
        	
        		case 0://查询 
        			
        			List<PackageMain> packageMainList = packageMainService.queryPackageMainByPage(pageObject);
        			
        			String result = JSONArray.toJSONString(packageMainList);
        			
        			String pageObjectStr = JSONObject.toJSONString(pageObject);
        			
        			write(response, result + "&&&" + pageObjectStr);

        			break;
        		case 1://新增页面
        			
        			String addPagRt = packageMainService.initData();
        			
        			write(response, addPagRt);
        			break;
        		case 2://修改页面
        			
        			int id = Integer.valueOf(request.getParameter("id"));
        			
        			String jsonStr = packageMainService.queryPackageMainById(id);
        			
        			write(response, jsonStr);
        			break;
				case 3://删除
					int rtDelete = packageMainService.delPackageMain(request);
					write(response, rtDelete+"");
				    break;
				case 4://详细页面
					
					break;
				case 5://新增操作
					int rt = packageMainService.addPackageMain(request);
					
					if(rt == 0){
						write(response, "yes");
					}else{
						write(response, "no");
					}
					
					break;
				case 6://修改操作
					int rtMod = packageMainService.updatePackageMain(request);
					if(rtMod == 0){
						write(response, "yes");
					}else{
						write(response, "no");
					}
					break;
        	}
        	
//        	String rest = request.getParameter("test");
//        	
//        	System.out.println("跑通啦" + rest);
        	
        } catch (Throwable e) {  
        	//ProLogService.error(this.getClass(), e.getMessage(), e);  
        }  
    }  
	
	private void write(ServletResponse response, String str) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw = response.getWriter();
		
		pw.write(str);
		pw.flush();
		pw.close();
	}
	
	private PageObject genPageObject(ServletRequest request){
		PageObject pageObject = new PageObject();
		pageObject.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		pageObject.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		pageObject.setTotalPage(Integer.parseInt(request.getParameter("totalPage")));
		return pageObject;
	}

}
