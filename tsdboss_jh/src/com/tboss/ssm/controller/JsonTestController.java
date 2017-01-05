package com.tboss.ssm.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tboss.ssm.po.Yhdang;
import com.tboss.ssm.service.JsonTestService;

@Controller
public class JsonTestController {
	@Autowired
	private JsonTestService jts;
	@RequestMapping(value="/yhdang",method=RequestMethod.POST)
	
	public @ResponseBody String findByHth(String hth,HttpServletResponse response,ModelAndView modelAndView){
		List<Yhdang> list =new ArrayList<Yhdang>();
		list=jts.findYhdang(hth);
		String json=JSONArray.fromObject(list).toString();
		modelAndView.setViewName("NewFile");
		modelAndView.addObject("yhdangs",json);
		if(list.size()>0){
			modelAndView.addObject("msg", "success");
		}else  modelAndView.addObject("msg", "fail");
		return json;
	}
}
