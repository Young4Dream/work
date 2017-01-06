package com.tboss.ssm.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.tboss.ssm.mapper.YhdangMapper;
import com.tboss.ssm.po.Yhdang;
import com.tboss.ssm.po.YhdangExample;
import com.tboss.ssm.po.YhdangExample.Criteria;
import com.tboss.ssm.service.AccountLoginService;

public class AccountLoginimp implements AccountLoginService{
    
	@Autowired
	private YhdangMapper yhdangMapper;
	@Override
	public List<Yhdang> findYhdangList(String dh,String hth, String password,HttpSession session)
			throws Exception {
		
	      List<Yhdang> yhdangs = null;
	      YhdangExample example = new YhdangExample();
	      Criteria criteria = example.createCriteria();
	      example.setOrderByClause("order by dh asc");
	      if(dh!=null){
	      criteria.andDhEqualTo(dh);}
	      if(hth!=null){
	      criteria.andHthEqualTo(hth);}
	      criteria.andMimaEqualTo(password);
	      criteria.andRownum();
	      yhdangs = yhdangMapper.selectByExample(example);
		  if(null!=yhdangs){
			  String sHth=yhdangs.get(1).getHth();
			  session.setAttribute("hth", sHth);
			  session.setAttribute("password", password);
			  session.setAttribute("dh", hth);
		  }
	      return yhdangs;
	}
	@Override
	public String updateYhdang(String dh,String hth, String password,HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		int i = 0;
		 YhdangExample example = new YhdangExample();
		 YhdangExample.Criteria criteria = example.createCriteria();
		 criteria.andHthEqualTo(hth);
		 criteria.andDhEqualTo(hth);
		 Yhdang record = new Yhdang();
		 record.setMima(password);
		 i= yhdangMapper.updateByExampleSelective(record, example);
		 String re = null;
		 if (i>0){
			 re="success";
		 }else {
			 re="error";
		}
		return re;
	}
   
}
