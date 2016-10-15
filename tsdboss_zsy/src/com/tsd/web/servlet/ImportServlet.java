package com.tsd.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.tsd.service.util.ClientOutPut;

public class ImportServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			doPost(request,response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			ImportData im = new ImportData();
			String fileFolder = request.getSession().getServletContext().getRealPath("/") + "fileupload"+"/";
			String dataSource = request.getParameter("cdatasource");//数据源
			String importFile = request.getParameter("importfile");// 导入文件
			String tableName = request.getParameter("tablename");//表名
			String columns = request.getParameter("columns");//导入数据列
			
			if(null!=dataSource&&null!=importFile&&null!=tableName&&null!=columns){
				String filePath = fileFolder + importFile;
				//String filePath = importFile;
				String tips = im.exeImport(dataSource, filePath, tableName, columns);
				ClientOutPut.printout(response, tips, "");
			}
	}
}
