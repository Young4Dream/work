
/***********************************************************
		        file name:		DeviceManage.js
				author:          youhongyu 
				create date:     2012-6-11         
				description:
				modify:			
********************************************************/

/**********************************************************
				function name:   queryUser()
				function:		 根据工单传过来的参数查询用户信息
				parameters:       
				return:			 
				description:     生产调用中访问用户号线资料修改页面
********************************************************/
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
		    for (var i = 1 ; i < count; i++)
		    {
		        disradio = '<input type="radio" onclick="disCheckIcon('+ "'" + idsval + "','"+idsshow+"'" + ')" ';
		       	disradio += 'value="style/icon/device/' + i + '.jpg" style="margin-left:5px;float:left;" ';
		       	disradio += 'name="'+disname+'" id="icon' + i + '" />';
        		info = '<label><img style="margin-left: 2px;float:left;" width="138px" height="128px" src="' +devicepath+ i + '.jpg"/></label>';
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
		
		
		/**
		 * 清空多选下拉框
		 * @param 
		 * @return  
		 */
		function clearMultiSelect(){
				$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
				$(".multiSelectOptions :disabled").removeAttr("disabled");
				$(".multiSelect").attr("trueval","");
		}