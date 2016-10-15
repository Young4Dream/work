package com.tsd.web.servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.tsd.dao.ExecuteSql;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.Log;
import com.tsd.service.util.StringUtil;

public class mainServlet extends HttpServlet {
	/**
	 *  
	 */
	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("unchecked")
	public void service(HttpServletRequest request, HttpServletResponse response) {
		/**
		 * 登陆时需要判断的参数
		 * 
		 */
		//user login
		String login = request.getParameter("login");
		String cmd = request.getParameter("cmd");
		UserLogin user = new UserLogin(request, response);;
		/**
		 * 用户登陆验证
		 * --判断是否经过登陆页面进行操作--
		 * StringUtil.isNotEmpty(login) 
		 */
		if (StringUtil.isNotEmpty(login)) {
			/**
			 * 用户开始登陆
			 */
			String sadminname = request.getParameter("sadminname");
			String spassword = request.getParameter("spassword");
			/**
			 * 判断平台要用到的数据源信息
			 */
			//String ds = request.getParameter("ds");
			//DBhelper.getDataSources(ds);
			//System.out.println("get ds:"+Log.getThisTime());
			/**
			 * 检测用户登陆账号是否存在 并将相应信息存入会话中及用户登出时要将session removed
			 */
			user.login(sadminname, spassword,Log.getIpAddr(request),request);
			//System.out.println("end login:"+Log.getThisTime());
			/**
			 * user.onlogin()判断用户是否进行了登陆操作
			 */
		}else if (user.onlogin())
		{
			
			// 判断当前是否为外部话单导入
			if("import".equals(cmd))
			{
				try
				{
					request.setCharacterEncoding("utf-8");  //设置编码  
			        //获得磁盘文件条目工厂  
			        DiskFileItemFactory factory = new DiskFileItemFactory();  
			        //获取文件需要上传到的路径  
			        String path = request.getRealPath("/upload");  
			        //如果没以下两行设置的话，上传大的 文件 会占用 很多内存，  
			        //设置暂时存放的 存储室 , 这个存储室，可以和 最终存储文件 的目录不同  
			        /** 
			         * 原理 它是先存到 暂时存储室，然后在真正写到 对应目录的硬盘上，  
			         * 按理来说 当上传一个文件时，其实是上传了两份，第一个是以 .tem 格式的  
			         * 然后再将其真正写到对应目录的硬盘上 
			         */  
			        factory.setRepository(new File(path));  
			        //设置缓存的大小，当上传文件的容量超过该缓存时，直接放到暂时存储室  
			        factory.setSizeThreshold(1024*1024) ;  
			        ServletFileUpload upload = new ServletFileUpload(factory);  
			        //可以上传多个文件  
		            List<FileItem> list = (List<FileItem>)upload.parseRequest(request);  
		            for(FileItem item : list)  
		            {
		                //获取表单的属性名字  
		                String name = item.getFieldName();  
		                //如果获取的 表单信息是普通的 文本 信息  
		                if(item.isFormField())  
		                {                   
		                    //获取用户具体输入的字符串 ，名字起得挺好，因为表单提交过来的是 字符串类型的  
		                    String value = item.getString() ;  
		                      
		                    request.setAttribute(name, value);  
		                }  
		                //对传入的非 简单的字符串进行处理 ，比如说二进制的 图片，电影这些  
		                else  
		                {
		                	 //获取路径名  
		                    String value = item.getName() ;  
		                    //索引到最后一个反斜杠  
		                    int start = value.lastIndexOf("\\");  
		                    //截取 上传文件的 字符串名字，加1是 去掉反斜杠，  
		                    String filename = value.substring(start+1);  
		                    //手动写的  
		                    OutputStream out = new FileOutputStream(new File(path,filename));  
		                    InputStream in = item.getInputStream();  
		                    int length = 0 ;  
		                    byte [] buf = new byte[1024] ;  
		                    // in.read(buf) 每次读到的数据存放在   buf 数组中  
		                    while( (length = in.read(buf) ) != -1)  
		                    {  
		                        //在   buf 数组中 取出数据 写到 （输出流）磁盘上  
		                        out.write(buf, 0, length);  
		                    }
		                    // 读取文件内容
		                    File file = new File(path+"/"+filename);
		                    BufferedReader reader = null;
		                    reader = new BufferedReader(new FileReader(file));
		                    String tempString = null;
		                    int line = 1;
		                    List<String> fileList = new ArrayList<String>();
		                    // 一次读入一行，直到读入null为文件结束
		                    while ((tempString = reader.readLine()) != null)
		                    {
		                        System.out.println("line " + line + ": " + tempString);
		                        fileList.add(tempString);
		                        line++;
		                    }
		                    reader.close();
		                    in.close();  
		                    out.close(); 
		                    // 调用数据库执行外部话费入库
		                    if( fileList.size() > 0 )
		                    {
		                    	ExecuteSql.executeImport(fileList, 2);
		                    }
		                }
		            }
		            String par = "&imenuid=4220&pmenuname=%E8%AE%A1%E8%B4%B9%E7%AE%A1%E7%90%86&imenuname=%E5%A4%96%E9%83%A8%E8%AF%9D%E8%B4%B9%E5%AF%BC%E5%85%A5&groupid=1";
		            response.sendRedirect("mainServlet.html?pagename=pubMode/SingleTabE.jsp"+par);
		            
					return;
				}catch(Exception ex)
				{
					ex.printStackTrace();
				}
			}
			/**
			 * 欢迎页面取用户登陆信息
			 */
			String getLoginInfo=request.getParameter("getLoginInfo");
			if(StringUtil.isNotEmpty(getLoginInfo)) {
				HttpSession session = request.getSession(true);
				/**
				 * 将用户信息保存到xml中，用于页面通过json解析数据
				 */
				String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
				xmls+="<row username=\""+session.getAttribute("username")+"\" />";
				ClientOutPut.printout(response, xmls,"xml"); 
				return;
			}
			
			//jqgrid行显示配置参数
			String jqgridparams =request.getParameter("jqgridparams");
			if(null!=jqgridparams)
			{
				if(jqgridparams.equals("getparams")){
					HttpSession session = request.getSession();
					String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
					xmls+="<rows><row jqGridRowList=\"";
					xmls+=session.getAttribute("jqGridRowList")+"\" jqGridRowNum=\"";
					xmls+=session.getAttribute("jqGridRowNum")+"\" />";
					xmls+="</rows>";
					ClientOutPut.printout(response, xmls,"xml"); 
					return;
				}
			}
			
			if(StringUtil.isNotEmpty(getLoginInfo)) {
				/**
				 * 将用户信息保存到xml中，用于页面通过json解析数据
				 */
				HttpSession session = request.getSession(true);
				String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?> ";
				xmls+="<row username=\""+session.getAttribute("username")+"\" />";
				ClientOutPut.printout(response, xmls,"xml"); 
				return;
			}
			/**
			 * 在系统页面用户进行了注销操作需要传的参数exitLogin
			 */
			String exitLogin = request.getParameter("exitLogin");
			/**
			 * 登出信息进行非空判断
			 */
			if (StringUtil.isNotEmpty(exitLogin)) {
				/**
				 * 进行登出操作，removed session
				 */
				user.userExit();
				/**
				 * 成功执行，将true返回给前台
				 */
				ClientOutPut.printout(response, "true","");
			}
			
			/**
			 * 跳转到目标页面时需要判断的参数
			 * 
			 */
			String pagename = request.getParameter("pagename");
			
			/*
			//测试使用，未在使用，添加注释，chenliang，2012-09-06
			if(null != pagename){
				//System.out.println("操作请求的时间：>>>>>"+Log.getThisTime()+"操作请求的页面：>>>>>"+pagename);	
			}
			*/
			/**
			 * 调存储过程
			 */
			if (StringUtil.isNotEmpty(pagename)) {
				//参数getproc是只是否要取存储过程 没有这个参数或者为""或者为"true"表示要取 --add by lvkui on 2009-11-28
				//因为在取过程的类里获取数据库连接时很慢
				/*
				 * 不能在这里取过程，因为不能后退 后退时出错：找不到存储过程  
				String sgetproc=request.getParameter("getproc");
				 if (sgetproc == null || sgetproc.equalsIgnoreCase("") || sgetproc.equalsIgnoreCase("true")) {
					 Map procedurs=new HashMap();
					 procedurs = QueryProcedure.queryProcedureByName(pagename);
					 HttpSession session = request.getSession(true);
					 session.setAttribute("procedurs", procedurs);
				 }
				 */
				try {
					if (pagename.startsWith("http:/")) {
						HttpSession session = request.getSession(true);
						//第三方系统需要计费平台提供参数，chenliang，2012-09-06
						//由于在前台传递的参数，系统JS自动将&拼接的参数替换掉，所以，在需要传递多个参数时，参数格式为以'|'进行参数拼接
						//再需要的数据格式值以@userid@,@username@,@departname@进行拼接
						//数据格式：http://192.168.44.211:8080/112Product/index.jsp?userId=@userid@|flag=2|callerid=3
						String[] sessionArr = {"userid","username","password","managearea","departname","groupid","canloginip","userState","chargearea","userarea"};
						for(int i = 0 ; i < sessionArr.length ; i++){
							if(pagename.indexOf(sessionArr[i]) != -1){
								pagename = pagename.replace("@"+sessionArr[i]+"@", (String)session.getAttribute(sessionArr[i]));
							}
						}
						pagename = pagename.replace("|", "&");						
						System.out.println("=====================================");
						System.out.println("【Http sendRedirect PageName】：" + pagename );
						System.out.println("=====================================");
						response.sendRedirect(pagename);
						return;
					}
					/**
					 * 将页面建在WEB-INF下必须通过servlet才能进行访问
					 * 
					 */
					//使ie8兼容ie7的样式
					response.setHeader("X-UA-Compatible", "IE=EmulateIE7");
					
					request.getRequestDispatcher("/WEB-INF/template/"+pagename).forward(request, response);
				} catch (ServletException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				return;
			}/**/
			
			/**
			 * 执行页面传过来的方法时要判断的参数
			 * 
			 * 哪个包下的哪个类中的哪个方法
			 */
			String packgname = request.getParameter("packgname");
			String clsname = request.getParameter("clsname");
			String method = request.getParameter("method");
			
			String exportparams = request.getParameter("exportflag");//执行导出操作
			
			if(null!=exportparams){
				//需处理参数
				String whichsql = request.getParameter("whichsql");
				String table = request.getParameter("table");
				String fusearchsql = request.getParameter("fusearchsql");
				String fieldtable = request.getParameter("fieldtable");
				
				//导出参数存到sesison里去
				HttpSession session = request.getSession();
				session.setAttribute("exportflag", exportparams);
				session.setAttribute("whichsql", whichsql);
				session.setAttribute("table", table);
				session.setAttribute("fusearchsql", fusearchsql);
				session.setAttribute("fieldtable", fieldtable);
			}
			
			// /////////////////////////////
			// //利用反射执行业务层的方法
			// /////////////////////////////
			if (StringUtil.isNotEmpty(packgname)) {
				if (StringUtil.isNotEmpty(clsname)) {
					if (StringUtil.isNotEmpty(method)) {
						try {
							/**
							 * 通过反射类里面的方法依次遍历，并进行判断
							 */
							ExeMethodFactory.executeMethod(request, response,
									"com.tsd." + packgname + "." + clsname, method);
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						} catch (ClassNotFoundException e) {
							e.printStackTrace();
						} catch (InstantiationException e) {
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							e.printStackTrace();
						} catch (InvocationTargetException e) {
							e.printStackTrace();
						}
					}
				}
			}
		} else {
			/**
			 * 用户信息为空，进行重新登陆
			 */
			try {
				String spagename=request.getParameter("pagename");
				//传了参数pagename表示是由菜单调用
				//这时，如果超时了就跳转到登录页面
				//如果没有传这个参数，可能是ajax调用。超时时返回标识："session invalid"
				//由jsp页面负责跳转。
				if (spagename==null)
				{
				  ClientOutPut.printout(response, "session invalid", "");
				  return;
				}
				response.sendRedirect("login.jsp");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
