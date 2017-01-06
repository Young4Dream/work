package com.tboss.ssm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tboss.ssm.po.Yhdang;
import com.tboss.ssm.service.AccountLoginService;

@Controller
public class AccountLoginController {
    
	@Autowired
	private AccountLoginService accountLoginService;
	@RequestMapping("/AccountLogin")
	@ResponseBody
	public List<Yhdang> AccountLogin(String dh,String hth,String passwork,HttpSession session) throws Exception{
		
		List<Yhdang> yhdangs = null;
		yhdangs = accountLoginService.findYhdangList(dh,hth, passwork,session);
		return yhdangs;
	}
	
	@RequestMapping("/AccountPassword")
	@ResponseBody
	public String AccountPassword (String dh,String hth , String passwork,HttpSession session) throws Exception{
		
		String ret = null;
		ret = accountLoginService.updateYhdang(dh,hth, passwork,session);
		return ret;
	}
}
