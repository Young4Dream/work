package com.tboss.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.tboss.ssm.mapper.YhdangMapper;
import com.tboss.ssm.po.Yhdang;
import com.tboss.ssm.po.YhdangExample;
import com.tboss.ssm.po.YhdangExample.Criteria;
import com.tboss.ssm.service.JsonTestService;

public class JsonTestImp implements JsonTestService{

	@Autowired
	private YhdangMapper yhdangMapper;
	@Override
	public List<Yhdang> findYhdang(String hth) {
		// TODO Auto-generated method stub
		List<Yhdang> yhdangs = null;
	      YhdangExample example = new YhdangExample();
	      Criteria criteria = example.createCriteria();
	      example.setOrderByClause("dh asc");
	      criteria.andHthEqualTo(hth);
	      yhdangs = yhdangMapper.selectByExample(example);
		return yhdangs;
	}

}
