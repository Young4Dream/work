<br>&gt;<%----------------------------------------
	name: DeviceMaster.jsp
	author: wangli
	version: 1.0 
	description: 号线设备管理-主表新增编辑页面 
	Date: 2011-11-01
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";		
%>

<%@page import="java.io.File"%>
<%	
	String devicepath = basePath + "style/icon/device/";
	String rootPath = request.getRealPath("style/images/public/");//大图标所在文件夹
	
	File thepath = new File(rootPath);
	int x = 0;
	if(thepath.listFiles().length>0){
		for(int i = 0 ; i < thepath.listFiles().length;i++){
			if(thepath.listFiles()[i].toString().endsWith(".jpg")){
				x++;
			}
		}
	}
%>	
<head>
	<script type="text/javascript">
		//保存air_Device_Master表.flag=1:新增;flag=2:编辑;
		function saveMaster(flag){
			//if (NullCheck("#devno_m", "设备编号")) {return};
			if (NullCheck("#devname_m", "设备名称")) {return};
			if (NullCheck("#levelcount", "层次数目")) {return};
			if (NullCheck("#checkroutetype", "号线业务")) {return};
			if (NullCheck("#linemode", "配线方式")) {return};
			//if (idRepeat("#devno_m", 1)) {return};
			if (!confirm("您确定要进行保存操作吗？")){
				return;
			}
			var v_devno = $("#devno_m").val();
        	var v_devname = tsd.encodeURIComponent($("#devname_m").val());
        	var v_levelcount = tsd.encodeURIComponent($("#levelcount").val());       	
        	var v_linemode = tsd.encodeURIComponent($("#linemode").val());
        	var v_devicon = tsd.encodeURIComponent($("#devicon_m").val());
        	var v_memo = tsd.encodeURIComponent($("#memo_m").val()); 
        	
        	//获取业务类型复选框的值
        	//var v_routetype = tsd.encodeURIComponent($("#checkroutetype").val());
        	var v_routetype = '';
        	var v_routetype='';
			var mulselectoper = '~';
			$("[name='routetype'][checked]").each(function(){
				v_routetype +=$(this).val() + mulselectoper;				
			}) ; 
			var len = v_routetype.lastIndexOf(mulselectoper);
			if(len>0){ 
				v_routetype = v_routetype.substr(0,len);
			}			
        	v_routetype = tsd.encodeURIComponent(v_routetype);
        	
        	var pubParam = getPubProcParam(flag);   
        	var param=pubParam+"&devno="+v_devno+"&devname="+v_devname+"&levelcount="+v_levelcount+"&routetype="+v_routetype
        	  +"&linemode="+v_linemode+"&devicon="+v_devicon+"&memo="+v_memo;     	

        	var res = fetchMultiPValue("air_device_manage",6,param);        	      
        	if(res[0][0]=="SUCCEED"){
        		//保存新增的话，提示是否继续新增
				if (flag == 1)
				{
					//新增成功后，在编号输入框中显示刚刚插入的设备编号
					$("#devno_m").val(res[0][1]);
					if (confirm("保存成功！\r\n\n点击“确定”按钮继续新增设备，点击“取消”按钮返回主页面。")){						
						//树中添加新节点
						insertRefresh($("#devno_m").val(), $("#devname_m").val());
						//清空输入框，以开始新的录入
						reset_M();
						return;
					}					
					//关闭本页面，并刷新树(增加相应节点)和表格(新增设备的表格)
					insertRefresh($("#devno_m").val(), $("#devname_m").val());        	                
		        	//关闭本页面
		        	setTimeout($.unblockUI,15);					
				}
				else{
					alert("保存成功！\r\n\n点击“确定”按钮返回主页面。");	
					updateRefresh($("#devno_m").val(), $("#devname_m").val());
				}
        	}
        	else{
        		alert("保存失败！请仔细检查填写的数据是否正确。");
        	} 											
		}
		//重置函数
		function reset_M(){						
			$("#divMaster :text").val("");
			$("#divMaster select").val("");
			//清空多选下拉框
			clearMultiSelect();
			$("#devname_m").focus();		
		}
		//显示编辑记录的字段信息
		function showInfo_M(grid){
			if( '#devMaster1' == grid){
				//devno_MA	devname_MA	levelcount_MA		routetype_MA	routetypeVal_MA	linemode_MA	memo_MA	devicon_MA
				$("#devno_m").val( $("#devno_MA").val() );
				$("#devname_m").val( $("#devname_MA").val() );
				$("#levelcount").val( $("#levelcount_MA").val() );//记录更新之前的端口名称
				
				//清空多选下拉框
				clearMultiSelect();
			
				var routetypeStr = $("#routetypeVal_MA").val() ;
				var arr = routetypeStr.split('~');
				for(var j=0;j<arr.length;j++){
					//将复选框中应被选中的选项设置为选中
					$("[name='routetype']").each(function(){
						if($(this).val()==arr[j]){
							$(this).attr("checked","checked");
							if(j==arr.length-1){
								$(this).click();
								$(this).attr("checked","checked");
							}			
						}
					}) ;
				}
								
				$("#linemode").val( $("#linemode_MA").val() );
				$("#devicon_m").val( $("#devicon_MA").val() );
				$("#memo_m").val( $("#memo_MA").val() );
			}
			/*
			var rowid=$(grid).getGridParam("selrow");			
			var devno=$(grid).getCell(rowid,'devno');			
			if (devno=='' || devno==null) {
			  return;
			 
			}
			$("#devno_m").val(devno);
			$("#devname_m").val($(grid).getCell(rowid,'devname'));
			$("#levelcount").val($(grid).getCell(rowid,'levelcount'));
			//清空多选下拉框
			clearMultiSelect();
			//多选框复制
			//$("#checkroutetype").val($(grid).getCell(rowid,'routetype'));
			var routetypeStr = $(grid).getCell(rowid,'routetypeVal');
			var arr = routetypeStr.split('~');
			for(var j=0;j<arr.length;j++){
				//将复选框中应被选中的选项设置为选中
				$("[name='routetype']").each(function(){
					if($(this).val()==arr[j]){
						$(this).attr("checked","checked");
						if(j==arr.length-1){
							$(this).click();
							$(this).attr("checked","checked");
						}			
					}
				}) ;
			}
							
			$("#linemode").val($(grid).getCell(rowid,'linemode'));
			$("#devicon_m").val($(grid).getCell(rowid,'devicon'));
			$("#memo_m").val($(grid).getCell(rowid,'memo'));
			*/
		}
		
		/**
		 * 清空多选下拉框
		 * @param 
		 * @return  
		 */
		function clearMultiSelect(){
				$(".multiSelectOptions :checkbox:checked").attr("checked",false)
					.parent().removeClass("checked");
				$(".multiSelectOptions :disabled").removeAttr("disabled");
				$(".multiSelect").attr("trueval","");
		}
		/********************************
		获取操作类型
		********************************/
        function getPubProcParam(flag){
        	var optype;
       	 	if (flag == 1)
			{
				optype = 'insert';
			}
			else{
				optype = 'update';
			};
			var optag = 1;
        	return "&optype="+optype+"&optag="+optag;
        }		
        //新增后返回主页面的刷新
        function insertRefresh(id, name){        	
        	//树中添加新节点,并选中该节点        	     
        	var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){
        		var newNode = {"id":id,"name":name};   	
        		newNode = zTreeObj.addNodes(nodes[0], newNode);
        		//zTreeObj.selectNode(newNode, false);
        	}        	                   
        }
        //修改后返回主页面的刷新
        function updateRefresh(id, name){
        	//1.修改树节点的name
        	var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){
        		nodes[0].name=name;   	
        		zTreeObj.updateNode(nodes[0]);        		
        	}        	
        	//2.修改对应表格的记录
        	queryDevice_Master(id, 1, "#devMaster1");
        	//3.关闭本页面
        	setTimeout($.unblockUI,15);
        }
        //填充下拉框内容
		function getDict(){
		//2012-9-4 yhy start 修改获取数据方式不从内存直接获取
		/*
			$.ajax({
				url:"phone_querydate?func=query",
				async:true,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{					
				    var routetype = xml.substring(xml.indexOf("<routetype=")+11,xml.indexOf("routetype/>"));
				    var linemode = xml.substring(xml.indexOf("<linemode=")+10,xml.indexOf("linemode/>"));				    
				    var state = xml.substring(xml.indexOf("<objstate=")+10,xml.indexOf("objstate/>"));
				    //号线业务				    
					$("#routetype").html(routetype);
					//$("#routetype").multiSelect({ oneOrMoreSelected: '*'},'','checkRouteType',',');
					$("#routetype").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');
					//配线方式
					$("#linemode").html(linemode);
					//端口状态
					$("#state").html(state);
					$("#state_b").html(state);
				}		
			});		
		*/	
			//号线业务
			var s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetRouteType',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#routetype").html(s);
			$("#routetype").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');
			
			//配线方式
			s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetLineMode',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#linemode").html(s);
			
			//端口状态
			s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetObjState',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#state").html(s);
			$("#state_b").html(s);
		//2012-9-4 yhy end
			//模块局	
			s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetMkj',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][0]+">"+res[i][0]+"</option>";
				}
				$("#mokuaiju").html(s);
				$("#mokuaiju_b").html(s);
			};
			
			
			//业务区域
			s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetMkjByYwarea',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
				}
				$("#ywarea").html(s);
				$("#ywarea_b").html(s);
			};
			
			//端口业务类型，同一设备端口分摊不同业务
			var s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetRouteType',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#portype").html(s);
			$("#portype_b").html(s);
		}	
		
		/***************************
        * 号线图标选择面板实现
        ****************************/
        /***************************
        * 弹出图标可选择图片面板
        * 参数 ids： 展示图标可选择图片面板外层div 的id
        * 参数 idsshow：展示图标可选择图片面板id
        * 参数 idsval：页面显示备选图片路径文本框id
        ****************************/
		function disListIcon(ids,idsshow,idsval)
		{
		    var disinfos = '';
		    var disname = 'disradio'+idsval;
		    var disradio ;
		    var info;
		    var thestr ;
		    var count = $("#devid_Icon_Count").val();
		    var devicepath = $("#devid_Icon_Path").val();
		    for (var i = 1 ; i < <%=x %>; i++)
		    {
		        disradio = '<input type="radio" onclick="disCheckIcon('+ "'" + idsval + "','"+idsshow+"'" + ')" ';
		       	disradio += 'value="style/icon/device/' + i + '.jpg" style="margin-left:5px;float:left;" ';
		       	disradio += 'name="'+disname+'" id="icon' + i + '" />';
        		info = '<label><img style="margin-left: 2px;float:left;" width="138px" height="128px" src="<%=devicepath %>' + i + '.jpg"/></label>';
        		thestr = '';
		        if (i % 2 == 0) {
		            thestr = '<br/>';
		        }
		        disinfos += disradio + info + thestr;
		    }
		    $('#'+ids).html(disinfos);
		    $('#'+idsshow).show();
		    var disflag = $('#operflag').val();
		    
			if(disflag==1){
				var disval = $('#'+idsval).val();
				forChecked(disname,disval);
			}
		}
		/***************************
        * 将选中图标路径显示在文档框中
        * 参数 ids： 页面显示备选图片路径文本框id
        * 参数 idsshow：展示图标可选择图片面板id
        *
        ****************************/
		function disCheckIcon(idsval,idsshow)
		{
			var disname = 'disradio'+idsval;
		    var tagname = document.getElementsByName(disname);
		    for (var i = 0 ; i < tagname.length; i++) {
		        if (tagname[i].checked == true) {
		            $('#'+idsval).val(tagname[i].value);
		            break;
		        }
		    }
		     $('#'+idsshow).hide();
		}
		/***************************
        * 打开展示可选择图片面板时显示当前设备图片
        * 参数 ids： 页面显示备选图片路径文本框id
        * 参数 idsshow：展示图标可选择图片面板id
        *
        ****************************/
		function forChecked(ids,disval){
			var tagname = document.getElementsByName(ids);
		    for (var i = 0 ; i < tagname.length; i++) {
		    	if( tagname[i].value == disval){
		    		tagname[i].checked = true;
		    		break;
		    	}
		    }
		}	
	</script>
	<style type="text/css">
		.midd_div{
			width:390px; 
			margin-top:10px;
		}
		.midd_span{
			width:60px; 
			text-align:right;
			display:block;
			float:left;
		}
		.midd_input{
			height:16px; 
			margin-top:-2px;
			margin-left:11px;
			float:left;
			
			
		}
		.multiple{
			width:300px;
		}
		#checkroutetype{
			width:294px;
			height:16px; 
		}
		.yhy_spanred{
			color: red;
			display: block;
			float: right;
			clear: both;
		}
	</style>
</head>
	<div class="neirong" id="divMaster" style="width:470px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Master_Title">设备信息</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;">
			<div id="devname_m_D" class="midd_div" >
				<span class="midd_span" >设备名称:</span>
				<input type="text" id="devname_m" class="midd_input" style="width:300px;"/>
				<span class="yhy_spanred">*</span>
			</div>
			<div id="levelcount_D" class="midd_div">
				<span class="midd_span">层次数目:</span>
				<input type="text" id="levelcount" class="midd_input" style="width:60px;" 
				onkeyup="value=value.replace(/[^\d]/g,'')" maxlength="2"/>
				<span class="yhy_spanred">*</span>
				<div style="color: red;margin-left: 2px;width: auto;" >
					<span style="display:block;text-align: left;">即端口所在层数，“号线设备”为第一层，从0开始计数。</span>
				</div>
			</div>
			<div id="routetype_D" class="midd_div" >
				<span class="midd_span">号线业务:</span>
				<select id="routetype" name="routetype" multiple="multiple" style="width:302px;margin-top:-4px;"></select>
				<span class="yhy_spanred">*</span>
			</div>
			<div id="linemode_D" class="midd_div">
				<span class="midd_span">配线方式:</span>
				<select id="linemode" style="width:302px; height:25px;" class="midd_input"></select>
				<span class="yhy_spanred">*</span>
			</div>		
			<div id="memo_m_D" class="midd_div">
				<span class="midd_span">备注:</span>
				<input type="text" id="memo_m" style="width:300px;" class="midd_input"/>
			</div>
			<div id="devicon_m_D" class="midd_div">
				<span class="midd_span" >图标:</span>
				<input type="text" id="devicon_m" style="width:300px;"  class="midd_input" 
				onfocus="disListIcon('twoiconlist_m','trhide_m','devicon_m')" />
			</div>
			<!-- 展示图标可选择图片面板 -->
			<div id='trhide_m' class="midd_div">
				<div id="twoiconlist_m" style="height: 100px;overflow-y: auto;overflow-x: hidden;">
				</div>
			</div>
			
		</div>		
		<div class="midd_butt" style="height:38px;">  
			<button onclick="saveMaster($('#masterFlag').val());" class="tsdbutton" 
				style="margin-left: 20px;">
				保存
			</button>
			<button onclick="javascript:setTimeout($.unblockUI,15);" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>
		</div>
	</div>

    <input type="hidden" id="masterFlag"/>
    <input type="hidden" id="devno_m" style="width:300px;background:silver;ime-mode: disabled;display:none;" readonly="true";/>  <br /><br />
