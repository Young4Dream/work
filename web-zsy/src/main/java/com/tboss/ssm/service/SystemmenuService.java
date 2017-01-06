package com.tboss.ssm.service;

import java.util.List;

import com.tboss.ssm.po.TBsMenuInfo;


public interface SystemmenuService {
    
	public  List<TBsMenuInfo> findMenuList(String roleId) throws Exception;
}
