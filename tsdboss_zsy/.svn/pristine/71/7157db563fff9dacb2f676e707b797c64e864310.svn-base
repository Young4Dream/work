function DisableCtrl()
{
	return false;
}

$(function(){
		//响应回车事件
		document.onkeydown = function(event){
			e = event ? event : (window.event ? window.event : null);
			e.keyCode == 13 ? fnEntClick() : '';
		}
		//禁止回退
		window.history.forward(1);
		self.location != top.location ? top.location = 'login.jsp':'';
		$('#susername').focus();
		document.getElementById("spassword").oncontextmenu=DisableCtrl;
		document.getElementById("spassword").onselectstart=DisableCtrl;
		document.getElementById("spassword").oncopy=DisableCtrl;
		document.getElementById("spassword").onpaste=DisableCtrl;
});
//设为首页
function fnSetHome(obj){
	var url=window.location.href;
       try{
               obj.style.behavior='url(#default#homepage)';
               obj.setHomePage(url);
       }catch(e){
       	if(window.netscape) {
           	try {
           		netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
               }catch (e) {
               	alert('Browser has refused');//浏览器拒绝
               }
               var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
           	prefs.setCharPref('browser.startup.homepage',url);
       	}
	}
}
//拼参数
function buildParams(iusername,ipassword){
	var params= '';
	var susername = $('#susername').val();
	var spassword = $('#spassword').val();
	if('' != susername){
		params += '&sadminname='+$.trim(susername);
	}else{
		//输入账号不允许为空
		alert(iusername);
		$('#susername').focus();
		return false;
	}
	if('' != spassword){
		params += '&spassword='+spassword;
	}else{
		//密码不允许为空
		alert(ipassword);
		$('#spassword').focus();
		return false;
	}
	return params;
}


//清空数据
function dataReset(){
	$('#susername').val('');
	$('#spassword').val('');
	$('#susername').focus('');	
}

//设置当前语言环境
function setLanguages(languageType){
 	window.location.href='login.jsp?languageType='+languageType;
}


