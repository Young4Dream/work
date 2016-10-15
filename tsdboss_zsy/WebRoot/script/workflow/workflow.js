//获取用户权限
function getUserPower(iuserid,imenuid,igroupid)
{
	var allRi = fetchMultiPValue("JobFlow.getPower",6,'&userid='+iuserid+'&menuid='+imenuid+'&groupid='+igroupid);
	if(allRi.length == 0)
	{
		alert($("#Obtainpermissionfailure").val());
		return false;
	}
	if(allRi[0][0]=="all")
	{
		$("#RightGroup").val("10");
		$('#managepower').val('true');
		return true;
	}else{
		var rightgroup = 0;
		for(var i = 0;i<allRi.length;i++){	
			var rg = getCaption(allRi[i][0],'RightsGroup','');
			if(parseInt(rg,10)>rightgroup)
			{
				rightgroup = parseInt(rg,10);
			}
		}
		$("#RightGroup").val(rightgroup);
	}
}
//初始化字段
function initFields(tbname,languageType){
	var tbFields = fetchFieldAlias(tbname, languageType);
    var thisdata = loadData(tbname, languageType, 2, '');
    var column = thisdata.FieldName.join(',');
    var arr = column.split(',');
    for(var i = 0 ; i < arr.length;i++){
    	if(document.getElementById('s'+arr[i])!=null){
    		$('#s'+arr[i]).text(tbFields[arr[i]]);
    	}
    }
}
//初始化操作按钮
function initJobBtn(){
	var initDiv = '';
	initDiv += '<ul class="tabs-nav">';
	//接受工单
	initDiv +=		'<li><button id="receivejob" class="tsdbtn">'+$("#Receiveworkorder").val()+'</button></li>';
	initDiv +=		'<li><button id="submitjob" disabled="disabled" class="tsdbtn">'+$("#submitworkorder").val()+'</button></li>';
	initDiv +=		'<li><button id="printjob" disabled="disabled" class="tsdbtn">'+$("#printworkorder").val()+'</button></li>';
	initDiv +=		'<li><button id="readflow" class="tsdbtn">'+$("#readflows").val()+'</button></li>';
	//initDiv +=		'<li><button id="pausejob" disabled="disabled" class="tsdbtn">挂起工单</button></li>';
	//initDiv +=		'<li><button id="alivejob" disabled="disabled" class="tsdbtn">激活工单</button></li>';
	initDiv += '</ul>';
	$('#jobbtn').empty();
	$('#jobbtn').html(initDiv);
}
//初始化图标DIV
function initIconDiv(){
	var initDiv = '';
	var imgsrc = 'style/images/public/';
	var iconArr = new Array(['normal',$('#normaljob').text()],['cancel','撤销工单'],//['pause','挂起工单'],
							['d_waring',$('#dwaring').text()],['d_timeout',$('#dtimeout').text()],
							['t_timeout',$('#ttimeout').text()]);
	initDiv += $('#iconmemo').text()+'：';
	for(var i = 0 ; i < iconArr.length ; i++){
		initDiv += '<label style="margin-right:10px"><img src="'+imgsrc+iconArr[i][0]+'.gif" alt="'+iconArr[i][1]+'" />';
		initDiv += '<span style="margin-left: 5px">'+iconArr[i][1]+'</span></label>';
	}
	$('#icondivli,#icondiv').html(initDiv);	
}
//表格变色
function tabChangeColor(){
	$('.trclass').hover(
  		function(){$(this).addClass('highlight');},
  		function(){$(this).removeClass('highlight');}
 	);
 	$('.trclass').click(
		function() {
			if($(this).hasClass('selected')) {
				$(this).removeClass('selected');
	   		}else{
	   			$(this).addClass('selected');
	   		}
	  	}
	);
}
//点击业务类型变色
function bgColorChange(ids)
{
	$("#menu li a").css({"color":"#4D4D4D","background":"url(style/images/public/flat.gif) no-repeat right top"});
	$("#jobcss" + ids).css({"color":"#FF9834","background":"url(style/images/public/curled.png) no-repeat right top"});
}
function getdhnum(name)
{
    var thename = document.getElementsByName(name);
    var num="";
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            num+= $("#jobchknum2"+[i]).html();
            num+=",";
        }
    }
    return num;
}
function getTheChecked(name)
{
    var thename = document.getElementsByName(name);
    var thevalue = '';
    for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            thevalue += thename[i].value + ',';
        }
    }
    if(thevalue!=''){
    	thevalue = thevalue.substring(0, thevalue.lastIndexOf(','));
    }
    return thevalue;
}