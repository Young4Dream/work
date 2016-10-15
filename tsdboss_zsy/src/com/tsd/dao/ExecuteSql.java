/*****************************************************************
 * name: ExecuteSql.java
 * author: dangchengcheng
 * version: 
 * description: 
 * modify: 2010-11-19 luoyulong 添加注释
 * modify: 2010-11-30 wenxuming 可导出格式修改，更新之后可导出四种格式 dbf excel xml txt
 * modify: 2010-12-06 youhongyu 对输入xml的日期进行格式化 
 * modify: 2010-12-08 wenxuming 修改导出excel、txt 为null替换为空
 * modify: 2011-5-23  youhongyu 在执行sql语句时，对clob类型字段读取
 * modify: 2012-9-6   chenliang 修改注释，增加打印输出控制
 *****************************************************************/
package com.tsd.dao;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;

import com.tsd.dbf.DBFWriter;
import com.tsd.dbf.JDBFException;
import com.tsd.dbf.JDBField;
import com.tsd.service.dto.TsdMap;
import com.tsd.service.util.ClientOutPut;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.StringUtil;

/**
 * 负责处理前台
 */
public class ExecuteSql {
	/**
	 * 此处jdbcTemplate、hibernateTemplate 两个模板对象已初始化自动加载 不需要在进行xml注入或者再次获取 直接调用即可
	 */
	//只声明，没调用，注释于：2012-09-06，chenliang
	
	/**
	private static JdbcTemplate jdbcTemplate = DBhelper.jdbcTemplate;
	private HibernateTemplate hibernateTemplate = DBhelper.hibernateTemplate;
	private static PreparedStatement pst = null;
	*/
	
	//获取日志输出等级，chenliang ，2012-09-06
	//private static int printLevel = Integer.parseInt(LoadProperties.getKeyValues("mainSystem", "tsdLogPrint"));
	private static final Boolean tsdSQLPrint = DBhelper.tsdSQLPrint;
	private static final Boolean tsdResultPrint = DBhelper.tsdResultPrint;
	
	/**
	 * exeSqlData 方法根据请求来执行对应配置文件的SQL语句，根据请求的返回要求返回数据
	 * @param request 请求对象
	 * @param response 响应对象
	 * @param params 参数列表
	 * @param ds 数据源
	 * @return 返回对应的JAVA对象
	 */
	public static Object exeSqlData(HttpServletRequest request,
		HttpServletResponse response, List<TsdMap> params, String ds,String sqlParams) {
		Map<String,Map<String,Object>> dictStoredMap= null;
		//System.out.println("tsdSQLPrint: "+tsdSQLPrint);
		//System.out.println("tsdResultPrint: "+tsdResultPrint);
		Connection conn = null;
		Statement st = null;
		PreparedStatement ps=null; 
		ResultSet rs = null;
		List dataSet=null;
		String [] sqlNullColumn=null;
		//String unresolvedSQL = null;
		//String [] tsdpkpagesqlColumn=null;
		boolean b = false;
		int count = 0;
		int ipage = 0;
		int total_pages = 0;
		// 获取用户指定的返回数据类型 xml/json
		String datatype = request.getParameter("datatype");
		if (!StringUtil.isNotEmpty(datatype)) {
			datatype = "xml";
		}
		String page = request.getParameter("page");
		String rows = request.getParameter("rows");
		if (!StringUtil.isNotEmpty(rows)) {
			rows = "10";
		}
		if (!StringUtil.isNotEmpty(page)) {
			page = "1";
		}
		String tsdUserId = request.getParameter("tsdUserId");
		HttpSession session = request.getSession();
		if(StringUtil.isNotEmpty(tsdUserId)){
			if(session.getAttribute("userid") != null){
				tsdUserId=session.getAttribute("userid").toString();
			}
		}
		String pagerStart = String.valueOf((Integer.valueOf(page)-1)*Integer.valueOf(rows));
		String dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);//获取数据源配置
		conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
		String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
		
		//将rb_field字典变为map集合为后续key替换为value准备
		//modify by mingliang on2015-12-15
		if("xml".equalsIgnoreCase(datatype)){
			try { 
				String tablename =  request.getParameter("tablename");
				if( null != tablename && "null" != tablename) 
				 dictStoredMap =  queryRbFieldDictMap(conn,tablename);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		// query|exe
		String tsdoper = request.getParameter("tsdoper");
		if (!StringUtil.isNotEmpty(tsdoper)) {
			System.out.println("[tsdoper exception & tsdoper param ]："+tsdoper);
			throw new RuntimeException("dose not operate type.");//没有操作类型
			//ClientOutPut.printout(response, "false", "");
		} else {
			String tsdpk = request.getParameter("tsdpk");// /配置文件的key名
			//System.out.println("正在执行的sql语句：>>>>> "+tsdpk);
			String tsdcf = request.getParameter("tsdcf");// /配置文件名
			
			if (tsdcf == null || "mssql".equals(tsdcf) || "mysql".equals(tsdcf)){
				tsdcf = dbName;//根据数据库自动选择配置文件
			}else{
				 //存在这样的BUG，当前台tsdcf传入oracle这样的字符串时就会自动拼接成oracle_oracle，会直接报错
				//前台指定读取配置文件跟数据库名称相同时，默认按数据库配置，chenliang，2012-09-06
				if(!tsdcf.equals(dbName)){
					tsdcf = dbName+"_"+tsdcf.replace(dbName+"_", "");//根据当前数据库名加上参数形成配置文件名.eg:oracle_business
				}
			}
			//System.out.println("sql语句所在配置文件：>>>>> "+tsdcf);
			// //////////////////////////////////////////////
			// /分页参数
			// /////////////////////////////////////////////
			String tsdpkpagesql = request.getParameter("tsdpkpagesql");// 一般为总行数的sql语句
			//tsdpkpagesqlColumn
			//String sql = null;
			if (StringUtil.isNotEmpty(tsdpk) && StringUtil.isNotEmpty(tsdcf)) {
				//sql = LoadProperties.getKeyValue(tsdcf, tsdpk);// 自动加载所对应配置文件的中的指定key的值
				LoadProperties.getSql(tsdcf, tsdpk);
			}
			String sql = LoadProperties.sql;
			if(tsdSQLPrint){
				if("".equals(sql)){
					System.out.println("=============================================================================");
					System.out.println("=======  Error , ["+tsdpk+"] is not config in ["+ tsdcf +"]    ==========");
					System.out.println("=============================================================================");
					return "error";
				}
			}
			//unresolvedSQL = sql;
			//如果有行允许为空则做允许空的处理
			if(sql.indexOf("nullis[")!=-1){
				sqlNullColumn=sql.substring(sql.indexOf("nullis[")+7,sql.indexOf("]")).split(",");
				sql=sql.substring(0,sql.indexOf("nullis["));
			}
			int len = params.size();
			// 执行sql
			try {
				st = conn.createStatement();
				if (StringUtil.isNotEmpty(tsdpkpagesql) && StringUtil.isNotEmpty(tsdcf)) {
					//tsdpkpagesql = LoadProperties.getKeyValue(tsdcf, tsdpkpagesql);// 自动加载所对应配置文件的中的指定key的值
					LoadProperties.getSql(tsdcf, tsdpkpagesql);
				}
				///计算分页
				if (StringUtil.isNotEmpty(tsdpkpagesql)) {// 如果传入分页语句
					//例子 tsdpkpagesql slect * from table_name where c1=<1> and c2=<2> c3=<3>
					tsdpkpagesql= LoadProperties.sql;
					for (int i = 0; i <len ; i++) {
						TsdMap tm = params.get(i);
						String regx = "<" +tm.getKeyName()+ ">";
						if(!StringUtil.isNotEmpty(tm.getKeyVal())){
							if (tm.getKeyName().equalsIgnoreCase("rows")) {
								sql=sql.replaceAll(regx, rows);continue;
							}
							//当查询条件自己等于自己的时候进行条件替换
							String regx1="'(%)?"+regx+"(%)?'";
							//regx1="'<"+regx+">'";
							tsdpkpagesql=tsdpkpagesql.replaceAll(regx1, tm.getKeyName());
							tsdpkpagesql=tsdpkpagesql.replaceAll("'"+regx+"'", tm.getKeyName());
							tsdpkpagesql=tsdpkpagesql.replaceAll(regx, tm.getKeyName());
						}else{
							tsdpkpagesql=tsdpkpagesql.replaceAll(regx, tm.getKeyVal());
						}
					}
					
					Integer limits = Integer.parseInt(rows);
					//加入可为空的列
					if(sqlNullColumn!=null){
						for (int i = 0; i < sqlNullColumn.length; i++) {
							String tempsql=tsdpkpagesql.replaceAll("\\s*", "");
							String tempWhere="";
							if(tempsql.indexOf(sqlNullColumn[i]+"like"+sqlNullColumn[i])!=-1){
								
								tempWhere=" ("+sqlNullColumn[i]+" like "+sqlNullColumn[i]+" or "+sqlNullColumn[i]+" is null )";
							}else if(tempsql.indexOf(sqlNullColumn[i]+"="+sqlNullColumn[i])!=-1){
								tempWhere=" ("+sqlNullColumn[i]+" = "+sqlNullColumn[i]+" or "+sqlNullColumn[i]+" is null )";
							}
							tsdpkpagesql=tsdpkpagesql.replaceAll(sqlNullColumn[i]+"\\s+like\\s+"+sqlNullColumn[i], tempWhere);
							tsdpkpagesql=tsdpkpagesql.replaceAll(sqlNullColumn[i]+"\\s+=\\s+"+sqlNullColumn[i], tempWhere);
						}
					}
					tsdpkpagesql=tsdpkpagesql.replaceAll("<tsdUserId>", tsdUserId);
					if(tsdpkpagesql.indexOf("nullis[")!=-1){
						tsdpkpagesql=tsdpkpagesql.substring(0,tsdpkpagesql.indexOf("nullis["));
					}
					rs = st.executeQuery(tsdpkpagesql);
					//System.out.println("pagesql>>"+tsdpkpagesql);//分页的sql语句
					while (rs.next()) {
						count=rs.getInt(1);
					}
					if(Integer.valueOf(pagerStart)>count){
						pagerStart=String.valueOf(count-Integer.valueOf(rows));
						if(Integer.valueOf(Integer.valueOf(pagerStart))<0){
							pagerStart="0";
						}
					}
					ipage = Integer.parseInt(page);
					if (count > 0) {
						total_pages = (int) Math.ceil((double) count
								/ (double) limits);
					}
					if (total_pages == 0) {
						total_pages = 1;
					}
					if (ipage > total_pages) {
						ipage = total_pages;
						page = Integer.toString(ipage);
					}
				}
				/////排序
				String sidx=request.getParameter("sidx");
				String sord=request.getParameter("sord");
				String ssorder="";
				if(StringUtil.isNotEmpty(sord)&&StringUtil.isNotEmpty(sidx)){
					ssorder=" order by "+sidx+" "+sord;
					sql=sql.replaceAll("<tsdOrderBy>", ssorder);
					//System.out.println("Grid排序：" + ssorder);
					//System.out.println("组合排序：" + request.getParameter("orderby"));
					String orderbystr = request.getParameter("orderby");
					if(StringUtil.isNotEmpty(orderbystr))
					{
						orderbystr = orderbystr + "," + sidx + " " + sord;
						sql=sql.replaceAll("<orderby>", orderbystr);
					}
				}else{
					sql=sql.replace("<tsdOrderBy>", "");
				}
				
				for (int i = 0; i <len ; i++) {
					TsdMap tm = params.get(i);
					String regx = "<" +tm.getKeyName()+ ">";
					if(!StringUtil.isNotEmpty(tm.getKeyVal())&&!tsdoper.equals("exe")){
						if (tm.getKeyName().equalsIgnoreCase("rows")) {
							sql=sql.replaceAll(regx, rows);continue;
						}
						String regx1="'(%)?"+regx+"(%)?'";
						//regx1="'<"+regx+">'";
						sql=sql.replaceAll(regx1, tm.getKeyName());
						
						sql=sql.replaceAll("'"+regx+"'", tm.getKeyName());
						sql=sql.replaceAll(regx, tm.getKeyName());
						
					}else{
						sql=sql.replaceAll(regx, tm.getKeyVal());
					}
				}
				
				sql=sql.replaceAll("<pagerStart>", pagerStart);
				sql=sql.replaceAll("<tsdUserId>", tsdUserId);
								
				//加入可为空的列
				if(sqlNullColumn!=null){
					for (int i = 0; i < sqlNullColumn.length; i++) {
						String tempsql=sql.replaceAll("\\s+", "");
						String tempWhere="";
						if(tempsql.indexOf(sqlNullColumn[i].trim()+"like"+sqlNullColumn[i].trim())!=-1){
							
							tempWhere=" ("+sqlNullColumn[i]+" like "+sqlNullColumn[i]+" or "+sqlNullColumn[i]+" is null )";
						}else if(tempsql.indexOf(sqlNullColumn[i].trim()+"="+sqlNullColumn[i].trim())!=-1){
							tempWhere=" ("+sqlNullColumn[i]+" = "+sqlNullColumn[i]+" or "+sqlNullColumn[i]+" is null )";
						}
						
						sql=sql.replaceAll(sqlNullColumn[i]+"\\s*like\\s*"+sqlNullColumn[i], tempWhere);
						sql=sql.replaceAll(sqlNullColumn[i]+"\\s*=\\s*"+sqlNullColumn[i], tempWhere);
					}
				}

				//yyl add级联查询
				String keyval = request.getParameter("keyval");
				if(null != keyval){
					sql=sql.replaceAll("<keyval>", keyval);
				}
				
				
				//System.out.println("key>>"+request.getParameter("tsdpk")+";config>>"+tsdcf+";ds>>"+ds+";sql>>"+sql);
				if(tsdSQLPrint){
					System.out.println("===================================================================================");
					System.out.println("[Datasource]: " + ds);
					System.out.println("[PropertyFile]: "+tsdcf);
					System.out.println("[SQL Key]: "+request.getParameter("tsdpk"));
					//System.out.println("[Unresolved SQL]: "+unresolvedSQL);
					System.out.println("[SQL Params]: " + sqlParams);
					System.out.println("[Resolved SQL]: " + sql);
					System.out.println("[User Login IP]: " + session.getAttribute("userloginip"));
				}
				if ("query".equalsIgnoreCase(tsdoper)) {
					// /执行sql并获取结果集
					rs = st.executeQuery(sql);
					dataSet = new ArrayList<Map>();
					ResultSetMetaData rsmd = rs.getMetaData();
					int columnCount = rsmd.getColumnCount();
					while (rs.next()) {
						List<DataObj> rowObj = new ArrayList<DataObj>();
						for (int i = 1; i <= columnCount; i++) {
							DataObj dataObj = new DataObj();
							dataObj.setDataName(rsmd.getColumnName(i));
							//将null和null字符串替换为空
							Object obdate = rs.getObject(i);							
							if(obdate==null || "null".equals(obdate)){
								obdate="";								
							}
							//对类型为date的值进行格式化
							if(obdate instanceof Date){
								SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								obdate= format.format(obdate);
							}
							//使类型为Clob输出为string值
							String content = "";
							try {
								if (obdate instanceof Clob) {
									content = ClobToString((Clob) obdate);
									obdate=content;
								}
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}						
							dataObj.setDataVal(obdate);
							rowObj.add(dataObj);
						}
						dataSet.add(rowObj);
					}
				} else if ("exe".equalsIgnoreCase(tsdoper)) {
					dataSet = new ArrayList();
					// 单纯的执行sql
					st.execute(sql);
					b=true;	
				}
				/////////////////////////////////////
				// /返回属性形式的xml数据
				// ///////////////////////////////////////
				//if ("datafileDown".equalsIgnoreCase(datatype)) {
				//System.out.println("XML传到后台的值："+datatype);
				if ("txt".equalsIgnoreCase(datatype)||"dbf".equalsIgnoreCase(datatype)||"xmlx".equalsIgnoreCase(datatype)||"xls".equalsIgnoreCase(datatype)){
					// System.out.println("XML传到后台的值进来了："+datatype);
					 //HttpSession session = request.getSession();
					 String tablename =  (String)session.getAttribute("table");
					 //System.out.println("table:"+tablename);
					//增加长度判断，如果表名长度大于31则截取到第一个空格位
					if(tablename.length()>31){
						tablename = tablename.substring(0, tablename.trim().indexOf(' '));
						//如果截取后长度任然大于31则直接截取31位
						if(tablename.length()>31){
							tablename = tablename.substring(0,31);
						}
					}
					HSSFWorkbook workbook = new HSSFWorkbook();//excel文件,一个excel文件包含多个表
			        HSSFSheet sheet = workbook.createSheet();//表，一个表包含多个行
			        workbook.setSheetName(0, tablename, HSSFWorkbook.ENCODING_UTF_16);// 设置sheet中文编码;			       
			        String exportflag = (String)session.getAttribute("exportflag");
			        String[] scolumn = null;
			        boolean flags = false;
			        
			        //导出字段限制 (0：字段小于20的) 平台在页面传参事需对参数进行转码导致参数过长,易截断
			        	//0:为要导出的字段大于20个      其它：导出的字段个数小于等于20个
			        if(!"0".equals(exportflag)&&null!=exportflag){
			        	//执行导出需要的参数
			        	String tablenameExp = (String)request.getParameter("tablealias");			        	
			        	String dataSourceNameExp = LoadProperties.getKeyValues("mainSystem","tsdBilling");				        
			        	Connection connExp = DBhelper.getConnection(dataSourceNameExp);			       
			        	String dbNameExp = DBhelper.getDatabaseProductName(connExp);//根据数据连接获得数据库名			        	
			        	String tmpsql="";			        	
			        	//根据不同的数据库进行不同的sql拼接
			        	if("oracle".equalsIgnoreCase(dbNameExp)){
			        		//取在执行导出时保存的列
				        	tmpsql = "select Field_Name, case instr(field_alias,'zh') when 0 then '' else substr(field_alias,instr(field_alias,'zh')+3, case when instr(field_alias,'/}',instr(field_alias,'zh'))-instr(field_alias,'zh')-3 <=0  then 0 else instr(field_alias,'/}', instr(field_alias,'zh'))-instr(field_alias,'zh')-3 end ) end as disname from rb_field where lower(table_name)=lower(?) and instr(field_alias,'{zh')!=0 order by showorder asc,ID asc";
				        	
						}else if("enterprisedb".equalsIgnoreCase(dbNameExp)){
							//取在执行导出时保存的列
				        	tmpsql = "select Field_Name,substring(field_alias,'{zh=([^}]+)/}')  as disname from rb_field where lower(table_name)=lower(?) and position('{zh' in Field_Alias)!=0 order by showorder asc,ID asc";
				        	
						}else{
							//取在执行导出时保存的列
				        	tmpsql = "select Field_Name as Field_Name,case charindex('zh',isnull(Field_Alias,'')) when 0 then '' else substring(isnull(Field_Alias,''),charindex('zh',isnull(Field_Alias,''))+3,case when charindex('/}',isnull(Field_Alias,''),charindex('zh',isnull(Field_Alias,'')))-charindex('zh',isnull(Field_Alias,''))-3 <=0 then 0 else charindex('/}',isnull(Field_Alias,''),charindex('zh',isnull(Field_Alias,'')))-charindex('zh',isnull(Field_Alias,''))-3 end ) end as disname from rb_field where table_name=? and charindex('{zh',Field_Alias)!=0 order by showorder asc,ID asc";
				        	
						}
			        	ps = connExp.prepareStatement(tmpsql);
			        	//System.out.println("要导出表的字段数超过20的表名：>>>>>>>>>>>>>>>>>"+tablenameExp);
			        	//如果没有传入表别名，则根据表名到别名表中查询
			        	if ("undefined".equals(tablenameExp)) {
			        		tablenameExp = tablename;
			        	}
			        	ps.setString(1, tablenameExp);			        	
			        				        
			        	rs = ps.executeQuery();
			        	String colum_ = "";
			        	//将临时表数据取出
			        	String fieldname = "";
			        	while(rs.next()){
			        		String thefield = rs.getString("Field_Name");
			        		String thename = rs.getString("disname");
			        		if("".equals(thefield)||"null".equals(thefield)){			        			
			        			colum_ += thefield + ",";
			        		}else{
			        			colum_ += thefield + " as " + thename + ",";			        			
			        		}
			        		fieldname += thename + ",";
			        	}
			        	
			        	if("".equals(colum_)){
			        		System.out.println("get column failure...");//获取数据列失败
			        		return null;
			        	}
			        	
			        	colum_ = colum_.substring(0,colum_.lastIndexOf(","));
			        	fieldname = fieldname.substring(0,fieldname.lastIndexOf(","));
			        	
			        	//执行导出需要的参数
			        	String whichsql =  (String)session.getAttribute("whichsql");
			        	String fusearchsql = (String)session.getAttribute("fusearchsql");
			        	String fieldtable = (String)session.getAttribute("fieldtable");
			        	
			        	String str = "";
			        	if("1".equals(whichsql)){
			        		str  = " and table_name="+fieldtable;
			        	}
			        	
			        	//拼接导出的sql语句
			        	sql = "select " + colum_ + " from " + tablename + " where " + fusearchsql + str;
			        	//System.out.println("sql:...............................:"+sql);
			        	if(tsdSQLPrint){
							System.out.println("===================================================================================");
							System.out.println("[Export excute SQL]: "+sql);
							System.out.println("===================================================================================");
						}
			        	String[] tmparr = fieldname.split(",");
			        	scolumn = new String[tmparr.length];
			        	for(int i = 0 ; i < tmparr.length;i++){
			        		scolumn[i] = tmparr[i];
			        	}
			        	flags = true;
			        	if(connExp != null){
							connExp.close();
						}
			        }
			        
					try {
						rs = st.executeQuery(sql);
						dataSet = new ArrayList<Map>();
						dataSet.add("tmpian");//添加一条临时数据
						int columnCount = 0;
						ResultSetMetaData rsmd = rs.getMetaData();
						if(flags==false){
							columnCount = rsmd.getColumnCount();
						}else if(flags==true){
							columnCount = scolumn.length;
						}
						//System.out.println("开始导出..."+com.tsd.service.util.Log.getThisTime());
					//到处excl文件	
					if ("xls".equals(datatype)) {
						for(int i = 0 ; i < columnCount;i++){
							 //生成表头
					        HSSFRow row = sheet.createRow((short)0);
					        HSSFCell cell = row.createCell((short)i);
							cell.setEncoding(HSSFCell.ENCODING_UTF_16);// 设置cell中文编码;
							cell.setCellType(HSSFCell.CELL_TYPE_STRING);
							if(flags==false){
								cell.setCellValue(rsmd.getColumnName(i+1));
							}else if(flags==true){
								cell.setCellValue(scolumn[i]);
							}
						}
						//设置值
						int k = 1;
						while (rs.next()) {
							HSSFRow row = sheet.createRow((short)k);
							for(int i = 0; i < columnCount; i++) {
								HSSFCell cell = row.createCell((short)i);
								cell.setEncoding(HSSFCell.ENCODING_UTF_16);// 设置cell中文编码;
								cell.setCellType(HSSFCell.CELL_TYPE_STRING);	
								//导出的excel中null显示为空处理
								try{							
										//System.out.println(rsmd.getColumnClassName(i + 1).toString());	
										if (rs.getObject(i+1)!=null&&"java.math.BigDecimal".equals(rsmd.getColumnClassName(i + 1).toString())) {
											cell.setCellValue(rs.getDouble(i+1));
										}else if(rs.getObject(i+1)!=null&&"java.lang.Integer".equals(rsmd.getColumnClassName(i + 1).toString())){
											cell.setCellValue(rs.getInt(i+1));
										}else if(rs.getObject(i+1)!=null){
											cell.setCellValue(rs.getObject(i+1)+"");
										}else{
											cell.setCellValue(""+"");
										}
								}catch (Exception e) {
									e.printStackTrace();
								}	
							}
							k++;
							//当数据量大时，需设置tomcat虚拟内存，不然很容易出现内存溢出的情况
						}
						//request.getSession().getServletContext().getRealPath("/");
						String filefolder = request.getSession().getServletContext().getRealPath("/") + "tmpexportdata";
						File file = new File(filefolder);
						if(file.exists()==false){
							file.mkdir();
						}
						String filename = "report_"+com.tsd.service.util.Log.getThisTime().substring(0, 10)+"_"+Math.random()+".xls";
						//String filepath = filefolder+"\\"+filename;//windows下的路径
						String filepath = filefolder+"/"+filename;//linx下的路径
						File f = new File(filepath);
						f.createNewFile();
						FileOutputStream fOut;
						fOut = new FileOutputStream(f);
						workbook.write(fOut);
						fOut.flush();
						fOut.close();
						//文件生成
						//String fileName = "report.xls";    //下载后文件的默认文件名，显示在点击下载后弹出的保存对话框
						//fileName = URLEncoder.encode(fileName, "utf-8");
						// 清除输出缓冲区中的数据
						response.reset();
						response.setContentType("application/x-download" + ";charset=UTF-8"); //设置输出格式，application/x-msdownload则是将下面文件内容显示在页面上
						response.setHeader("content-disposition", "attachment;filename="
						    + tablename+".xls");
						BufferedInputStream bis = null;
						BufferedOutputStream bos = null;
						
						bis = new BufferedInputStream(new FileInputStream(filepath));
						bos = new BufferedOutputStream(response.getOutputStream());
						
						byte[] buff = new byte[20*1024];
						int bytesRead;

						while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
						    bos.write(buff, 0, bytesRead);
						}
						bos.flush();
						//System.out.println("导出成功..."+com.tsd.service.util.Log.getThisTime());
						if (bis != null){
							bis.close();
						}
						if (bos != null){
							bos.close();
						}
						//当天执行第一次导出时，自动清理以前的所有导出临时文件，将以前的文件删除，只保留当天的文件
						File[] filelist = file.listFiles();
						if(filelist.length>0){
							Date now = new Date() ;
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd") ;
							String n = formatter.format(now); 
							for(int i = 0 ; i < filelist.length;i++){
								String[] filenames = filelist[i].getName().split("_");
								int flag = filenames[1].compareTo(n);
								if(flag<0){
									filelist[i].delete();
								}
							}
						}

				//到处txt文件		
				}else if("txt".equals(datatype)){					
					/***************************************************
					 * 导出txt类型文件
					 **************************************************/
					FileOutputStream outSTr = null;
					BufferedOutputStream Buff = null;
					String filefolder = request.getSession().getServletContext().getRealPath("/")+ "tmpexportdata";
					String tab = " ";
					String enter = "\r\n";
					StringBuffer write;
					String filename = "report_"+ com.tsd.service.util.Log.getThisTime().substring(0, 10) + "_"+ Math.random() + ".txt";
					//String filepath = filefolder+"\\"+filename;//windows下的路径
					String filepath = filefolder+"/"+filename;//linx下的路径
					File file = new File(filefolder);
					if (file.exists() == false) {
						file.mkdir();
					}
					try {
						outSTr = new FileOutputStream(new File(filepath));
						Buff = new BufferedOutputStream(outSTr);
						for (int i = 0; i < columnCount; i++) { // 生成表头
							if (flags == false) {
								write = new StringBuffer();
								write.append(rsmd.getColumnName(i + 1));
								write.append(tab);
								Buff.write(write.toString().getBytes("UTF-8"));
							} else if (flags == true) {
								write = new StringBuffer();
								write.append(scolumn[i]);
								write.append(tab);
								Buff.write(write.toString().getBytes("UTF-8"));
							}
						}
						int k = 1;
						while (rs.next()) {
							write = new StringBuffer();	
							write.append(enter);
							
							//数据为null时显示空
							for (int i = 0; i < columnCount; i++) {								
								if(rs.getObject(i + 1)!=null){
									write.append(rs.getObject(i + 1) + tab);
								}else{
									write.append("\t" + tab);
								}
							}
							write.append(enter);
							Buff.write(write.toString().getBytes("UTF-8"));
							k++;
						}

						Buff.flush();
						Buff.close();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						try {
							Buff.close();
							outSTr.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}					
					// 文件生成
					// String fileName = "report.xls";
					// //下载后文件的默认文件名，显示在点击下载后弹出的保存对话框
					// fileName = URLEncoder.encode(fileName, "utf-8");
					// 清除输出缓冲区中的数据
					response.reset();
					response.setContentType("application/x-download"+ ";charset=UTF-8"); // 设置输出格式，application/x-msdownload则是将下面文件内容显示在页面上
					response.setHeader("content-disposition","attachment;filename=" + "report.txt");
					BufferedInputStream bis = null;
					BufferedOutputStream bos = null;
					bis = new BufferedInputStream(new FileInputStream(filepath));
					bos = new BufferedOutputStream(response.getOutputStream());
					byte[] buff = new byte[20 * 1024];
					int bytesRead;					
					while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
						bos.write(buff, 0, bytesRead);
					}
					bos.flush();
					if (bis != null) {
						bis.close();
					}
					if (bos != null) {
						bos.close();
					}
					// 将以前的文件删除，只保留当天的文件
					File[] filelist = file.listFiles();
					if (filelist.length > 0) {
						Date now = new Date();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						String n = formatter.format(now);
						for (int i = 0; i < filelist.length; i++) {
							String[] filenames = filelist[i].getName().split("_");
							int flag = filenames[1].compareTo(n);
							if (flag < 0) {
								filelist[i].delete();
							}
						}
					}
					// ////////////////////////////////////////////////////////////////////////////////////////////
				
				//到处xml文件
				}else if("xmlx".equals(datatype)){					
					/***************************************************
					 * 导出为XML文件
					 **************************************************/
					Document doc = DocumentHelper.createDocument();
					// 生成根节点
					Element root = doc.addElement("ROOT");
					// 表的字段数目
					int countt = rsmd.getColumnCount();
					// 存入列名数组
					String[] columnName = new String[countt];
					for (int i = 1; i <= countt; i++) {
						columnName[i - 1] = rsmd.getColumnName(i);
					}
					try {
						int i;
						while (rs.next()) {
							Element emp = root.addElement("ROW");
							for (i = 0; i < columnCount; i++) {
								Element column = emp.addElement(columnName[i]);
								if (rs.getObject(i + 1) != null) {
									column.setText(rs.getObject(i + 1)+ "");
								} else {
									column.setText("no data");//没有数据
								}
							}
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					String filefolder = request.getSession().getServletContext().getRealPath("/")+ "tmpexportdata";
					String filename = "report_"+ com.tsd.service.util.Log.getThisTime().substring(0, 10) + "_"+ Math.random() + ".xml";
					//String filepath = filefolder+"\\"+filename;//windows下的路径
					String filepath = filefolder+"/"+filename;//linx下的路径
					File file = new File(filefolder);
					if (file.exists()== false){
						file.mkdir();
					}
					// 写入文件
					//Writer w = new FileWriter(filepath);//dom4j中要想设置utf-8编码不能直接用writer里的FileWriter 应该用一个输出流FileOutStream来替代才能导出格式为UTF-8
					FileOutputStream fos = new FileOutputStream(filepath);
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter xw = new XMLWriter(new FileOutputStream(filepath));
					// xw.toString().getBytes("UTF-8");
					xw.write(doc);
					// 关闭文件流
					xw.close();
					fos.close();
					System.out.println("==========create complete==============");	//生成完毕						
					// 文件生成
					// String fileName = "report.xls";
					// //下载后文件的默认文件名，显示在点击下载后弹出的保存对话框
					// fileName = URLEncoder.encode(fileName, "utf-8");
					// 清除输出缓冲区中的数据
					response.reset();
					response.setContentType("application/x-download"+ ";charset=UTF-8"); // 设置输出格式，application/x-msdownload则是将下面文件内容显示在页面上
					response.setHeader("content-disposition","attachment;filename=" + "report.xml");
					BufferedInputStream bis = null;
					BufferedOutputStream bos = null;
					bis = new BufferedInputStream(new FileInputStream(filepath));
					bos = new BufferedOutputStream(response.getOutputStream());
					byte[] buff = new byte[20 * 1024];
					int bytesRead;					
					while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
						bos.write(buff, 0, bytesRead);
					}
					bos.flush();
					if (bis != null) {
						bis.close();
					}
					if (bos != null) {
						bos.close();
					}
					// 将以前的文件删除，只保留当天的文件
					File[] filelist = file.listFiles();
					if (filelist.length > 0) {
						Date now = new Date();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						String n = formatter.format(now);
						for (int i = 0; i < filelist.length; i++) {
							String[] filenames = filelist[i].getName().split("_");
							int flag = filenames[1].compareTo(n);
							if (flag < 0) {
								filelist[i].delete();
							}
						}
					}
					// ///////////////////////////////////////////////////////////////////////////////////////
				
				//到处为dbf文件	
				}else if("dbf".equals(datatype)){					
					/***************************************************
					 * 导出DBF文件类型
					 **************************************************/
					String filefolder = request.getSession().getServletContext().getRealPath("/")+ "tmpexportdata";
					String filename = "report_"+ com.tsd.service.util.Log.getThisTime().substring(0, 10) + "_"+ Math.random() + ".dbf";
					//String filepath = filefolder+"\\"+filename;//windows下的路径
					String filepath = filefolder+"/"+filename;//linx下的路径
					File file = new File(filefolder);
					if (file.exists() == false){
						file.mkdir();
					}
					try {
						// 表的字段数目
						int dbfcount = rsmd.getColumnCount();
						JDBField ajdbfield[] = new JDBField[dbfcount];
						char car = 'C';
						int itn = 20;
						int rtype = 0;
						for (int i = 0; i < dbfcount; i++) {
							if ("java.lang.String".equals(rsmd.getColumnClassName(i + 1).toString())) {
								car = 'C';
								itn = 253;
								rtype = 0;
							} else if ("java.lang.Integer".equals(rsmd.getColumnClassName(i + 1).toString())) {
								car = 'N';
								itn = 20;
								rtype = 2;
							} else if ("java.sql.Time".equals(rsmd.getColumnClassName(i + 1).toString())) {
								car = 'D';
								itn = 8;
								rtype = 0;
							}else if("java.sql.Timestamp".equals(rsmd.getColumnClassName(i+1).toString())){
								car = 'D';
								itn = 8;
								rtype = 0;
							}else if("java.math.BigDecimal".equals(rsmd.getColumnClassName(i+1).toString())){
								car = 'N';
								itn = 20;
								rtype = 0;
							}
							ajdbfield[i] = new JDBField(rsmd.getColumnName(i + 1), car, itn,rtype);
						}
						System.out.println("building dbf fields！");//正在生成DBF字段
						DBFWriter dbfwriter = new DBFWriter(filepath,ajdbfield);
						int i;
						Object aobj[] = new Object[columnCount];
						while (rs.next()) {
							//System.out.println("正在写入数据！");
							for (i = 0; i < columnCount; i++) {
								//System.out.println(rs.getObject(i + 1));
								aobj[i] = rs.getObject(i + 1);
								dbfwriter.addRecord(aobj);
							}
						}
						dbfwriter.close();
						System.out.println("success！");
					} catch (JDBFException e) {
						// TODO Auto-generated catch block
						System.out.println("write failure！");
						e.printStackTrace();
					}
					/*
					 * 生成文件后打成压缩包
					 */
					String filenamezip = "report_"+ com.tsd.service.util.Log.getThisTime().substring(0, 10) + "_"+ Math.random() + ".zip";
					//String filepathzip = filefolder + "\\" + filenamezip;
					String filepathzip = filefolder + "/" + filenamezip;
					//boolean flagzip = false;
					try {
						zipcatalog(filefolder,filepathzip,filepath);								
					} catch(ServletException e){
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					// 文件生成
					// String fileName = "report.xls";
					// //下载后文件的默认文件名，显示在点击下载后弹出的保存对话框
					// fileName = URLEncoder.encode(fileName, "utf-8");
					// 清除输出缓冲区中的数据
					response.reset();
					response.setContentType("application/x-download"+ ";charset=UTF-8"); // 设置输出格式，application/x-msdownload则是将下面文件内容显示在页面上
					response.setHeader("content-disposition","attachment;filename=" + "report.zip");
						BufferedInputStream bis = null;
						BufferedOutputStream bos = null;
						bis = new BufferedInputStream(new FileInputStream(filepathzip));
						bos = new BufferedOutputStream(response.getOutputStream());
						byte[] buff = new byte[20 * 1024];
						int bytesRead;
						while (-1 != (bytesRead = bis.read(buff, 0, buff.length))){
							bos.write(buff, 0, bytesRead);
						}
						bos.flush();
						if (bis != null){
							bis.close();
						}
						if (bos != null){
							bos.close();
						}
						
						//下载完成后删除服务器上的原文件
						File filedelte = new File(filepath);
						// 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
						if(filedelte.exists() && filedelte.isFile()) {
							if(filedelte.delete()) {
								System.out.println("delete file " + filepath + "success！");
								return true;
							} else {
								System.out.println("delete file " + filepath + "failure！");
								return false;
							}
						} else {
							System.out.println("delete file failure：" + filepath + "dose not exist！");
							return false;
						}
					/////////////////////////////////////////////////////////////////////////////////////////
				}		
					}catch (SQLException e) {
						e.printStackTrace();
					}catch (FileNotFoundException e) {
						e.printStackTrace();
					}catch (IOException e) {
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				b = false;
				System.out.println("===================================================================================");
				System.out.println("[SQLException , exception time]: " + com.tsd.service.util.Log.getThisTime());
				System.out.println("[Datasource]: " + ds);
				System.out.println("[PropertyFile]: " + tsdcf);
				System.out.println("[SQL Key]: " + request.getParameter("tsdpk"));
				System.out.println("[SQL Value]: " + sql);
				System.out.println("[SQL Params]: " + sqlParams);
				System.out.println("[User Login IP]: " + session.getAttribute("userloginip"));
				//System.out.println(request.getParameter("tsdpk")+">>>>ds:"+ds+">>>>sql:"+sql);
				throw new RuntimeException("[SQL Exception]: " + e);
			} finally {
				try {
					if (rs != null) {
						rs.close();
						rs=null;
					}
					if (st != null) {
						st.close();
						st=null;
					}
					if(conn !=null){
						conn.close();
						conn=null;
					}
					
				} catch (SQLException e) {
					throw new RuntimeException("exception when close database:" + e);//关闭数据库操作异常
				}
			}
			if (b==true) {
				ClientOutPut.printout(response, "true", "");
			}
			if (dataSet == null) {
				
			}else if (dataSet.size() == 0 ) {
				if("query".equalsIgnoreCase(tsdoper)){
					//System.out.println(dataSet.size());
					String xmls = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><rows><row>false</row></rows> ";
					ClientOutPut.printout(response, xmls, "xml");
					return false;
				}
			}else{
			// /////////////////////////////////////
			// /返回Map键值对形式的数据 适用于懂java编程的用户
			// ///////////////////////////////////////
			if ("map".equalsIgnoreCase(datatype)) {
				List<Map> dataSetMap = new ArrayList<Map>();
				int length = dataSet.size();
				for (int i = 0; i < length; i++) {
					List<DataObj> temp = (List) dataSet.get(i);
					Map rowMap = new HashMap();
					if (temp.size() != 0 && temp.get(0) != null) {
						int tempSize = temp.size();
						for (int j = 0; j < tempSize; j++) {
							rowMap.put(temp.get(j).getDataName(), temp.get(j)
									.getDataVal());
						}
					}
					dataSetMap.add(rowMap);
				}
				return dataSetMap;
			}
			// /////////////////////////////////////
			// /返回xml形式的数据
			// ///////////////////////////////////////
			if ("xml".equalsIgnoreCase(datatype)) {

				List<Map> dataSetMap = new ArrayList<Map>();
				StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
				xmls.append("<rows>");
				if (StringUtil.isNotEmpty(tsdpkpagesql)) {
					xmls.append("<page>").append(page).append("</page>");
					xmls.append("<total>").append(Integer.toString(total_pages)).append(
						 "</total>");
					xmls.append("<records>").append(Integer.toString(count)).append("</records>");
				}
				int length = dataSet.size();

				for (int i = 0; i < length; i++) {
					xmls.append("<row");
					String idColumnName=request.getParameter("idColumnName");
				
					List<DataObj> temp = (List) dataSet.get(i);
					if(StringUtil.isNotEmpty(idColumnName)){
						if (temp.size() != 0 && temp.get(0) != null) {
							int tempSize = temp.size();
							for (int j = 0; j < tempSize; j++) {

									if(idColumnName.equals(temp.get(j).getDataName())){
										xmls.append(" id=\""+temp.get(j).getDataVal()+"\"");
										break;
									}
							}
						}
					}
					xmls.append(">");
					if (temp.size() != 0 && temp.get(0) != null) {
						int tempSize = temp.size();
						String sVal="";
						for (int j = 0; j < tempSize; j++) {
							//modify by lvkui on2009-11-29
							//解决日志表里的>>>的显示问题
							if (temp.get(j).getDataVal()!=null)
							{
								sVal = temp.get(j).getDataVal().toString();
								sVal = sVal.replaceAll(">>>","&gt;&gt;&gt;");
								//modify by mingliang on2015-12-15
								if(null != dictStoredMap && dictStoredMap.containsKey(temp.get(j).getDataName().toLowerCase())){
									sVal = (String) dictStoredMap.get(temp.get(j).getDataName().toLowerCase()).get(sVal);
									if(null == sVal){
										sVal = "";
									}
								}
								xmls.append("<cell>").append(sVal).append("</cell>");
							}
							else
							{
								xmls.append("<cell>").append("").append("</cell>");
							}
						}
					}
					xmls.append("</row>");
				}
				xmls.append("</rows>");
				//是否同步输出数据返回结果，chenliang ，2012-09-07
				if(tsdResultPrint){
					System.out.println("[SQL XML Result]: "+xmls.toString());
				}
				ClientOutPut.printout(response, xmls.toString(), "xml");
				return xmls;
			}
			
//			 /////////////////////////////////////
			// /返回属性形式的xml数据
			// ///////////////////////////////////////
			if ("xmlattr".equalsIgnoreCase(datatype)) {
				
				List<Map> dataSetMap = new ArrayList<Map>();
				StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
				xmls.append("<rows>");
				int length = dataSet.size();
				
				for (int i = 0; i < length; i++) {
					xmls.append("<row ");
					List<DataObj> temp = (List) dataSet.get(i);
					if (temp.size() != 0 && temp.get(0) != null) {
						int tempSize = temp.size();
						for (int j = 0; j < tempSize; j++) {
							xmls.append(temp.get(j).getDataName()).append("=\"").append(temp.get(j).getDataVal()).append("\" ");
						}
					}
					xmls.append("></row>");
				}
				xmls.append("</rows>");
				//是否同步输出数据返回结果，chenliang ，2012-09-07
				if(tsdResultPrint){
					System.out.println("[SQL XMLAttr Result]: "+xmls.toString());
				}
				//System.out.println(xmls);
				ClientOutPut.printout(response, xmls.toString(), "xml");
				//System.out.println(xmls.toString());
				return xmls;
			}
			

				// //////////////////////////////////// /
				// /返回json形式的数据
				// ///////////////////////////////////////
				if ("jsonattr".equalsIgnoreCase(datatype)) {

					List<Map> dataSetMap = new ArrayList<Map>();
					String json = "{";
					json += "rows : [";

					int length = dataSet.size();

					for (int i = 0; i < length; i++) {
						json += "{";
						List<DataObj> temp = (List) dataSet.get(i);
						if (temp.size() != 0 && temp.get(0) != null) {
							int tempSize = temp.size();
							for (int j = 0; j < tempSize; j++) {
								json += temp.get(j).getDataName() + " : \""
										+ temp.get(j).getDataVal() + "\"";
								if (j == tempSize - 1) {
									continue;
								}
								json += ",";
							}
						}
						if (i == length - 1) {
							json += "}";
							continue;
						}
						json += "},";
					}
					json += "]}";
					
					//是否同步输出数据返回结果，chenliang ，2012-09-07
					if(tsdResultPrint){
						System.out.println("[SQL Json Result]: "+json.toString());
					}
					//System.out.println(json);
					try {
						response.setHeader("Charset", "UTF-8");
						response.setCharacterEncoding("UTF-8");
						response.setContentType("text/plain");
						PrintWriter out = response.getWriter();
						out.write(json);
						out.flush();
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
					return json;
				}
			}
			return false;
		}
	}
	
	/**
	 * 对到处生成的DBF文件进行打包压缩为ZIP格式的（应该DBF格式文件超级的大必须压缩）
	 */
	public static boolean zipcatalog(String path,String zipfile,String filepath)throws IOException , ServletException { 
        boolean bf = true; 
        File [] file=null; 
        File p=new File(path); 
        File ff = new File(zipfile); 
        if(ff.exists()){ 
            ff.delete(); 
        }
        if(!p.exists()){ 
            throw new ServletException("the dir is not exist " + path); //目录不存在
        } 
        if(!p.isDirectory()){ 
            throw new ServletException("the dir is invalidation "+ path); //无效的目录
        }                 
        file=p.listFiles();         
        FileOutputStream out = new FileOutputStream(zipfile); //1 
        //创建ZIP数据输出流对象 
        ZipOutputStream zipOut = new ZipOutputStream(out); 
        if(file!=null){ 
                try{
                    //创建文件输入流对象 
                    FileInputStream in = new FileInputStream(filepath); //0
                    //生成压缩文件路径
                    System.out.println("create path of compress file……："+filepath.substring(filepath.lastIndexOf(File.separator)+1));
                    //创建文件输出流对象 
                    //创建指向压缩原始文件的入口 
                    ZipEntry entry = new ZipEntry(filepath.substring(filepath.lastIndexOf(File.separator)+1)); //0 
                    zipOut.putNextEntry(entry); 
                    //向压缩文件中输出数据 
                    int nNumber;
                    byte[] buffer = new byte[20*1024];
                    while ( (nNumber = in.read(buffer)) != -1) 
                        zipOut.write(buffer, 0, nNumber);                   
                    	System.out.println("compressing files……");//正在压缩文件
                    //关闭创建的流对象 
                    in.close();
                }catch (IOException e){ 
                    bf = false;
                }
        }
        zipOut.close(); 
        out.close(); 
        p=null;
        ff = null;
        return bf; 
    }
	
	// 将字CLOB转成STRING类型
	public static String ClobToString(Clob clob) throws SQLException, IOException {
		String reString = "";
		Reader is = clob.getCharacterStream();// 得到流
		BufferedReader br = new BufferedReader(is);
		String s = br.readLine();
		StringBuffer sb = new StringBuffer();
		while (s != null) {// 执行循环将字符串全部取出付值给StringBuffer由StringBuffer转成STRING
			sb.append(s);
			s = br.readLine();
		}
		reString = sb.toString();
		return reString;
	}
	
	/**
	 * 外部话费导入 Dao
	 * 	
	 * 		weList	外部话费记录
	 * 		siz		单条记录列数
	 * 
	 * */ 
	public static void executeImport(List<String> wbList, int siz)
	{
		int num = 0;
		String sql = "";
		String [] tmp = new String[siz];
		try
		{
			String dataSourceName = LoadProperties.getKeyValues("mainSystem", "tsdBilling");//获取数据源配置
			Connection conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
			Statement sta = conn.createStatement();
			for( String str : wbList )
			{
				if( num >= 1 )
				{
					if( str != null && !"".equals(str) )
					{
						sql = "";
						tmp = new String[siz];
						tmp = str.split(",");
						sql = "insert into other_dhedit(HFLY,HZYF,DH,HEJI) values('TEST',"+201412+",'"+tmp[0]+"',"+tmp[1]+")";
						sta.addBatch(sql);
					}
				}
				num ++;
			}
			// 批量执行外部话费记录插入处理
			sta.executeBatch();
			sta.close();
			conn.close();
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	/**
	 * @param conn
	 * @param tableName
	 * @return
	 * @throws Exception
	 * 将rb_field中配置的字典转化为map
	 */
	public static Map<String,Map<String,Object>> queryRbFieldDictMap(Connection conn,String tableName) throws Exception{
		Map<String ,Map<String,Object>> dictMap = new HashMap<String,Map<String,Object>>();
		String sql = "select t.field_name,t.datadict from rb_field t where (t.table_name = ? or t.table_name = ?) and t. datadict is not null and t.WEBSELECTABLE = 'T'";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setString(1, tableName.toLowerCase());
		pst.setString(2, tableName.toUpperCase());
		
		ResultSet rs = pst.executeQuery();
		while(rs.next()){
			//rs.getString("field_name");
			Map<String,Object> fieldDict = new HashMap<String,Object>();
			String dictString =  rs.getString("datadict");
			//<DICT=0:是;1:否/>
			if(-1 != dictString.indexOf("<DICT") && -1 != dictString.indexOf(":")){//配置的固定值的字典数据并且是key:value形式的才处理
				dictString= dictString.replaceAll("<DICT=", "");
				dictString= dictString.replaceAll("<DICT", "");
				dictString= dictString.replaceAll("=", "");
				dictString= dictString.replaceAll("/>", "");
				String[] dicts = dictString.trim().split(";");
				for(String dic: dicts){
					String[] di = dic.split(":");
					fieldDict.put(di[0], di[1]);
				}
				//dictMap.put(rs.getString("field_name").toLowerCase(), fieldDict);
			}else if(dictString.contains("select") && dictString.contains(",")){//sql语句关联其他表查询的情况
				//sql语句查询单个值的不处理，sql语句查询key:value的处理
				if(dictString.contains("<keyval>")){//如果配置的是管理查询字段需要把条件去掉变成可执行的sql语句
					//去掉分号，如果第一个有值就取第一个，第三个有值就将第一个的值覆盖
					String[] sqls =  dictString.split(";");
					for(String dictSql : sqls){
						if(null != dictSql && "" != dictSql){
							dictString = dictSql;
						}
					}
					if(dictString.contains("<keyval>") && dictString.contains("where")){
						dictString = dictString.substring(0, dictString.indexOf("where"));
					}
				}
				if(!dictString.contains(",") || !dictString.contains("select")){continue;}
				PreparedStatement dictPst = conn.prepareStatement(dictString);
				ResultSet dictRs = dictPst.executeQuery();
				while(dictRs.next()){
					fieldDict.put(dictRs.getString(1), dictRs.getString(2));
				}
			}
			if(!fieldDict.isEmpty()){
				dictMap.put(rs.getString("field_name").toLowerCase(), fieldDict);
			}
		}
		if(dictMap.isEmpty()){return null;}
		return dictMap;
	}
	
}