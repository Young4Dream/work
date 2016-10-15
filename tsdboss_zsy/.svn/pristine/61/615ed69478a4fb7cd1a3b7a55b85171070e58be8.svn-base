package com.tsd.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import com.alibaba.fastjson.JSONArray;
import com.tsd.dao.DBhelper;
import com.tsd.domain.OcsProfiles;
/**
 * 分拣配置
* <p>Title: OceParaService</p>
* <p>Description: create OceParaService</p>
* <p>Company: tsd</p> 
* @author yinyuelin
* @date Jan 14, 2016 / 1:35:48 PM
 */
public class OceParaService {

	private static TransactionTemplate txTemplate;
	
	private static JdbcTemplate jdbcTemplate;
	
	public OceParaService(){
		jdbcTemplate = (JdbcTemplate)DBhelper.context.getBean("jdbcTemplate");
		txTemplate = (TransactionTemplate)DBhelper.context.getBean("txTemplate");
	}
	public void query(HttpServletRequest request, HttpServletResponse response) {
		
		List<OcsProfiles> returnList = (List<OcsProfiles>)jdbcTemplate.execute("select t.id,t.name,t.value,t.displayname,t.visible,t.readonly,t.ispasswd,t.regex,t.tips,t.maxlength,t.isselect,t.datadict,t.jsmethod,t.orderindex,t.nullable from OCS_PARA t where t.visible = 'Y'order by t.orderindex", new PreparedStatementCallback (){
			@Override
			public Object doInPreparedStatement(PreparedStatement ps)
					throws SQLException, DataAccessException {
				ps.execute();  
		        ResultSet rs = ps.getResultSet(); 
		        
		        List<OcsProfiles> rt = new ArrayList<OcsProfiles>();
		        
		        OcsProfiles ocsPf= null;
		        while(rs.next()){
		        	ocsPf = new OcsProfiles();
		        	ocsPf.setId(rs.getInt("id"));
		        	ocsPf.setName(rs.getString("name"));
		        	ocsPf.setValue(rs.getString("value"));
		        	ocsPf.setDisplayName(rs.getString("displayname"));
		        	ocsPf.setVisible(rs.getString("visible"));
		        	ocsPf.setReadonly(rs.getString("readonly"));
		        	ocsPf.setIspasswd(rs.getString("ispasswd"));
		        	ocsPf.setRegex(rs.getString("regex"));
		        	ocsPf.setTips(rs.getString("tips"));
		        	ocsPf.setMaxlength(rs.getInt("maxlength"));
		        	ocsPf.setIsselect(rs.getString("isselect"));
		        	ocsPf.setDataDict(rs.getString("datadict"));
		        	ocsPf.setJsMethod(rs.getString("jsmethod"));
		        	ocsPf.setOrderIndex(rs.getInt("orderindex"));
		        	ocsPf.setNullable(rs.getString("nullable"));
		        	rt.add(ocsPf);
		        }
				return rt;
			}
		});
		
		String json = "";
		if(returnList != null){
			json = JSONArray.toJSONString(returnList);
		}
		backToPage(json, response);
	}

	public void update(final HttpServletRequest request, final HttpServletResponse response) {
		
		txTemplate.execute(new TransactionCallback(){
			@Override
			public Object doInTransaction(TransactionStatus ts) {
				try{
					String params = request.getParameter("params");
					String[] param = params.split(";;;");
					for(int i = 0; i < param.length; i ++){
						String vals = param[i];
						if(vals != null && !"".equals(vals)){
							String key = vals.split(":::")[0];
							String value = vals.split(":::")[1];
							upd(key, value);
						}
					}
					backToPage("yes", response);
				}catch(Exception e){
					e.printStackTrace();
					backToPage("no", response);
					ts.isRollbackOnly();
				}
				return null;
			}
		});
		
	}
	
	public void status(HttpServletRequest request, HttpServletResponse response){
		OcsProfiles ret = (OcsProfiles)jdbcTemplate.execute("select t.id,t.name,t.value,t.displayname,t.visible,t.readonly,t.ispasswd,t.regex,t.tips,t.maxlength,t.isselect,t.datadict,t.jsmethod,t.orderindex,t.nullable from OCS_PARA t where t.name='BasePath'", new PreparedStatementCallback (){
			@Override
			public Object doInPreparedStatement(PreparedStatement ps)
					throws SQLException, DataAccessException {
				ps.execute();  
		        ResultSet rs = ps.getResultSet(); 
		        
		        OcsProfiles ocsPf= null;
		        while(rs.next()){
		        	ocsPf = new OcsProfiles();
		        	ocsPf.setId(rs.getInt("id"));
		        	ocsPf.setName(rs.getString("name"));
		        	ocsPf.setValue(rs.getString("value"));
		        	ocsPf.setDisplayName(rs.getString("displayname"));
		        	ocsPf.setVisible(rs.getString("visible"));
		        	ocsPf.setReadonly(rs.getString("readonly"));
		        	ocsPf.setIspasswd(rs.getString("ispasswd"));
		        	ocsPf.setRegex(rs.getString("regex"));
		        	ocsPf.setTips(rs.getString("tips"));
		        	ocsPf.setMaxlength(rs.getInt("maxlength"));
		        	ocsPf.setIsselect(rs.getString("isselect"));
		        	ocsPf.setDataDict(rs.getString("datadict"));
		        	ocsPf.setJsMethod(rs.getString("jsmethod"));
		        	ocsPf.setOrderIndex(rs.getInt("orderindex"));
		        	ocsPf.setNullable(rs.getString("nullable"));
		        }
				return ocsPf;
			}
		});
		
		
		String status = request.getParameter("status");
		if(status != null){
			int stat = Integer.parseInt(status);
			
			String[] cmd = new String[2];
			cmd[0] = "sh";
			switch(stat){
				case 1:
					cmd[1] = ret.getValue()+"/"+"start.sh";//启动命令
					break;
				case 2:
					cmd[1] = ret.getValue()+"/"+"stop.sh";//停止命令
					break;
				case 3:
					cmd[1] = ret.getValue()+"/"+"restart.sh";//重启命令
					break;
				case 4:
					cmd[1] = ret.getValue()+"/"+"status.sh";//监控状态命令
					break;
			
			}
			
			InputStream in = null; 
			try {  
				Process pro = Runtime.getRuntime().exec(cmd);
	            pro.waitFor();  
	            in = pro.getInputStream();  
	            if(in != null){
	            	BufferedReader read = new BufferedReader(new InputStreamReader(in));  
	 	            String result = read.readLine();  
	 	            if(result != null){
	 	            	 backToPage(result, response);
	 	            }else{
	 	            	 backToPage("ok", response);
	 	            }
	 	           
	            }else{
	            	backToPage("ok", response);
	            }
	           
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }finally{
	        	if(in != null){
	        		try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
	        	}
	        }  
		}
	}
	
	private void upd(String name, String value){
		jdbcTemplate.execute("update ocs_para set value='"+value+"' where name='"+name+"'");
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
}
