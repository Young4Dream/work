package com.tboss.ssm.service;

import com.tboss.ssm.po.LoginCustom;
public interface LoginService {

	public LoginCustom findLoginList (LoginCustom loginCustom) throws Exception;
}
