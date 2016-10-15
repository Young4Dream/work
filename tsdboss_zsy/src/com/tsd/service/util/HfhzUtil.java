package com.tsd.service.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tsd.entity.YhdangHz;

public class HfhzUtil {
	
	
	/**
	 * 把用户档汇总数据的list转换成map,key为dh
	 * @param yhdangHzList
	 * @return yhdangHzListMap
	 */
	public static Map<String, YhdangHz> getyhdangHzListMap(List<YhdangHz> yhdangHzList) {
		
		Map<String, YhdangHz> yhdangHzListMap = new HashMap<String,YhdangHz>();
		
		for(int i = 0; i < yhdangHzList.size(); i++){
			
			yhdangHzListMap.put(yhdangHzList.get(i).getDh(), yhdangHzList.get(i));
		}
		return yhdangHzListMap;
	}

}
