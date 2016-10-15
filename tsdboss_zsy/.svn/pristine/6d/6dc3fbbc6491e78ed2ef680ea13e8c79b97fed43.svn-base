package com.tsd.service.util;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

public class SortingLogFilter {
	private volatile static  Queue<Map<String,List<String>>> logQueue = null;
	private SortingLogFilter(){}
	
	public static Queue<Map<String,List<String>>> getLogList(){
        //先检查实例是否存在，如果不存在才进入下面的同步块
        if(logQueue == null){
            //同步块，线程安全的创建实例
            synchronized (Queue.class) {
                //再次检查实例是否存在，如果不存在才真正的创建实例
                if(logQueue == null){
                	logQueue = new LinkedList<Map<String,List<String>>>(); 
                }
            }
        }
        return logQueue;
    }

	public static synchronized void addLogList(String fileName,List<String> logList){
		if(logQueue.size()>2){
			//System.out.println("#####################删除队列文件##################");
			moveLogList();
		}
		Map<String,List<String>> logMap = new HashMap<String,List<String>>();
		logMap.put(fileName, logList);
		logQueue.offer(logMap);
    }
	
	public static synchronized void moveLogList(){
		logQueue.poll();
	}
}
