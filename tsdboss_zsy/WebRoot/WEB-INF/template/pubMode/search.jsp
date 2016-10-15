<%----------------------------------------
	name: search.jsp
	author: youhongyu
	version: 1.0, 2009-10-07
	description: 通用查询 用于高级查询、批量查询、批量删除、批量修改等操作
		2010-11-05 youhongyu 添加注释功能		
		2011-01-06 chenze    调置当没有选中节点时，取根节点为选中节点
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.tsd.query.model.TableQuery" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");	
	String tablename = (String)session.getAttribute("tablename");
	String tableflag = (String)session.getAttribute("tableflag");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="oper.title"/></title>

		<!-- jqgrid css 
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		-->
		<!-- jquery -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<!-- jqgrid 
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		 -->
		<!-- company -->
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>

		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!--  -->
		<script type="text/javascript" src="script/public/revenue.js" ></script>
		
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		
		<!-- tree -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
				
		<!-- 该页面的js文件 -->
		<script type="text/javascript" src="script/pubMode/search.js" ></script>
		<link href="style/css/pubMode/search.css" rel="stylesheet" type="text/css" />  		
               
 		<script type="text/javascript">
			
			//查询条件树用数组的形式存放，以下参数用于存放树的相关信息     
        	//树，记录节点显示信息
        	var nodestrA = ['<fmt:message key="global.query"/>']; //初始化第一个节点信息
        	//树，记录父节点id
        	var nodeparentA = [-1];
        	//树，记录节点本身id
        	var nodechildA = [0];
        	//树，节点显示图片  	
        	var nodepicA =[""];
        	//树，节点的sql子句
        	var sqlA = ["1=1"];
        	//树，节点与上一个节点之间的关系
        	var relationA = ["and"];
        	//树，子节点id获取
        	var nodechildid=0;        	
        	        	
        	var dmtree = new dTree('dmtree'); //定义一个树变量        	  	
        	var lnum=0;//用于表示当前选中的字段  
        	//用于判断进入这个页面的的状态，分别为查询、删除、修改。
        	var queryName;    
        	
        	/**
			* 页面初始化
			* @param 
			* @return 
			*/
        	$(document).ready(function(){
     		
			     		//获取queryName元素中的值，确定面板头部应该显示信息
			     		var titlestr = window.dialogArguments.document.getElementById("queryName").value;
			     		var addinfo ='';
			     		if(titlestr=='delete'){
			     			addinfo= $("#topdeleteinfo").val();
			     		}else if(titlestr=='modify'){
			     			addinfo= $("#topmodifyinfo").val();
			     		}else{
			     			addinfo= $("#topqueryinfo").val();        			
			     		}
			     		tsd.setTitle($("h3"),addinfo);
			     		      		
			     		hideArea();//隐藏查询值区     		
			     		getI18n();//根据选择的语言解析字段        		
			     		appendHiddenField();//getSCQuery();//页面右侧生成一个空树
			     		
			     		
						//设置oper、relation单选按钮组，默认选中项
						var operequalinfo= $("#operequalinfo").val();
						$("input[name='oper'][value='"+operequalinfo+"']").attr("checked","checked");				
						$("input[name='relation'][value='and']").attr("checked","checked");
				
				
						//加载 addParentNode 添加同级条件 单击事件的执行函数
						$("#addParentNode").click(function(){
									//获取查询值						
									var message=getMessage();									
									//如果未选择值，或是没有输入查询值,message的值为false		
										//因为在js中0会被当作false，所以这里需要判断一下message的类型				
									if(message==false&&typeof(message)=='boolean'){return false;}
									
									var oper = $("input[name='oper']:checked").val();//操作符
									//选中自定义运算符方式，没有输入运算符，提示输入运算符
									if(!getOperA(oper)){return false;}
									//获取运算符
									oper=getOperA(oper);
									
									var relation =$("input[name='relation']:checked").val();//条件与条件之间and或or关系			
									var Table_Name =$("input[name='Table_Name']").val();//表名
									var Field_Name =$("input[name='Field_Name']").val();//字段名
									var Field_Alias = $("input[name='Field_Alias']").val();//字段页面显示值
									var DataType=$("input[name='DataType']").val();//字段类型	
									
									var nodestr=Field_Alias+oper+" "+message;//树节点显示值
									var IgnoreUppercase = $("#IgnoreUppercase").is(":checked");	//是否忽略大写字母
									var sqlstr ='';//sql语句字符串
												
								
									//父节点id获取
									var parentid;					
									if(nodestrA.length<=1&&typeof(dmtree.aNodes[dmtree.selectedNode])=='undefined'){
										parentid=0;
									}
									else if(nodestrA.length>1&&typeof(dmtree.aNodes[dmtree.selectedNode])=='undefined'){
										//alert($("#operwornnsel").val());//请选择一个节点！
										//return false;
										parentid=0;                 //2011-01-06日修改，当默认没有选中节点时，设置根节点为选中
									}
									else if(dmtree.aNodes[dmtree.selectedNode].pid==-1)
									{ 
										parentid=0;
									}	
									else
									{ 
										parentid = dmtree.aNodes[dmtree.selectedNode].pid;//树节点的父id
									}					
									
									message = formatMessage(oper,message,DataType);	//格式化message
									
									if(IgnoreUppercase)//忽略查询条件中的大小写
									{
										sqlstr=" lower("+Field_Name+") "+oper+" lower("+message+")";	//sql子语句拼接
									}
									else
									{
										sqlstr=Field_Name+" "+oper+" "+message;	//sql子语句拼接
									}
																										
									updateTreeA(nodestr,parentid,sqlstr,relation);//更新存放树节点新的数组
									generateTree();//生成树
						});	
										
							
						//加载 addChildNode 添加子级 单击事件的执行函数
						$("#addChildNode").click(function(){
									//获取查询值
									var message=getMessage();	
									//如果未选择值，或是没有输入查询值,message的值为false		
										//因为在js中0会被当作false，所以这里需要判断一下message的类型				
									if(message==false&&typeof(message)=='boolean'){return false;}
																								
									var oper = $("input[name='oper'][checked]").val();//操作符						
									//判断是否自定义运算符
									if(!getOperA(oper)){return false;}	
									//获取运算符
									oper=getOperA(oper);									
													
									var relation =$("input[name='relation']:checked").val();//条件与条件之间and或or关系
									var Table_Name =$("input[name='Table_Name']").val();//表名
									var Field_Name =$("input[name='Field_Name']").val();//字段名
									var Field_Alias = $("input[name='Field_Alias']").val();//字段页面显示值
									var DataType=$("input[name='DataType']").val();//字段类型
								
									var nodestr=Field_Alias+oper+" "+message;
									var IgnoreUppercase = $("#IgnoreUppercase").is(":checked");	//是否忽略大写字母
									var sqlstr ='';//sql语句字符串
									
									var parentid;
									if(nodestrA.length<=1&&typeof(dmtree.aNodes[dmtree.selectedNode])=='undefined'){
										parentid=0;
									}
									else if(nodestrA.length>1&&typeof(dmtree.aNodes[dmtree.selectedNode])=='undefined'){
										//alert($("#operwornnsel").val());//请选择一个节点！
										//return false;
										parentid=0;                 //2011-01-06日修改，当默认没有选中节点时，设置根节点为选中
									}					
									else
									{ 
										parentid = dmtree.aNodes[dmtree.selectedNode].id;//树节点的父id
									}									
									
									message = formatMessage(oper,message,DataType);	//格式化message
									if(IgnoreUppercase)//忽略查询条件中的大小写
									{
										sqlstr=" lower("+Field_Name+") "+oper+" lower("+message+")";	//sql子语句拼接
									}
									else
									{
										sqlstr=Field_Name+" "+oper+" "+message;	//sql子语句拼接
									}
									updateTreeA(nodestr,parentid,sqlstr,relation);//更新存放树节点新的数组
									generateTree();//生成树
						});	
			});
        	    	
        </script>         

</head>	
<body>

<div  style="text-align:left;padding-left: 1px;padding-right:1px;">
	<div style="background:url(style/images/public/kuangbg.jpg);width:688px;height:34px;float:left;color:#161817;font-weight:bold;font-size:14px;text-align:center;letter-spacing:2px;border-bottom:1px solid #dbe4eb;" class="Top_tit">
		<div class="Top_tit" >	
			<h3></h3>
		</div> 
	</div>
	<div style="width:690px;height:460px;text-align:center;">
		<div style="float:left;width:170px;height:460px;border-right:1px solid #e1e1e1;" class="biankuang">
			<p style="font-size:14px;font-weight:bold;height:30px;background:#f3f3f3;border-bottom:1px solid #e1e1e1;color:#3b3b3b;line-height:30px;" >
				<fmt:message key="oper.field"/><!-- 选取字段 -->
			</p>
			<div style="width:160px;text-align:left;padding-left:10px;padding-top: 10px;overflow:scroll;height:420px;">
					<% 
							int i =0; 
							TableQuery tableQuery =new TableQuery();								 
								Collection queryC = (Collection)session.getAttribute("queryC"); 
								Iterator iii = queryC.iterator();		  
								if(!iii.hasNext()){} 
							    else{ 
								    tableQuery =null;	 
								    while(iii.hasNext()){ 
								    i++; 
								    tableQuery = (TableQuery)iii.next(); 
								    if("".equals(tableQuery.getField_Alias())){} 
									else{	 
										System.out.print(tableQuery.getDataDict());							     
						%> 						
					           <label id = "Table_Name<%=i %>" style="display:none;"><%=tableQuery.getTable_Name()%></label>  
					           <label id = "Field_Name<%=i %>" style="display:none;"><%=tableQuery.getField_Name()%></label>  
					           <p id = "Field_Alias<%=i %>" style="height:20px;padding-left:8px;line-height:20px;white-space:nowrap;" onclick="openziduan(<%=i %>)"  ><%=tableQuery.getField_Alias()%></p>
					           <label id = "DataType<%=i %>" style="display:none"><%=tableQuery.getDataType()%></label>
					           <input type="hidden" id="DataDict<%=i %>" value="<%=tableQuery.getDataDict()%>" />
					    <%
					    			}
						  		}						  	
						 	}
						%>
			<br></div>
		
		</div>
		<div style="float:left;width:170px;height:460px;border-right:1px solid #e1e1e1;" class="biankuang">
			<p style="font-size:14px;font-weight:bold;height:30px;background:#f3f3f3;border-bottom:1px solid #e1e1e1;color:#3b3b3b;line-height:30px;" class="biankuang">
				<fmt:message key="oper.condition"/><!-- 选取条件 -->
			</p>
			<div style="width:160px;text-align:left;padding-left:10px;height:420px;" >
				<p style="height:20px;"><input type="radio" id="oper" name="oper"  value="<fmt:message key="oper.greater" />"><fmt:message key="oper.greater" /></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.greaterequal"/>" ><fmt:message key="oper.greaterequal" /></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.equal" />" ><fmt:message key="oper.equal" /></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.unequal" />" ><fmt:message key="oper.unequal"/></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.lessequal" />" ><fmt:message key="oper.lessequal"/></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.smaller" />"><fmt:message key="oper.smaller"/></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.similar" />"><fmt:message key="oper.similar"/></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.nsimilar" />"><fmt:message key="oper.nsimilar" /></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.contain"/>" /><fmt:message key="oper.contain"/></p>
				<p style="height:20px;"><input type="radio" id="oper" name="oper" value="<fmt:message key="oper.ncontain" />"/><fmt:message key="oper.ncontain" /></p>
				
				<div style="background:#e9eaec;line-height:30px;height:30px;margin-top:20px;">				 	
				 		<img style="margin-top:7px;float:left;margin-left:30px;_margin-left:15px;" src="style/images/public/tubiao.jpg" />				 	
	               	    <span style="padding-left:6px;float:left;">
		               	    <a href="#" class="zi"  onclick="definedOper();">
		               	    	<fmt:message key='oper.operdefined'/>
		               	    </a>
	               	    </span>
               	</div>
               			
				<p style="height:20px;"><input type="text" style="display: none" id="operA" name="operA"></p>
				<p style="height:20px;" id="valfield1"></p>
				<!-- 忽略大写字母 -->
				<div style="line-height:24px;height:24px;margin-top:0px;">
               		<p>
               			<input type="checkbox" id="IgnoreUppercase">
               			<fmt:message key='oper.IgnoreUppercase' />
               		</p>
               	</div>	
				<p style="height:20px;margin-top: 5px;">
					<input type="radio" id="relation" name="relation" value="and" checked="checked" ><fmt:message key="oper.and"/>
					<input type="radio" name="relation"  value="or"><fmt:message key="oper.or" />
				</p>
				
				<div style="background:#e9eaec;line-height:30px;height:30px;margin-top:12px;">
	               	<img style="margin-top:7px;float:left;margin-left:30px;_margin-left:15px;" src="style/images/public/tubiao_5.jpg" />
	               	<span style="padding-left:6px;float:left;">
	               		<a href="#" class="zi" id="addParentNode"><fmt:message key='oper.peer' /></a>
	               	</span>
               	 </div>            	 
               	 <div style="background:#e9eaec;line-height:30px;height:30px;margin-top:8px;">
               	  	<img style="margin-top:7px;float:left;margin-left:30px;_margin-left:15px;" src="style/images/public/tubiao_6.jpg" />
               	   <span style="padding-left:6px;float:left;">
               	    	<a href="#" class="zi" id="addChildNode"><fmt:message key='oper.child' /></a>
               	   </span>
               	 </div>  
           </div>
		</div>
		<div id='valarea' style="float:left;width:160px;height:460px;border-right:1px solid #e1e1e1;" class="biankuang">
			<p style="font-size:14px;font-weight:bold;height:30px;background:#f3f3f3;border-bottom:1px solid #e1e1e1;color:#3b3b3b;line-height:30px;" class="biankuang">查询值</p>
			<div id='valfield2' style="width:150px;text-align:left;padding-left:10px;overflow:scroll;height:380px;" >
				
			</div>			
			<div class="xuanze_1" style="background:#e9eaec;line-height:30px;height:30px;margin-top:8px;width:150px;">			
				<img style="margin-top:7px;float:left;margin-left:60px;_margin-left:30px;" src="style/images/public/tubiao_3.jpg" />
               	<span style="padding-left:6px;float:left;"><a href="#" class="zi" onclick="hideArea();">隐藏</a></span>
            </div>
		</div>
		<div id="treeTab" style="float:left;width:200px;height:460px;border-right:1px solid #e1e1e1;text-align: center;">
			<p style="font-size:14px;font-weight:bold;height:30px;background:#f3f3f3;border-bottom:1px solid #e1e1e1;color:#3b3b3b;line-height:30px;" >
				<fmt:message key="oper.query"/> <!-- 查询条件 -->
			</p>
			<div class="dtree " id ="111" style="width:190px;text-align:left;padding-left:10px;overflow:scroll;height:380px;" >
				
			</div>
			
			<div align="center"eft" style="width:95%;height:30px;float:left;display:inline;margin:5px;background:#e9eaec;margin-top: 10px;text-align: center;">
            	<div style="width:79px;height:30px;float:left;font-size:13px;line-height:30px;padding-left:30px;_padding-left:25px;background:url(style/images/public/tubiao_2.jpg) no-repeat 15%;">
            		<a href="#" class="zi" onclick="Del();"><fmt:message key='oper.ndelete'/></a>
            	</div>
              	<div style="width:79px;height:30px;float:left;font-size:13px;line-height:30px;padding-left:30px;_padding-left:25px;background:url(style/images/public/tubiao_4.jpg) no-repeat 15%;">
              		<a href="#" class="zi" onclick="clearTree();"><fmt:message key='global.clear'/></a>
              	</div>
          </div>
         
		</div>
	</div>
	<div style="width:680px;height:30px;text-align:center;border:1px solid #e1e1e1;background:#f5f3f4;">
		<p style="padding-top:2px;padding-bottom: 10px;">
			<input type="button" id="search" onclick ="sendQuery();" class="buttons" value="<fmt:message key='global.ok'/>"/>			
			<input type="button" onclick="javascript:window.close();" class="buttons" value="<fmt:message key='global.close'/>"/>		
		</p>
	</div>
</div>

<input type="hidden" name="DataType" id="DataType" value="DataType">
<input type="hidden" name="Table_Name" id="Table_Name" value="Table_Name">
<input type="hidden"  name="Field_Name" id="Field_Name" value="Field_Name">
<input type="hidden"  name="Field_Alias" id="Field_Alias" value="Field_Alias">
<input type="hidden" id="zid" value="<%=zid%>" />
<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>'/>

<!-- 查询条件标识 -->
<input type="hidden" id="markMes" value="1">

<!-- 树节点 -->
<input type="hidden"  name="parentid" id="parentid" >
<input type="hidden"  name="childid" id="childid" >	
<input type="hidden" id="tablename" value="<%=tablename %>">
<input type="hidden" id="tableflag" value="<%=tableflag %>">

<!-- 面板头部信息 -->
<input type="hidden" id="topqueryinfo" value="<fmt:message key='global.query'/><fmt:message key='oper.title'/>"/>
<input type="hidden" id="topdeleteinfo" value="<fmt:message key='tariff.deleteb'/><fmt:message key='oper.title'/>"/>
<input type="hidden" id="topmodifyinfo" value="<fmt:message key='tariff.modifyb'/><fmt:message key='oper.title'/>"/>

<!-- 操作符 等于号 -->
<input type="hidden" id="operequalinfo" value="<fmt:message key='oper.equal' />"/>
<!-- js中多语言标签 -->
<input type="hidden" id="operwornnsel" value='<fmt:message key="oper.wornnsel"/>'/>
<input type="hidden" id="operwornnotdel" value='<fmt:message key="oper.wornnotdel"/>' />
<input type="hidden" id="opergreater" value="<fmt:message key="oper.greater" />"/>
<input type="hidden" id="opergreaterequal" value="<fmt:message key="oper.greaterequal"/>"/>
<input type="hidden" id="operequal" value="<fmt:message key="oper.equal"/>"/>
<input type="hidden" id="operunequal" value="<fmt:message key="oper.unequal"/>"/>
<input type="hidden" id="operlessequal" value="<fmt:message key="oper.lessequal"/>"/>
<input type="hidden" id="opersmaller" value="<fmt:message key="oper.smaller"/>"/>
<input type="hidden" id="opersimilar" value="<fmt:message key="oper.similar"/>"/>
<input type="hidden" id="opernsimilar" value="<fmt:message key="oper.nsimilar" />"/>
<input type="hidden" id="opercontain" value="<fmt:message key="oper.contain"/>"/>
<input type="hidden" id="operncontain" value="<fmt:message key="oper.ncontain"/>"/>
<input type="hidden" id="operwornval" value='<fmt:message key="oper.wornval"/>'/>
<input type="hidden" id="operSelField" value='<fmt:message key="oper.selField"/>'/>
<input type="hidden" id="operSelVal" value='<fmt:message key="oper.selVal"/>'/>
<input type="hidden" id="operworninteger" value='<fmt:message key="oper.worninteger"/>'/>
<input type="hidden" id="operworndouble" value='<fmt:message key="oper.worndouble"/>'/>
<input type="hidden" id="operwornoper" value='<fmt:message key="oper.wornoper"/>'/>

</body>
</html>
