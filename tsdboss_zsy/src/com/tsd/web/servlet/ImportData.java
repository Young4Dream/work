package com.tsd.web.servlet;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.Log;

public class ImportData {
	/**
	 * 读取导入数据
	 * @param  filePath
	 * @return ArrayList
	 */
	public ArrayList readExecl(String filePath){
		System.out.println("A000001===="+filePath);
		ArrayList dataList = new ArrayList();
		try {
			Workbook book = Workbook.getWorkbook(new File(filePath));
			//Sheet[] arr = book.getSheets();//获取sheet的个数
			//ArrayList sqllist = null;
			Sheet sheet = book.getSheet(0);//获得第一个工作表对象
			System.out.println("A000002===="+sheet);
			int cols = sheet.getColumns();//数据列数
			int rows = sheet.getRows();//数据行数
			ArrayList rowList = null;
			for(int i = 1 ; i < rows;i++){
				rowList = new ArrayList(); 
				for(int j = 0 ; j < cols;j++){
					Cell cell = sheet.getCell(j, i); 
					String result = cell.getContents();
					rowList.add(result);
				}
				dataList.add(rowList);
			}
			System.out.println(filePath+"模板数据列："+dataList);
			book.close();
		} catch (Exception e) {
			System.out.println("读取数据时，出现异常信息："+e.getMessage());
			//e.printStackTrace();
		}
		return dataList;
	}
	
	/**
	 * 把Execle 数据插入数据库中
	 * @param datasource 数据源
	 * @param tableName  表名
	 * @param tableRows  对应数据列
	 * @param alist		 数据列值
	 * @return
	 */
	public String insertIntoTable(String datasource,String tableName,String tableRows,ArrayList alist){
		Connection conn = null;
		PreparedStatement ps = null;
		int count = 0;//成功添加数据的条数
		String result = "";
		String quesNum = "";
		//System.out.println(tableRows);
		if(tableRows.indexOf(",")!=-1){
			String[] tips = tableRows.split(",");
			for(int i = 0 ;i<tips.length ;i++){
				quesNum += "?,";
			}
			quesNum = quesNum.substring(0,quesNum.lastIndexOf(","));
		}else{
			quesNum = "?";
		}
		System.out.println("tableName===="+tableName);
		String sql = "INSERT INTO "+tableName+"("+tableRows+") VALUES("+quesNum+")";
		System.out.println("-----"+sql);
		try {
			conn = DBhelper.getConnection(datasource);//加载数据源
			System.out.println("conn===="+conn);
			if(null!=conn){
				ps = conn.prepareStatement(sql);
				if(null!=alist){
					for(int i = 0 ; i < alist.size();i++){
						ArrayList resultList = (ArrayList)alist.get(i);
						for(int j = 0 ; j < resultList.size();j++){
							ps.setObject(j+1, resultList.get(j));
						}
						ps.addBatch();
					}
					int[] res = ps.executeBatch();
					count = res.length;
					result = count + "";//成功添加的数据
				}
			}	
		} catch (SQLException e) {
			System.out.println("插入数据失败，异常信息提示："+e.getMessage());
			//e.printStackTrace();
			result = "error";
		}
		return result;
	}
	/**
	 * 数据导入
	 * @param datasource 导入数据源 
	 * @param filePath   文件路径
	 * @param tableName  表名
	 * @param rowsList   数据列
	 * @return
	 */
	public String exeImport(String datasource,String filePath,String tableName,String rowsList){
		ArrayList resList = readExecl(filePath);//读取excel
		System.out.println("resList===="+resList);
		System.out.println("111111111===="+filePath);
		System.out.println("222222222===="+resList);
		String tips = "";
		if(null!=resList){
			tips = insertIntoTable(datasource,tableName,rowsList,resList);
			if(!"".equals("error")){
				System.out.println("successful：导入成功，成功导入"+tips+"条数据。执行操作时间："+Log.getThisTime());
			}else{
				System.out.println("error：导入数据失败。执行操作时间："+Log.getThisTime());
			}
		}
		return tips;
	}
	
	public static void main(String args[]){
		ImportData i = new ImportData();
		i.exeImport("tsdBilling","e://TsdImport.xls","TsdImport","a,b,c");
	}
}