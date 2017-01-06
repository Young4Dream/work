package com.tboss.ssm.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.tboss.ssm.po.Yhdang;

public interface AccountLoginService {
      
	 public List<Yhdang> findYhdangList (String dh,String hth,String password,HttpSession session) throws Exception;
	 
	 public String updateYhdang(String dh,String hth,String password,HttpSession session) throws Exception;
}
