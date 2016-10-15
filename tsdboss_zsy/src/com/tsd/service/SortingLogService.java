package com.tsd.service;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.Callable;
import java.util.concurrent.FutureTask;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.SortingLogFilter;

/**
 * 分拣日志
* <p>Title: SortingLogService</p>
* <p>Description: create SortingLogService</p>
* <p>Company: tsd</p> 
* @author yinyuelin
* @date Jan 14, 2016 / 1:35:54 PM
 */
public class SortingLogService {

	private static JdbcTemplate jdbcTemplate;
	
	public SortingLogService(){
		jdbcTemplate = (JdbcTemplate)DBhelper.context.getBean("jdbcTemplate");
	}
	
	/**
	 * 查询日志文件
	 */
	public void query(HttpServletRequest request, HttpServletResponse response){
		
		String basePath = (String)jdbcTemplate.execute("select t.value from OCS_PARA t where t.name='BasePath'", new PreparedStatementCallback (){
			@Override
			public Object doInPreparedStatement(PreparedStatement ps)
					throws SQLException, DataAccessException {
				ps.execute();  
		        ResultSet rs = ps.getResultSet(); 
		        
		        String path = null;
		        while(rs.next()){
		        	path = rs.getString("value");
		        }
				return path;
			}
		});
		
		StringBuilder strBuilder = new StringBuilder();
		File file = new File(basePath+"/log");
		File[] files = file.listFiles();
		Arrays.sort(files,new Comparator< File>(){
		     public int compare(File f1, File f2) {
			long diff = f1.lastModified() - f2.lastModified();
			if (diff > 0)
			  return -1;
			else if (diff == 0)
			  return 0;
			else
			  return 1;
		     }
		     public boolean equals(Object obj) {
			return true;
		     }
				
		});
		DecimalFormat df = new DecimalFormat("#.###");   
		for(File f : files){
			double size = f.length();
			String sizeStr = "0";
			if(size != 0){
				sizeStr = df.format(size/1024)+"";
			}
			//System.out.println(size+"######22  "+sizeStr);
			String name = f.getName();
			if(name.endsWith("billcollect.out") || name.endsWith("error.log")){
				name = name + "(最新)";
			}
			strBuilder.append(name+":");
			strBuilder.append(sizeStr+"KB;");
			
		}
		//System.out.println("#############"+strBuilder.toString());
		backToPage(strBuilder.toString(), response);
	}
	
	/**
	 * 下载日志文件
	 * @param request
	 * @param response
	 */
	public void download(HttpServletRequest request, HttpServletResponse response){
		String basePath = (String)jdbcTemplate.execute("select t.value from OCS_PARA t where t.name='BasePath'", new PreparedStatementCallback (){
			@Override
			public Object doInPreparedStatement(PreparedStatement ps)
					throws SQLException, DataAccessException {
				ps.execute();  
		        ResultSet rs = ps.getResultSet(); 
		        
		        String path = null;
		        while(rs.next()){
		        	path = rs.getString("value");
		        }
				return path;
			}
		});
		
		String fileName = request.getParameter("fileName");
		//System.out.println("###########filename="+fileName);
		File filePathFile = new File(basePath + "/log/" + fileName);
		
		OutputStream os = null;
		InputStream is = null;
		try{
			response.setCharacterEncoding("utf-8");
			response.addHeader("Content-Disposition", "attachment;filename="+fileName);
			response.setContentType("application/octet-stream");
			
			os = new BufferedOutputStream(response.getOutputStream());
			is = new FileInputStream(filePathFile);
			byte[]  buffer = new byte[(int)filePathFile.length()];
			//System.out.println("buffer.size = " + buffer.length);
			is.read(buffer);
		    os.write(buffer);// 输出文件
		    os.flush();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(os != null){
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(is != null){
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	/**
	 * 详情查看
	 */
	public void detail(HttpServletRequest request, HttpServletResponse response){
		String basePath = (String)jdbcTemplate.execute("select t.value from OCS_PARA t where t.name='BasePath'", new PreparedStatementCallback (){
			@Override
			public Object doInPreparedStatement(PreparedStatement ps)
					throws SQLException, DataAccessException {
				ps.execute();  
		        ResultSet rs = ps.getResultSet(); 
		        
		        String path = null;
		        while(rs.next()){
		        	path = rs.getString("value");
		        }
				return path;
			}
		});
		
		String scrollStatus = request.getParameter("scroll");
		//System.out.println(scrollStatus+"========================================");
		String fileName = request.getParameter("fileName");
		if(scrollStatus != null && scrollStatus.equals("yes")){
			StringBuilder sbuilder = new StringBuilder();
        	String lastLineContent = request.getParameter("lastLineContent");
        	List<String> lines = null;//readFileAllLines(basePath + "/log/" +fileName);
        	
        	Queue<Map<String,List<String>>> logQueue = SortingLogFilter.getLogList();
        	
        	for(Map<String,List<String>> logMap : logQueue){
        		if(logMap.containsKey(fileName)){
        			lines = logMap.get(fileName);
        		}
        	}
        	if(null == lines){
    			lines = readFileAllLines(basePath + "/log/" +fileName);
    			SortingLogFilter.addLogList(fileName, lines);
        	}
        	
        	
        	int currentNo = Integer.parseInt(request.getParameter("currentNo"));
        	if (currentNo <=0){currentNo = 1;}
        	if(currentNo -1 < lines.size() && null != lastLineContent && !"".equals(lastLineContent)){
        	for(int k = currentNo-1;true ;k++){
        			if(null != lines.get(k) && !"".equals(lines.get(k)) && (lines.get(k).toString()).contains(lastLineContent.trim())){
        					currentNo = (k+100);break;        					
        			}
        		}
        	}
        	for(int i = currentNo; i < currentNo+100; i++){
        		if(i < lines.size()){
        			sbuilder.append(lines.get(i));
        			if(i == currentNo+99){
        				sbuilder.append("<div class='showInfo'>");
        				sbuilder.append("<br>");
                    	sbuilder.append("-------------------------------------------------------------------------点此继续查看<img onclick=\"moreLogs();\" style='cursor:pointer;' src='style/icon/24.png'/>-----------------------------------------------------------------------------");
                    	sbuilder.append("<br>");
                    	sbuilder.append("</div>");
        			}
        		}else{
        			sbuilder.append("<br>");
                	sbuilder.append("-------------------------------------------------------------------------没有更多内容可查看-----------------------------------------------------------------------------");
                	sbuilder.append("<br>");
                	break;
        		}
        	}
        	backToPage(sbuilder.toString(), response);
		}else{
			backToPage(readFileByLines(request,basePath + "/log/" + fileName ,fileName), response);
		}
		
	}
	
	private void backToPage(String str, HttpServletResponse response){
		PrintWriter out = null;
		try {
			response.reset();
			response.setHeader("Charset", "UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/plain");
			out = response.getWriter();
			out.write(str);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out != null){
				out.close();
			}
		}
	}
	
	/** 
     * 以行为单位读取文件，常用于读面向行的格式化文件 
     */  
    @SuppressWarnings("unchecked")
	public String readFileByLines(HttpServletRequest request,final String fileFullName,final String fileName){
    	RandomAccessFile rf = null;  
        BufferedReader reader = null;  
        StringBuilder sbuilder = new StringBuilder();
        try {
        	rf = new RandomAccessFile(fileFullName, "r"); 
        	long len = rf.length();  
            long start = rf.getFilePointer();  
            long nextend = start + len - 1;
            String line;  
            if(nextend < 0){
            	return "";
            }
            rf.seek(nextend);
            int c = -1;  
            int lineNo = 1;
            	
        	//第一次查询
        	while (nextend > start) {
                c = rf.read();
                if (c == '\n' || c == '\r'){
                    line = rf.readLine();
                    if (line != null && !"".equals(line.trim())) {//有可能读到空行
                        /*System.out.println(new String(line  
                                .getBytes("ISO-8859-1")));  */
                        sbuilder.append(new String(line
                                .getBytes("ISO-8859-1"),"utf-8")+"<br>");
                        lineNo++;
                        if(lineNo > 100){
                        	sbuilder.append("<div class='showInfo'>");
                        	sbuilder.append("<br>");
                        	sbuilder.append("-------------------------------------------------------------------------点此继续查看<img onclick=\"moreLogs();\" style='cursor:pointer;' src='style/icon/24.png'/>-----------------------------------------------------------------------------");
                        	sbuilder.append("<br>");
                        	sbuilder.append("</div>");

                        	//启动新线程查询全部
                        	FutureTask ft = new FutureTask(new Callable(){//初始加载全部的日志文件
                        		@Override
                        		public Object call() throws Exception {
                        			SortingLogFilter.addLogList(fileName, readFileAllLines(fileFullName));
                        			return null;
                        		}
                        	});
                        	new Thread(ft).start();
                        	break;
                        }
                    }
                    nextend--;  
                }  
                nextend--;  
                rf.seek(nextend);  
                if (nextend == 0) {// 当文件指针退至文件开始处，输出第一行  
                    line = rf.readLine();  
                    if (line != null && !"".equals(line.trim())) {
                    	sbuilder.append(new String(line
                                .getBytes("ISO-8859-1"),"utf-8")+"<br>");
                    }
                }  
            }
            
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (reader != null) { 
                try {  
                    reader.close();  
                } catch (IOException e1) {
                }
            }
        }  
        
        return sbuilder.toString();
    }
    
    public List<String> readFileAllLines(String fileFullName){
    	RandomAccessFile rf = null;  
        BufferedReader reader = null;  
        List<String> list = new ArrayList<String>();
        
        try {  
        	rf = new RandomAccessFile(fileFullName, "r"); 
        	long len = rf.length();  
            long start = rf.getFilePointer();  
            long nextend = start + len - 1;
            String line;  
            if(nextend < 0){
            	return null;
            }
            rf.seek(nextend);  
            int c = -1;  
        	while (nextend > start){
                c = rf.read();
                if (c == '\n' || c == '\r'){
                    line = rf.readLine();
                    if (line != null && !"".equals(line.trim())) {
                        /*System.out.println(new String(line  
                                .getBytes("ISO-8859-1")));  */
                    	list.add(new String(line
                                .getBytes("ISO-8859-1"),"utf-8")+"<br>");
                    }
                    
                    nextend--;  
                }  
                nextend--;  
                rf.seek(nextend);  
                if (nextend == 0) {// 当文件指针退至文件开始处，输出第一行  
                    line = rf.readLine();  
                   /* System.out.println(new String(line.getBytes("ISO-8859-1"),  
                            charset));  */
                    if (line != null && !"".equals(line.trim())) {
                    	list.add(new String(line
                                .getBytes("ISO-8859-1"),"utf-8")+"<br>");
                    }
                }  
            }
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (reader != null) { 
                try {  
                    reader.close();  
                } catch (IOException e1) {
                }
            }
        }  
        return list;
    }
}
