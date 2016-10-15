package com.tsd.service.util;

import java.util.List;
import java.util.regex.Pattern;
import com.tsd.dao.DataObj;

/**
 * @author youhongyu
 * @date 2010-9-9 
 * 常量表过滤器
 * */
public class ConstantFilterImpl implements ConstantFilterI {
	
	/**
	 * 一般过滤
	 * */
	public String originalFilter(List tablelist) {
		
		//定义一个变量用于存放拼接的xml
		StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
		xmls.append("<rows>");
		
		/**
		 * 过滤主体部分
		 * */
		//循环取出改常量表中的每条数据，并拼接成xml格式
		int length = tablelist.size();		
		for (int i = 0; i < length; i++) {
			xmls.append("<row ");
			List<DataObj> temp = (List) tablelist.get(i);
			if (temp.size() != 0 && temp.get(0) != null) {
				int tempSize = temp.size();
				for (int j = 0; j < tempSize; j++) {
					xmls.append(temp.get(j).getDataName()).append("=\"").append(temp.get(j).getDataVal()).append("\" ");
				}
			}
			xmls.append("></row>");
		}

		xmls.append("</rows>");	
		//把StringBuffer类型转化成String类型
		String xml = xmls.toString();
		System.out.println(xml);//打印到控制台		
		return xml;		
	}
	
	/**
	 * 两表关联过滤
	 * */
	public String associationFilter(List tablelist,String params) {
		//定义一个变量用于存放拼接的xml
		StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
		xmls.append("<rows>");
		
		//参数串不为空
		if(params!=null && !"".equals(params)){
			//解析字段名和字段值
			String[] filed = params.split(":");
			if(filed.length==2){
				if(filed[0] != null && !"".equals(filed[0])
					&& filed[1] != null && !"".equals(filed[1])){
					
					/**
					 * 过滤主体部分
					 * */
					//循环取出改常量表中的每条数据，并拼接成xml格式
					int length = tablelist.size();
					for (int i = 0; i < length; i++) {
						//遍历每一条记录
						List<DataObj> temp = (List) tablelist.get(i);						
						if (temp.size() != 0 && temp.get(0) != null) {
							
							int tempSize = temp.size();
							for (int j = 0; j < tempSize; j++) {								
								
								//字段值相等 放入xml中
								String value = temp.get(j).getDataVal().toString();
							   //	System.out.println(temp.get(j).getDataName()+">>>>"+filed[0]+"..........."+filed[1]+">>>>>>>>"+value);
								if(filed[0].equals(temp.get(j).getDataName()) && value.equals(filed[1]))
								{									
									//拼接相等的记录放入xml
									xmls.append("<row ");
									for (int k = 0; k < tempSize; k++) {
										xmls.append(temp.get(k).getDataName()).append("=\"").append(temp.get(k).getDataVal()).append("\" ");
									}
									xmls.append("></row>");
									break ;	//当找到一次对应的信息，就退出对字段的循环
								}//end if: 符合params记录
								
							}//end for 
						}//end if: temp.size
					}//end for: tablelist.length					
				}//end filed is not null
			}//end filed length==2
		}//end has params
		
		
		xmls.append("</rows>");	
		//把StringBuffer类型转化成String类型
		String xml = xmls.toString();
		System.out.println(xml);//打印到控制台		
		return xml;
				
		/**
		 * //参数串不为空
		if(params!=null && !"".equals(params)){
			//解析各字段
			String[] filedA = params.split(";");
			for(String value :filedA){
				//解析字段名和字段值
				String[] valueA = value.split(":");
				if(valueA[0] != null && !"".equals(valueA[0])){
					
				}
			}			
		}
		 * */
	}

	
	/**
	 * 部门过滤
	 * */
	public String departmentFilter(List tablelist,String params) {
		
		//定义一个变量用于存放拼接的xml
		StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
		xmls.append("<rows>");
		
		//param的格式为000.000.000 则不做任何处理
		String reg="^(0{3,5}\\.{0,1}){1,8}";
		Pattern pa=Pattern.compile(reg);
		if( !pa.matcher(params).matches()){
			Pattern params_v ;
			params_v =Pattern.compile("^"+params+".\\d{3,5}");
			
			//参数串不为空
			if(params==null || "".equals(params)){	
				params_v = Pattern.compile("^\\d{3,5}");//获取第一级菜单
			}
			
			
			/**
			 * 过滤主体部分
			 * */
			//循环取出改常量表中的每条数据，并拼接成xml格式
			int length = tablelist.size();	
			
			int tag = 0;//以查找到对应的所有信息，退出循环
			for (int i = 0; i < length; i++) {				
				
				//遍历每一条记录
				List<DataObj> temp = (List)tablelist.get(i);						
				if (temp.size() != 0 && temp.get(0) != null) {
					
					int tempSize = temp.size();
					for (int j = 0; j < tempSize; j++) {								
						
						//字段值相等 放入xml中
						String value = temp.get(j).getDataVal().toString();
						if("deptcode".equals(temp.get(j).getDataName()) && params_v.matcher(value).matches())
						{						
							tag = i;
							//拼接相等的记录放入xml
							xmls.append("<row ");
							for (int k = 0; k < tempSize; k++) {
								xmls.append(temp.get(k).getDataName()).append("=\"").append(temp.get(k).getDataVal()).append("\" ");
							}
							xmls.append("></row>");	
							break ;	//当找到一次对应的信息，就退出对字段的循环
						}//end if: 符合params记录						
						
					}//end for 
				}//end if: temp.size
				else {
					if(tag>0){
						break;//当tag>0，则表示已经找到了符合条件所有信息，可以退出循环
					}
				}
			}//end for: tablelist.length					
		}
					
		
		xmls.append("</rows>");	
		//把StringBuffer类型转化成String类型
		String xml = xmls.toString();
		System.out.println(xml);//打印到控制台		
		return xml;
	}
	
	
	/**
	 * 地址库
	 * */
	public String addressFilter(List tablelist,String params) {
		//定义一个变量用于存放拼接的xml
		StringBuffer xmls =new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ");
		xmls.append("<rows>");
		
		//param的格式为000.000.000 则不做任何处理
		String reg="^(0{3,5}\\.{0,1}){1,8}";
		Pattern pa=Pattern.compile(reg);
		if( !pa.matcher(params).matches()){		
			Pattern params_v ;
			params_v =Pattern.compile("^"+params+".\\d{3,5}");
			
			//参数串不为空
			if(params==null || "".equals(params)){	
				params_v = Pattern.compile("^\\d{3,5}");//获取第一级菜单
			}			
			
			/**
			 * 过滤主体部分
			 * */
			//循环取出改常量表中的每条数据，并拼接成xml格式
			int length = tablelist.size();	
			
			int tag = 0;//以查找到对应的所有信息，退出循环
			for (int i = 0; i < length; i++) {				
				
				//遍历每一条记录
				List<DataObj> temp = (List) tablelist.get(i);						
				if (temp.size() != 0 && temp.get(0) != null) {
					
					int tempSize = temp.size();
					for (int j = 0; j < tempSize; j++) {								
						
						//字段值相等 放入xml中
						String value = temp.get(j).getDataVal().toString();
						if("addrcode".equals(temp.get(j).getDataName()) && params_v.matcher(value).matches())
						{						
							tag = i;
							//拼接相等的记录放入xml
							xmls.append("<row ");
							for (int k = 0; k < tempSize; k++) {
								xmls.append(temp.get(k).getDataName()).append("=\"").append(temp.get(k).getDataVal()).append("\" ");
							}
							xmls.append("></row>");	
						}//end if: 符合params记录						
						break ;	//退出对字段的循环					
					}//end for
				}//end if: temp.size
				else {
					if(tag>0){
						break;
					}
				}
			}//end for: tablelist.length
		}
		
		
		xmls.append("</rows>");
		//把StringBuffer类型转化成String类型
		String xml = xmls.toString();
		System.out.println(xml);//打印到控制台
		return xml;
	}

}
