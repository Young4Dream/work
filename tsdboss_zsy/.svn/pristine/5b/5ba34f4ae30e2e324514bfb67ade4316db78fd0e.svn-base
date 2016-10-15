/**
 * 
 */
package com.tsd.service;

/**
 * @author Dangchengcheng
 *
 */
public class SearchOper {

	/**
	 * 
	 */
	public SearchOper() {
		// TODO Auto-generated constructor stub
	}

	/*
bw - begins with ( LIKE val% )
eq - equal ( = )
ne - not equal ( <> )
lt - little ( < )
le - little or equal ( <= )
gt - greater ( > )
ge - greater or equal ( >= )
ew - ends with (LIKE %val )
cn - contain (LIKE %val% )
	 */
	public static String getOper(String op){
		if (op.equalsIgnoreCase("bw")){ //开始于
			return " like ";
		}else if (op.equalsIgnoreCase("ge")){
			return " >= ";
		}else if (op.equalsIgnoreCase("eq")){
			return " = ";
		}else if (op.equalsIgnoreCase("ne")){
			return " <> ";
		}else if (op.equalsIgnoreCase("lt")){
			return " < ";
		}else if (op.equalsIgnoreCase("le")){
			return " <= ";
		}else if (op.equalsIgnoreCase("gt")){
			return " > ";
		}else if (op.equalsIgnoreCase("ew")){//结束于
			return " like ";
		}else if (op.equalsIgnoreCase("cn")){ //包含
			return " like ";
		}else { //包含
			return " like ";
		}
	}
	
	public static String getOper_(String op,String postion){
		if (op.equalsIgnoreCase("bw")){ //开始于
			return "left".equals(postion)?" '":"%' ";
		}else if (op.equalsIgnoreCase("ge")){
			return " ";
		}else if (op.equalsIgnoreCase("eq")){
			return " ";
		}else if (op.equalsIgnoreCase("ne")){
			return " ";
		}else if (op.equalsIgnoreCase("lt")){
			return " ";
		}else if (op.equalsIgnoreCase("le")){
			return " ";
		}else if (op.equalsIgnoreCase("gt")){
			return " ";
		}else if (op.equalsIgnoreCase("ew")){//结束于
			return "left".equals(postion)?" '%":"' ";
		}else if (op.equalsIgnoreCase("cn")){ //包含
			
			return "left".equals(postion)?" '%":"%' ";
		}else { //包含
			return "' ";
		}
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
