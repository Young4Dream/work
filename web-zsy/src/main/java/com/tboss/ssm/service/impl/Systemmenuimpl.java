package com.tboss.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.tboss.ssm.mapper.TBsMenuInfoMapper;
import com.tboss.ssm.po.TBsMenuInfo;
import com.tboss.ssm.po.TBsMenuInfoExample;
import com.tboss.ssm.service.SystemmenuService;

public class Systemmenuimpl implements SystemmenuService {

	@Autowired
	private TBsMenuInfoMapper tBsMenuInfoMapper;
	@Override
	public List<TBsMenuInfo> findMenuList(String roleId) throws Exception {
		List<TBsMenuInfo> menuInfos = null;
		if (roleId!=null){
			TBsMenuInfoExample example = new TBsMenuInfoExample();
			example.setOrderByClause("parent_id,menu_sort asc");
			menuInfos = tBsMenuInfoMapper.selectByExample(example);
		}
		return menuInfos;
	}

}
