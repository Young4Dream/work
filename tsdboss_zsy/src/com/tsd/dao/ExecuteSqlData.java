/*****************************************************************
 * name: ExecuteSqlData.java
 * author: youhongyu
 * version: 
 * description: 
 * modify: 2010-11-22 luoyulong 添加注释
 *****************************************************************/
package com.tsd.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.tsd.service.dto.TsdMap;
import com.tsd.service.util.HTMLFilter;
import com.tsd.service.util.LoadProperties;
import com.tsd.service.util.StringUtil;



/**
 * @author youhongyu
 * 根据传进来的配置文件 数据源 key 执行sql查询语句，并返回list表的数据集
 * 2010-8-19 9:04:40
 * */
public class ExecuteSqlData {	

	//sql 执行方式
	//private static PreparedStatement pst = null;
	private static final Boolean tsdSQLPrint = DBhelper.tsdSQLPrint;
	
	public static String exeSqlData(Map<String, String> paramsMap, List<TsdMap> params){
		Connection conn = null;		
		Statement st = null;
		ResultSet rs = null;
		
		//表的数据集
		//List dataSet=null;
		//boolean b = false;
		Object objdata, showval,val;
		String [] sqlNullColumn=null;
		String sType="";
		String sHTML="";
		String sMustItem="";
		String sDef="",sdval="";
		int j=0;
		
		//获取数据源
		String ds= paramsMap.get("ds");
		//System.out.println("ExecuteSqlData:ds:"+ds);
		String dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);	
		
		conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
		String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
		
		// query|exe
		sType = paramsMap.get("tsdType");//jsp元素类型,如:select div input...
		String stablename=paramsMap.get("tsdTable");//yhdang或hthdang表，用于区分id
		String tsdoper = paramsMap.get("tsdoper");
		if (!StringUtil.isNotEmpty(tsdoper)) {
			throw new RuntimeException("没有操作类型");
			// ClientOutPut.printout(response, "false", "");
		} else {

			String tsdpk = paramsMap.get("tsdpk");// /配置文件的key名
			String tsdcf = paramsMap.get("tsdcf");// /配置文件名
			if (tsdcf.equals(""))
			{
				tsdcf = dbName;//这里的配置文件名是根据当前的数据库连接自动匹配
			}
			else
			{
				tsdcf = dbName+"_"+tsdcf;//根据当前数据库名加上参数形成配置文件名.eg:oracle_business
			}

			if (StringUtil.isNotEmpty(tsdpk) && StringUtil.isNotEmpty(tsdcf)) {
				LoadProperties.getSql(tsdcf, tsdpk);// 自动加载所对应配置文件的中的指定key的值
			}

			String sql = LoadProperties.sql;
			sql = StringUtil.setCharEncode(sql, "utf-8");
			// 如果有行允许为空则做允许空的处理
			if (sql.indexOf("nullis[") != -1) {
				sqlNullColumn = sql.substring(sql.indexOf("nullis[") + 7,
						sql.indexOf("]")).split(",");
				sql = sql.substring(0, sql.indexOf("nullis["));
			}
			
			// 执行sql
			try {
				st = conn.createStatement();			
								
				// 加入可为空的列
				if (sqlNullColumn != null) {
					for (int i = 0; i < sqlNullColumn.length; i++) {
						String tempsql = sql.replaceAll("\\s+", "");
						String tempWhere = "";
						if (tempsql.indexOf(sqlNullColumn[i].trim() + "like"
								+ sqlNullColumn[i].trim()) != -1) {

							tempWhere = " (" + sqlNullColumn[i] + " like "
									+ sqlNullColumn[i] + " or "
									+ sqlNullColumn[i] + " is null )";
						} else if (tempsql.indexOf(sqlNullColumn[i].trim()
								+ "=" + sqlNullColumn[i].trim()) != -1) {
							tempWhere = " (" + sqlNullColumn[i] + " = "
									+ sqlNullColumn[i] + " or "
									+ sqlNullColumn[i] + " is null )";
						}

						sql = sql.replaceAll(sqlNullColumn[i] + "\\s*like\\s*"
								+ sqlNullColumn[i], tempWhere);
						sql = sql.replaceAll(sqlNullColumn[i] + "\\s*=\\s*"
								+ sqlNullColumn[i], tempWhere);
					}
				}
				
				if(tsdSQLPrint){
					System.out.println(paramsMap.get("tsdpk") + " >> ds:" + ds+ " >>>> sql:" + sql);
				}

				if ("query".equalsIgnoreCase(tsdoper)) {
					// /执行sql并获取结果集					
					rs = st.executeQuery(sql);
					//dataSet = new ArrayList<Map>();
					ResultSetMetaData rsmd = rs.getMetaData();
					int columnCount = rsmd.getColumnCount();
					if (sType.equalsIgnoreCase("select"))//返回下拉框数据
					{
						//由于在TOMCAT启动时不能确定用户选择的语言，因此，此处存标识，在页面读取数据时做字符串替换
						sHTML=sHTML+"<option value=\"\" selected=\"selected\">--[choose]--</option>";//--请选择--
					}
					else if (sType.equalsIgnoreCase("table"))//返回表格数据
					{
						sHTML="<tr>";
					}
					while (rs.next()) 
					{
						showval = "";//显示值
						val = "";//实际值
						if (sType.equalsIgnoreCase("select"))//返回下拉框数据
						{
							sHTML=sHTML+"<option lvalue=\"";					
							//lvalue 为所有字段值
							for (int i = 1; i <= columnCount; i++) {
								objdata = rs.getObject(i)==null ? "" : HTMLFilter.filter(rs.getObject(i).toString());
								//objdata = objdata.toString() == "0" ? "" : objdata;
								if (objdata.toString().equals("null"))
								{
									objdata = "";
								}
								if (i == 1)//第一个字段的值为显示值
								{
									showval = objdata;
								}
								if (i == 2)//第二个字段的值为实际值
								{
									val = objdata;
								}
								
								if (sType.equalsIgnoreCase("select"))//返回下拉框数据
								{
									sHTML=sHTML+ objdata + "|";
								}
							}//列

							sHTML = sHTML.substring(0, sHTML.length()-1);
							if (val.equals(""))
							{
								val = showval;
							}
							sHTML=sHTML+"\" value=\""+val+"\">"+showval+"</option>";
						}//end if select
						else if (sType.equalsIgnoreCase("table"))//返回表格数据 
						{
							showval = rs.getString("Field_Alias");
							if (showval==null)
							{
								showval = "";
							}
							val = rs.getString("Field_Name")+"_"+stablename;
							sdval = rs.getString("DefaultExpression");
							if (sdval==null)
							{
								sdval = "";
							}
							sDef+="<input type='hidden' id=def_"+val+" value=\""+sdval+"\"/>";
							if(rs.getInt("selecttype") ==1)//1表示下拉框 0表示输入框
							{
		        				if(rs.getInt("keytype")==2)//2：表示必选 ，其他表示可选
		        				{
		        					sHTML +="<td class='wenzi'>"+showval+"</td>";
		        					sHTML +="<td class='wenzix'><select name="+val+" id="+val+"  style='width: 150px;'/><font color='red'>*</font></td>";
		        					sMustItem=sMustItem+val+"|";
		        				}
		        				else//不为2表示可选
		        				{
		        					sHTML +="<td class='wenzi'>"+showval+"</td>";
		        					sHTML +="<td class='wenzix'><select name="+val+" id="+val+"  style='width: 150px;'/></td>";		        					
		        				}
	        				}
							else//0表示输入框
							{
	        				  if(rs.getInt("inputtype") ==2)//2:表示可输入数字 1：表示可输入字母
	        				  {
			        				if(rs.getInt("keytype") ==2){
			        					sMustItem=sMustItem+val+"|";		        					
			        					sHTML +="<td class='wenzi'>"+showval+"</td>";
			        					sHTML +="<td class='wenzix'><input type='text' name="+val+" id="+val+"  style='width: 150px;' style='ime-mode: Disabled' onkeypress='var k=event.keyCode;return k>=48&&k<=57' maxlength="+rs.getString("field_length")+" ondragenter='return false' onpaste='return false'/><font color='red'>*</font></td>";			        					
			        				}else{
			        					sHTML +="<td class='wenzi'>"+showval+"</td>";
			        					sHTML +="<td class='wenzix'><input type='text' name="+val+" id="+val+"  style='width: 150px;' style='ime-mode: Disabled' onkeypress='var k=event.keyCode;return k>=48&&k<=57' maxlength="+rs.getString("field_length")+" ondragenter='return false' onpaste='return false'/></td>";
			        				}
		        			   }else{
		        			   		if(rs.getInt("keytype") ==2){
		        			   			sMustItem=sMustItem+val+"|";		        					
			        					if(rs.getString("Field_Name")=="Yhdz"){
			        						sHTML +="<td class='wenzi'>"+showval+"</td>";
			        						sHTML +="<td class='wenzix' colspan=3><input type='text' name="+val+" id="+val+"  style='width: 260px;' maxlength="+rs.getString("field_length")+"  onpropertychange='TextUtil.NotMax(this)'/><font color='red'>*</font></td>";
											//j++;
			        					}else{
			        						sHTML +="<td class='wenzi'>"+showval+"</td>";
			        						sHTML +="<td class='wenzix'><input type='text' name="+val+" id="+val+"  style='width: 150px;' maxlength="+rs.getString("field_length")+"  onpropertychange='TextUtil.NotMax(this)'/><font color='red'>*</font></td>";
			       						}
			        				}else{
			        					if(rs.getString("Field_Name")=="Yhdz"){
			        						sHTML +="<td class='wenzi'>"+showval+"</td>";
			        						sHTML +="<td class='wenzix' colspan=3><input type='text' name="+val+" id="+val+"  style='width: 260px;' maxlength="+rs.getString("field_length")+"  onpropertychange='TextUtil.NotMax(this)'/></td>";
											//j++;
			        					}else{
			        						sHTML +="<td class='wenzi'>"+showval+"</td>";
			        						sHTML +="<td class='wenzix'><input type='text' name="+val+" id="+val+"  style='width: 150px;' maxlength="+rs.getString("field_length")+"  onpropertychange='TextUtil.NotMax(this)'/></td>";
			        					}
			        				}
		        			   }
							}
							//一行三列，换行
							j++;
		        			if(j==3){
		        				sHTML +="</tr><tr>";
	        					j=0;
	        				}
						}//end table
					}//行 end while
					if (sType.equalsIgnoreCase("table"))//返回表格数据
					{
						sHTML+="</tr><input type='hidden' id=mustitem_"+stablename+" value=\""+sMustItem+"\"/>"+sDef;
					}
				} 
			} catch (SQLException e) {
				sHTML = "";
				System.out.println("error time:"
						+ com.tsd.service.util.Log.getThisTime());
				System.out.println(paramsMap.get("tsdpk") + ">>ds:" + ds
						+ ">>>>sql:" + sql);
				throw new RuntimeException("access database exception:" + e);
			} finally {
				try {
					if (rs != null) {
						rs.close();
						rs = null;
					}
					if (st != null) {
						st.close();
						st = null;
					}
					if (conn != null) {
						conn.close();
						conn = null;
					}
				} catch (SQLException e) {
					throw new RuntimeException("close database exception:" + e);
				}
			}
			System.out.println(sHTML);
			return sHTML;	
			
		}		
	}	
}
