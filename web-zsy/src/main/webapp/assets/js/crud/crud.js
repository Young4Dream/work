function ajaxCRUD(url, params, isAlert) {
	var resData;
	$.ajax({
				url : url,
				data : params,
				type : 'post',
				dataType : 'json',
				async : false, // 同步false
				error : function(data) {
					bootbox.alert({
								locale : "zh_CN",
								size : 'small',
								title : "提示",
								message : "error"
							});
				},
				success : function(data) {
					if (isAlert) {
						bootbox.alert({
									locale : "zh_CN",
									size : 'small',
									title : "提示",
									message : data.res
								});
					}
					resData = data;
				}
			});

	return resData;
}

// 是否有子节点
// 返回值 >0 有子节点
function hasChild(menuId, menuList) {
	var t = 0;
	for (var i = 0; i < menuList.length; i++) {
		var menu = menuList[i];
		if (menuId == menu.parentId) {
			t += 1;
		}
	}
	return t;
}
