<br>&gt;<%----------------------------------------
	name: DeviceDetail.jsp
	author: wangli
	version: 1.0 
	description: 号线设备管理-明细表新增编辑页面 
	Date: 2011-11-03
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
		//保存air_Device_Detail表.flag=1:新增;flag=2:编辑;
		function saveDetail(flag){
			//if (NullCheck("#devno_d", "设备编号")) {return};
			if (NullCheck("#devname_d", "设备名称")) {return};
			var devid =$("#devid_level").val();
			var levelFlag =getThelevelDetail(devid);					
			if(levelFlag){	
				if (NullCheck("#portype", "业务类型")) {return};
			}else{
				if (NullCheck("#ywarea", "业务区域")) {return};
			}
			
			//if (idRepeat("#devno_d", 1)) {return};
			if (!confirm("您确定要进行保存操作吗？")){
				return;
			}
			
			//2012-9-11 yhy start
			//ip格式验证
			var ipInfo = $("#ip").val();
			if(trim(ipInfo)!=''){
				var re = /^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$/g;			
				var result = ipInfo.match(re);
				if (null==result || 0==result.length) {
					alert("IP地址有问题，请重新输入");				
					$("#ip").focus();
					return false;
				}
			}	
			//2012-11-6 cyl start 按照不同的方式设置不同的设备地址
			if(addrChoice=='Y'){
				var v_addr= tsd.encodeURIComponent($("#display_add").val());
			}else{
				var v_addr = tsd.encodeURIComponent($("#addr").val());
			}
			
			
			//2012-11-6 cyl end
			//2012-9-11 yhy end	
			var v_devno = $("#devno_d").val();
        	var v_devname = tsd.encodeURIComponent($("#devname_d").val());
        	var v_devnameold = tsd.encodeURIComponent($("#devnameOld_d").val());
        	var v_dh = tsd.encodeURIComponent($("#dh").val());
        	var v_ywarea = tsd.encodeURIComponent($("#ywarea").val());
        	var v_portype = tsd.encodeURIComponent($("#portype").val());          	
        	var v_mokuaiju = tsd.encodeURIComponent($("#mokuaiju").val());
        	var v_devicon = tsd.encodeURIComponent($("#devicon_d").val());
        	var v_memo = tsd.encodeURIComponent($("#memo_d").val());         	
        	var v_pdevno = tsd.encodeURIComponent($("#pdevno").val());
        	var v_state = tsd.encodeURIComponent($("#state").val());
        	var v_ip = tsd.encodeURIComponent($("#ip").val());
        	var v_vlan = tsd.encodeURIComponent($("#vlan").val());
        	var pubParam = getPubProcParam_d(flag);   
        	var param=	pubParam+"&devno=" + v_devno  
        				+ "&portNameOld=" + v_devnameold 
        				+ "&devname="+v_devname +"&dh=" +v_dh
        				+ "&ywarea="+v_ywarea +"&portype="+v_portype
        				+ "&addr="	+v_addr		+"&mokuaiju=" +v_mokuaiju
        				+ "&devicon="+v_devicon	+"&memo=" +v_memo
        				+ "&state="	+v_state	+"&pdevno="	+v_pdevno
        				+ "&ip="	+v_ip		+"&vlan="	+v_vlan ;
        	//如果是新增，则传入父设备编码这个参数parentno       	
			if (flag==1){				
				var nodes=zTreeObj.getSelectedNodes();
	        	if (nodes.length>0){
	        		param+="&parentno="+nodes[0].id;	        		        			        		
	        	}
	        	else{
	        		alert("保存失败！请确认是否正确选中父设备！");
	        		return;
	        	}
			}
        	var res = fetchMultiPValue("air_device_manage",6,param);        	      
        	if(res[0][0]=="SUCCEED"){        	     
        		//保存新增的话，提示是否继续新增
				if (flag == 1)
				{
					//新增成功后，在编号输入框中显示刚刚插入的设备编号
					$("#devno_d").val(res[0][1]);
					if (confirm("保存成功！\r\n\n点击“确定”按钮继续新增设备，点击“取消”按钮返回主页面。")){
						//树中添加新节点
						insertRefresh_d($("#devno_d").val(), $("#devname_d").val());
						//清空输入框，以开始新的录入
						reset_D();
						return;
					}					
					//关闭本页面，并刷新树(增加相应节点)和表格(新增设备的表格)
					insertRefresh_d($("#devno_d").val(), $("#devname_d").val());
		        	//关闭本页面
		        	setTimeout($.unblockUI,15);					
				}				
				else{
					alert("保存成功！\r\n\n点击“确定”按钮返回主页面。");	
					updateRefresh_d($("#devno_d").val(), $("#devname_d").val());
				}
        	}
        	else if(res[0][0]=="FAILED"){ 
        		alert(res[0][1]);
        	}
        	else{
        		alert("保存失败！请仔细检查填写的数据是否正确。\r\n\n错误消息："+res[0][1]);
        	} 										
		}
		//重置函数
		//清空面板信息，将设备端口状态置为空闲，模块局设置为上级设备模块局
		function reset_D(){						
			$("#divDetail :text").val("");
			$("#divDetail select").val("");
			//状态设置为 空闲
			$("#state").val("free");
			//模块局设置为上级设备模块局
			var devid =$("#devid_level").val();	
			var mokuaiju= getTheMKJ(devid);
			$("#mokuaiju").val(mokuaiju);
			
			//2012-11-05 cyl start			
			if(addrChoice=='Y'){
			//设置设备地址录入为下拉列表样式				
				$("#addr_D_opt").show();
				$("#addr_D_opt").replaceAll("#addr_D");					
				//设置后三个可选框的不可用性
				$("#addr_ld,#addr_dy,#addr_mp").attr("disabled","disabled");
				$("#addr_ld,#addr_dy,#addr_mp").html("<option value='' selected='true'>--请选择--</option>");			
				//初始化小区号选择下拉列表	
				getxq();				
			}			
			$("#devname_d").focus();				
		}
		function getxq(){			
			var s="<option value='' selected='true'>--请选择--</option>";
			var res=fetchMultiArrayValue('dbqql_route.GetAddrXQ',6,'','route');			
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){					
						s+="<option value="+res[i][0]+">"+res[i][1]+"</option>";					
				}
			}			
			$("#addr_xq").html(s);
			return;
		}		
		function getld(){
			var isnull=$("#addr_xq :selected").val();		
			if(isnull==""||isnull.lenght<=0){
				$("#addr_ld,#addr_dy,#addr_mp").html("<option value='' selected='true'>--请选择--</option>");
				$("#addr_ld,#addr_dy,#addr_mp").attr("disabled","disabled");	
				return;		
			}
			$("#addr_ld").removeAttr("disabled");			
			$("#addr_dy,#addr_mp").attr("disabled","disabled");						
			$("#addr_dy,#addr_mp").html("<option value='' selected='true'>--请选择--</option>");	
									
			var param=$("#addr_xq :selected").val();					
			var s="<option value='' selected='true'>--请选择--</option>";
			var res=fetchMultiArrayValue('dbqql_route.GetAddrLD',6,'&addrcode='+param,'route');			
			if (res != undefined && res!="" && res.length>0){			
					for(var i=0;i<res.length;i++){						
						s+="<option value="+res[i][0]+">"+res[i][1]+"</option>";						
					}
			};
			$("#addr_ld").html(s);										
			return;					
		}
		function getdy(){
			var isnull=$("#addr_ld :selected").val();		
			if(isnull==""||isnull.lenght<=0){
				$("#addr_dy,#addr_mp").html("<option value='' selected='true'>--请选择--</option>");
				$("#addr_dy,#addr_mp").attr("disabled","disabled");			
				return;		
			}			
			$("#addr_dy").removeAttr("disabled");					
			$("#addr_mp").attr("disabled","disabled");
			$("#addr_mp").html("<option value='' selected='true'>--请选择--</option>");		
				
			var param=$("#addr_ld :selected").val();			
			var s="<option value='' selected='true'>--请选择--</option>";
			var res=fetchMultiArrayValue('dbqql_route.GetAddrDY',6,'&addrcode='+param,'route');					
			if (res != undefined && res!="" && res.length>0){			
					for(var i=0;i<res.length;i++){						
						s+="<option value="+res[i][0]+">"+res[i][1]+"</option>";						
					}
			};
			$("#addr_dy").html(s);							
			return;	
		}
		function getmp(){
			var isnull=$("#addr_dy :selected").val();		
			if(isnull==""||isnull.lenght<=0){
				$("#addr_mp").html("<option value='' selected='true'>--请选择--</option>");
				$("#addr_mp").attr("disabled","disabled");			
				return;		
			}			
			$("#addr_mp").removeAttr("disabled");			
			
			var param=$("#addr_dy :selected").val();						
			var s="<option value='' selected='true'>--请选择--</option>";
			var res=fetchMultiArrayValue('dbqql_route.GetAddrMP',6,'&addrcode='+param,'route');					
			if (res != undefined && res!="" && res.length>0){			
					for(var i=0;i<res.length;i++){						
						s+="<option value="+res[i][0]+">"+res[i][1]+"</option>";						
					}
			};
			$("#addr_mp").html(s);							
			return;				
		}		
		//2012-11-05 cyl end
		
		//显示编辑记录的字段信息
		//grid
		function showInfo_D(grid){
			var flag;
			if(grid == '#devMaster2'){
			//devno_MB devname_MB state_MB dh_MB addr_MB mokuaiju_MB devicon_MB pdevno_MB
				$("#devno_d").val( $("#devno_MB").val() );
				$("#devname_d").val( $("#devname_MB").val() );
				$("#devnameOld_d").val( $("#devname_MB").val() );//记录更新之前的端口名称
				
				
				var v_devno = $("#devno_d").val();
				
				//右键菜单的设备地址编辑
				flag=1;
				getEditAddr(v_devno,flag);
				
				$("#dh").val( $("#dh_MB").val() );						
				$("#mokuaiju").val( $("#mokuaiju_MB").val() );
				$("#ywarea option[text='"+$("#ywarea_MB").val()+"']").attr("selected", true);		
				$("#devicon_d").val( $("#devicon_MB").val() );
				$("#memo_d").val( $("#memo_MB").val() );
				$("#state").val( $("#state_MB").val() );
				$("#pdevno").val( $("#pdevno_MB").val() );
				$("#ip").val( $("#ip_MB").val() );
				$("#vlan").val( $("#vlan_MB").val() );
			}
			else{
				var rowid=$(grid).getGridParam("selrow");			
				var devno=$(grid).getCell(rowid,'devno');			
				if (devno=='' || devno==null) {
					return;
				}
				$("#devno_d").val(devno);
				$("#devname_d").val($(grid).getCell(rowid,'devname'));
				$("#devnameOld_d").val($(grid).getCell(rowid,'devname'));//记录更新之前的端口名称
				
				$("#dh").val($(grid).getCell(rowid,'dh'));
					
				//grid的设备地址编辑			
				flag=2;
				getEditAddr(devno,flag);
				
				var ywarea=$(grid).getCell(rowid,'areaname');
				if(ywarea!="undefined" && ywarea!=""){
					$("#ywarea option[text='"+ywarea+"']").attr("selected", true);
				}else{
					$("#ywarea").val('');
				}
				
				
				var portype=$(grid).getCell(rowid,'portype');
				if(portype!="undefined" && portype!=""){
					$("#portype option[text='"+portype+"']").attr("selected", true);
				}else{
					$("#portype").val('');
				}
				
				
				$("#addr").val($(grid).getCell(rowid,'addr'));			
				$("#mokuaiju").val($(grid).getCell(rowid,'mokuaiju'));		
				$("#devicon_d").val($(grid).getCell(rowid,'devicon'));
				$("#memo_d").val($(grid).getCell(rowid,'memo'));
				$("#state").val($(grid).getCell(rowid,'state'));
				$("#pdevno").val($(grid).getCell(rowid,'pdevno'));	
				$("#ip").val($(grid).getCell(rowid,'ip'));
				$("#vlan").val($(grid).getCell(rowid,'vlan'));
			}							
		}
		//2012-11-7 cyl start
		function save_Device_Detail(){
						var addr1="";
						var addr2="";
						var addr3="";
						var addr4="";
						if(!$("#addr_xq").val()==""){
							addr1=$("#addr_xq :selected").text();							
						}
						if(!$("#addr_ld").val()==""){
							addr2=$("#addr_ld :selected").text();							
						}
						if(!$("#addr_dy").val()==""){
							addr3=$("#addr_dy :selected").text();							
						}
						if(!$("#addr_mp").val()==""){
							addr4=$("#addr_mp :selected").text();							
						}
						var v_addr=addr1+addr2+addr3+addr4;
						$("#display_add").val(v_addr);
		}		
		function getEditAddr(devno,flag){
			if(addrChoice=='Y'){
					$("#addr_D_opt").show();
					$("#addr_D_opt").replaceAll("#addr_D");
					
					$("#addr_ld,#addr_dy,#addr_mp").attr("disabled","disabled");
					$("#addr_ld,#addr_dy,#addr_mp").html("<option value='' selected='true'>--请选择--</option>");	
					
					var param="&devno="+tsd.encodeURIComponent(devno);
					var addr=fetchSingleValue("dbqql_route.GetAddr",6,param,'route');
					$("#display_add").val(addr);										
					getxq();						
					return;					
				}else{
					if(flag==1){
						$("#addr").val( $("#addr_MB").val() );	
					}else{
						return;
					}					
				}				
		}
		//2012-11-7 cyl end
		/********************************
		获取操作类型
		********************************/	
        function getPubProcParam_d(flag){
        	var optype;
       	 	if (flag == 1)
			{
				optype = 'insert';
			}
			else{
				optype = 'update';
			};
			var optag = 2;
        	return "&optype="+optype+"&optag="+optag;
        }		
        //新增后返回主页面的刷新
        function insertRefresh_d(id, name){        	
        	//树中添加新节点 是否添加 todo       	     
        	var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){
        		//如果父节点是open状态，则将新增的明细记录添加为此父节点的子节点
        		if (nodes[0].isParent){
	        		var newNode = {"id":id,"name":name};
	        		newNode = zTreeObj.addNodes(nodes[0], newNode);
        		}
        		//刷新明细表格
        		queryObj(nodes[0].id);    		
        	}        	                           	                
        }
        //修改后返回主页面的刷新
        function updateRefresh_d(id, name){        	
        	//1.刷新明细表格的记录(即刷新选中节点的明细记录)    
        	var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){
        		//如果更新的是明细表格记录
        		if ($("#ctlFlag").val()=="grid"){        	    	
	        		queryObj(nodes[0].id);
	        		if (nodes[0].open){
	        			//返回更新记录对应的树节点
		        		var node = zTreeObj.getNodeByParam("id", id, nodes[0]);
		        		node.name=name;   	
		        		zTreeObj.updateNode(node);
	        		} 
        		}
        		else{//如果更新的是树节点
        			//1.刷新主表格
        			queryDevice_Master(nodes[0].id, 2, "#devMaster2");
        			//2.更新树节点
        			nodes[0].name=name;   	
		        	zTreeObj.updateNode(nodes[0]);
        		}
        	}
        	//2.关闭本页面
        	setTimeout($.unblockUI,15);
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
			float:left;
		}
		.yhy_spanred{
			color: red;
			display: block;
			float: right;
		}
	</style>
</head>
	<div class="neirong" id="divDetail" style="width:500px;display: none;margin-top:-35px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Detail_Title">设备信息</span>
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
		<div class="midd" style="background-color:#FFFFFF;height:415px;"> <br />
			<div id="devname_d_D" class="midd_div" >
				<span class="midd_span" style="float:left;display:block;" >设备名称:</span>
				<span  style="width:300px; margin-left:6px;display:block;float:left;"><input type="text" id="devname_d" style="width:300px;"/></span>
				<span class="yhy_spanred">*</span>
				<span id="nodeExplain" style="color: red;clear:both;display:block;margin-left:60px;width:300px;text-align: left;">
					在同一个设备下设备端口的名称不能重名。
					设备端口名称命名：建议端口名称前面加前缀用来标识该设备路径信息。
				</span>
				<input type="hidden" id="devnameOld_d"/>
			</div>
			<div id="dh_D" class="midd_div">
				<span class="midd_span">绑定电话:</span>
				<input type="text" id="dh" style="width:300px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
			</div>
			
			<div id="addr_D" class="midd_div" style="border:1px;">
				<span class="midd_span">设备地址:</span>
				<input type="text" id="addr" style="width:302px;"/>							
			</div>
			<!-- 2012-11-09 cyl 下拉列表式操作设备地址 start -->
			<div id='addr_D_opt' class='midd_div' style='border:1px;' style="display: none">
				<span class='midd_span'>设备地址:</span>
				<input type="text" id='display_add' disabled=‘disabled’ style="width:302px;"/>
				<table style="width:325px;margin-left:69px;">				
					<tr>
						<td>&nbsp;小区号:<select id='addr_xq' style='width:101px;' onchange='getld();'></select></td>
						<td>&nbsp;楼栋号:<select id='addr_ld' style='width:101px;' onchange='getdy();'></select></td>
					</tr>
					<tr>
						<td>&nbsp;单元号:<select id='addr_dy' style='width:101px;' onchange='getmp();'></select></td>
						<td>&nbsp;门牌号:<select id='addr_mp' style='width:101px;'></select></td>
					</tr>
					<tr>
						<td></td>
						<td>							
							<button style='width:60px;height:22px;line-height:18px;float:right;margin-right:20px;font-size:12px;' onclick='save_Device_Detail();'>确认地址</button>
						</td>
					</tr>
				</table>
			</div>
			<!--2012-11-09 cyl 下拉列表式编辑设备地址 end -->				
			<div id="state_D" class="midd_div">
				<span class="midd_span">状态:</span>
				<select id="state" style="width:302px;"></select>
			</div>
			<div id="mokuaiju_D" class="midd_div">
				<span class="midd_span">所属区域:</span>
				<select id="mokuaiju"  style="width:302px;"></select>
			</div>
			<div id="ywarea_D" class="midd_div" style="border:1px;display: none;">
				<span class="midd_span">业务区域:</span>
				<select id="ywarea"  style="width:302px;"></select>							
			</div>
			<div id="portype_D" class="midd_div" style="border:1px;">
				<span class="midd_span">业务类型:</span>
				<select id="portype"  style="width:302px;"></select>							
			</div>
			<div id="pdevno_D" class="midd_div" style="display: none" >
				<span class="midd_span">上级设备:</span>
				<input type="text" id="pdevno" style="width:300px;"/> 
			</div>
			<div id="ip_D" class="midd_div">
				<span class="midd_span">IP地址:</span>
				<input type="text" id="ip" style="width:300px;"/> 
			</div>
			<div id="vlan_D" class="midd_div">
				<span class="midd_span">VLAN</span>
				<input type="text" id="vlan" style="width:300px;"/> 
			</div>
			<div id="memo_d_D" class="midd_div">
				<span class="midd_span">备注:</span>
				<input type="text" id="memo_d" style="width:300px;" />
			</div>
			<div id="devicon_d_D" class="midd_div">
				<span class="midd_span" >图标:</span>
				<input type="text" id="devicon_d" style="width:300px;"  
				onfocus="disListIcon('twoiconlist','trhide2','devicon_d')" />
			</div>
			<!-- 展示图标可选择图片面板 -->
			<div id='trhide2' class="midd_div">
				<div id="twoiconlist" style="height: 100px;overflow-y: auto;overflow-x: hidden;">
				</div>
			</div>					
		</div>		
		<div class="midd_butt" style="height:38px;">  
			<button onclick="saveDetail($('#detailFlag').val());" class="tsdbutton" 
				style="margin-left: 20px;">
				保存
			</button>
			<button onclick="javascript:setTimeout($.unblockUI,15);" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>			
		</div>
	</div>

    <input type="hidden" id="detailFlag"/>
    <input type="hidden" id="devno_d" readonly="true";/>
    <input type="hidden" id="ctlFlag"/>
