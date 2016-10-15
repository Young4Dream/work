/**
 * 接口调用工具，提供接口的JS调用方式
 * @author luoyulong
 * @version 1.0, 2010-7-20
 */
if(!this.TSDInterface){
	this.TSDInterface = {};
}
	
	function getinterface(){
		var resInterface='';
		resInterface = fetchSingleValue('dbsql_broanband_Interface',6,"&sSection="+'Interface'+"&sItem="+'tsd_Interface');
		if(resInterface==undefined||resInterface==""||resInterface==null){
			return "获取接口调用参数失败，请检查是否配置接口调用参数！";
		}else{
			return resInterface;
		}		 
	}

(function(){				
	
	//ZXISAM系统北向接口-业务操作接口 [BEGIN]
	/**
	 * ZXISAM对象，提供中兴接口的调用方法
	 * @author luoyulong
	 * @version 1.0, 2010-7-20
	 */
	TSDInterface.ZXISAM = {
		//错误信息
		ERROR_INFO : "{\"resultInfo\":{\"infoNo\":0,\"infoStr\":null},\"info\":\"error\"}",
		/**
		 * 开户
		 * 使用示例：var r = TSDInterface.ZXISAM.open("user_tsd01","123456",1,1,"IT组",["test","test2"]);
		 * @param userAccount 用户账户，必须由字母、数字、下划线组成，且长度在3和20之间。必填。
		 * @param password 用户密码，必须为非空白字符，且长度在6和20之间。必填。
		 * @param portLimit 最大在线数，0表示不限制，最大为20，必填。
		 * @param payType 付费类型，1预付费，2后付费，必填。
		 * @param groupName 用户组名称，用户组名称由英文，数字，下划线，汉字组成，且长度在2和16之间。选填。
		 * @param serviceName 服务名称，服务可以看做用户接入策略的集合，包括后缀、资费、绑定信息、授权信息等。
		 * @return 返回一个对象，包含 resultInfo 对象 和 info 对象，如果调用失败，resultInfo 对象将包含描述信息
		 * 				resultInfo 对象包含 infoNo 、infoStr 两个属性，当 info 对象 为 true 时表示调用成功
		 */
		open : function(userAccount,password,portLimit,payType,groupName,serviceName){
			strict([String,String,Number,Number,String,Array],arguments);
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"open",
				"userAccount":userAccount,
				"password":password,
				"portLimit":portLimit,
				"payType":payType,
				"groupName":groupName,
				"serviceName":serviceName,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 销户
		 * @param userAccount 用户账户
		 * @return 返回一个对象，包含 resultInfo 对象 和 info 对象，如果调用失败，resultInfo 对象将包含描述信息
		 * 				resultInfo 对象包含 infoNo 、infoStr 两个属性，当 info 对象 为 true 时表示调用成功
		 */
		close:function(userAccount){
			strict([String],arguments);
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"close",
				"userAccount":userAccount,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 查询在线用户信息
		 * @param queryType 账号查询匹配类型，0不进行模糊查询，1进行右模糊查询
		 * @param userAccount 用户账户，作为查询条件。用户账号必须由字母、数字、下划线组成，且长度在3和20之间
		 * @param groupName 用户组名称，作为查询条件。用户组名称由英文，数字，下划线，汉字组成，且长度在2和16之间，选填
		 * @param serviceName 服务名称，作为查询条件。服务名称可以是除 > < & % / " ' 空格 外的任意字符，且长度必须小于32。选填
		 * @param queryTimeRange 查询上线时间区间，作为查询条件。长度为2的String数组。 查询在一个时间段内上线的用户。
		 * 						第一个值为查询开始时间，第二个值为查询结束时间。时间可以精确到时分秒格式如下："2010-06-23 15:30:00"
		 * @return 
		 */
		queryOnlineUser:function(queryType,userAccount,groupName,serviceName,queryTimeRange){
			strict([Number,String,String,String,Array],arguments);
			if(queryTimeRange.length>2){
				throw new Error("参数 queryTimeRange 的长度不能大于2");
			}
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"queryOnlineUser",
				"queryType":queryType,
				"userAccount":userAccount,
				"groupName":groupName,
				"serviceName":serviceName,
				"queryTimeRange":queryTimeRange,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 修改密码
		 * @param userAccount 用户账户
		 * @param newPwd 新密码
		 * @param oldPwd 旧密码
		 * @return 返回一个对象，包含 resultInfo 对象 和 info 对象，如果调用失败，resultInfo 对象将包含描述信息
		 * 				resultInfo 对象包含 infoNo 、infoStr 两个属性，当 info 对象 为 true 时表示调用成功
		 */
		changePassword:function(userAccount,newPwd,oldPwd){
			strict([String,String,String],arguments);
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"changePassword",
				"userAccount":userAccount,
				"newPwd":newPwd,
				"oldPwd":oldPwd,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 停/复机
		 * @param userAccount 用户账户
		 * @param offType 用户状态
		 * 停机分三种类型：
		 * （1）用户主动申请，状态为2
		 * （2）用户因为欠费停机，状态为4
		 * （3）资费为周期类型的预付费用户，如包月用户，当余额小于月租时也会停机，称为余额不足停机，状态为5
		 * 当用户进行停机时，调用本接口，按情况填写状态。
		 * 当用户进行复机时，调用本接口，将状态改为1，表示恢复正常。
		 * @return 返回一个对象，包含 resultInfo 对象 和 info 对象，如果调用失败，resultInfo 对象将包含描述信息
		 * 				resultInfo 对象包含 infoNo 、infoStr 两个属性，当 info 对象 为 true 时表示调用成功
		 */
		changeStatus:function(userAccount,offType){
			strict([String,Number],arguments);
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"changeStatus",
				"userAccount":userAccount,
				"offType":offType,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 服务解绑定
		 * @param userAccount 用户账户
		 * @param serviceName	需要删除绑定信息的服务
		 *                                  针对不同的服务，用户可以设置绑定信息，如绑定NasIP，绑定用户IP地址。
		 *                                  当用户位置变更时，需要删除原绑定信息，重新进行位置绑定。此处填写需
		 *                                  要清空的绑定信息的服务名称。
		 * @return 返回一个对象，包含 resultInfo 对象 和 info 对象，如果调用失败，resultInfo 对象将包含描述信息
		 * 				resultInfo 对象包含 infoNo 、infoStr 两个属性，当 info 对象 为 true 时表示调用成功
		 */
		removeBind:function(userAccount,serviceName){
			strict([String,Array],arguments);
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"removeBind",
				"userAccount":userAccount,
				"serviceName":serviceName,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 强制下线
		 * @param userAccount 用户账户
		 * @param userMac 用户Mac地址 格式为XX-XX-XX-XX-XX-XX，
		 *                            可以从在线用户查询接口中获取。填写时，系统将匹配该账号
		 *                            和Mac的一个用户下线，不填时系统会将该账号的所有在线用户全部下线。选填
		 * @param offType 强制下线类型 1，强制下线。2，清零
		 *                          一般情况下，offType填1即可以使用户下线；当因为ISAM系统
		 *                          中的在线信息与设备不同步（极少发生）造成用户无法上线时，
		 *                          可以将offType置为2，表示清除ISAM系统中的该用户的会话信息。必填
		 * @return 返回一个对象，包含 resultInfo 对象 和 info 对象，如果调用失败，resultInfo 对象将包含描述信息
		 * 				resultInfo 对象包含 infoNo 、infoStr 两个属性，当 info 对象 为 true 时表示调用成功
		 */
		offline:function(userAccount,userMac,offType){
			strict([String,String,Number],arguments);
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"offline",
				"userAccount":userAccount,
				"userMac":userMac,
				"offType":offType,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 业务变更
		 * @param userAccount 用户账户
		 * @param serviceName 变更后的服务名称
		 *                                 需要填写变更后所有的服务，比如用户原来的服务为A、B，
		 *                                 需要把B改为C，则应该填写A、C，而不仅仅填写C
		 * @return 返回一个对象，包含 resultInfo 对象 和 info 对象，如果调用失败，resultInfo 对象将包含描述信息
		 * 				resultInfo 对象包含 infoNo 、infoStr 两个属性，当 info 对象 为 true 时表示调用成功
		 */
		changeService:function(userAccount,serviceName){
			strict([String,Array],arguments);
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"changeService",
				"userAccount":userAccount,
				"serviceName":serviceName,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		},
		/**
		 * 认证失败日志查询
		 * @param userAccount 账号 作为查询条件。用户账号必须由字母、数字、下划线组成，且长度在3和20之间。
		 *                                 说明：由于失败日志数量级别比较大，受到soap协议传输报文长度限制
		 *                                 ，现只支持单个账号查询，不支持模糊查询。不能为空
		 * @param queryTimeRange 查询认证时间区间
		 */
		queryUserFailedLog:function(userAccount,queryTimeRange){
			strict([String,Array],arguments);
			if(queryTimeRange.length>2){
				throw new Error("参数 queryTimeRange 的长度不能大于2");
			}
			var result = TSDInterface.ZXISAM.ERROR_INFO;
			var p = {
				"packgname":"ws","clsname":"ZxisamClient","method":"service","ws_method":"queryUserFailedLog",
				"userAccount":userAccount,
				"queryTimeRange":queryTimeRange,
				"_t":Math.random()
			};
			ajax("POST","mainServlet.html",p,function(r){p=null;result=r;},false);
			return result;
		}
	};
	//ZXISAM系统北向接口-业务操作接口 [END]

	//Ajax工具
	function ajax(method,url,data,callback,async){
		strict([String,String,Object,Function,Boolean],arguments);
		var xmlHttp = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
		xmlHttp.open(method, (method=="POST"?url:url+"?"+serialize(data)), async);
		if(method=="POST")
			xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		if(xmlHttp.overideMimeType)
			xmlHttp.setRequestHeader("Connection","close");
		xmlHttp.onreadystatechange = function(){
			if (xmlHttp.readyState == 4 && ((xmlHttp.status >= 200 && xmlHttp.status < 300) || xmlHttp.status == 304)) {
				callback(xmlHttp.responseText);// 调用用户传递过来的方法,将responseText返回
				xmlHttp = null;// 释放资源
			}
		};
		try {
			xmlHttp.send((method=="POST"?serialize(data):null));
		} catch(e) {
			callback("error");
			xmlHttp = null;
		}
	}
	
	//将对象转换为HTTP的参数模式
	function serialize(obj){
		var s=[];
		for(var p in obj)
			s.push(p+"="+obj[p]);
		return s.join("&");
	}
	
	//参数检查工具
	function strict(types,args){
		//检查参数数量
		if(types.length != args.length)
			throw new Error("无效的参数个数。预期 " + types.length + " 个参数，接收到 " + args.length + " 个参数。");
		//检查参数类型
		for(var i=0; i<args.length; i++) {
			if(args[i].constructor != types[i])
				throw new Error("无效的参数类型。");
		}
	}
})();