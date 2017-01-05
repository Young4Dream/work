package com.tboss.ssm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;

import com.tboss.ssm.mapper.LoginMapperCustom;
import com.tboss.ssm.po.LoginCustom;
import com.tboss.ssm.service.LoginService;

public class LoginServiceimpl implements LoginService{
	@Autowired
	private LoginMapperCustom loginMapperCustom;
	@Override
	public LoginCustom findLoginList(LoginCustom loginCustom)
			throws Exception {
		
		return loginMapperCustom.findIoginList(loginCustom);
	}
	


}
