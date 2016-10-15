package com.tsd.service;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import oracle.jdbc.OracleTypes;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONStringer;

import com.tsd.dao.DBhelper;
import com.tsd.service.util.LoadProperties;
import com.tsd.web.servlet.ExeMethodFactory;

/**
 * 系统菜单服务对象，用来产生系统菜单，并提供对菜单的一些列操作
 * @author luoyulong
 * @version 1.0, 2010-8-19 下午01:57:03
 *
 */
public class SysMenuService {
	/**
	 * 控制器，根据传递的operate参数来判断调用哪个方法。
	 */
	public static void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String operate = request.getParameter("operate");
		try{
			if(operate==null) throw new Exception();
			ExeMethodFactory.executeMethod(request, response,"com.tsd.service.SysMenuService", operate);
		}catch (Exception e) {
			System.err.println("class: com.tsd.service.SysMenuService method: service. error!");
			e.printStackTrace();
		}
	}
	
	/**
	 * 根据ID修改节点的级别。
	 * @throws JSONException 
	 */
	public static void updateNodeLevelById(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, JSONException {
		String nodes = request.getParameter("nodes");//需要修改的节点的JSON形式的集合字符串
		String ds = request.getParameter("ds");
		Connection conn = null;
		String dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);
		conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
		String db = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
		String sql = LoadProperties.getKeyValues(db, "sysmenu.updateNodeLevelById");
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			JSONArray nodeList = new JSONArray(nodes);//将字符串转换成JSON对象
			for (int i = 0; i < nodeList.length(); i++) {
				//循环取得每一个要更新的菜单的ID和级别
				JSONObject node = nodeList.getJSONObject(i);
				//设置预编译语句集
				ps.setInt(1, node.getInt("level"));
				ps.setInt(2, node.getInt("id"));
				ps.addBatch();//添加到批处理命令中
			}
			ps.executeBatch();//执行批处理，批量更新
			nodeList=null;
			ps.close();
			ps=null;
		}finally{
			conn.close();
			conn=null;
		}
	}
	
	/**
	 * 根据条件获得菜单集合
	 * @param userid 用户ID
	 * @param menuType 要生成的菜单类型(show,update,power)
	 * @param groupid 接受类似这样  9,10,11
	 * @param ds 数据源
	 * @param tsdcf 配置文件
	 * @return 菜单集合
	 * @throws SQLException 
	 */
	private static List<Map> getMenu(String userid,String menuType,String groupid,String ds,String tsdcf) throws SQLException{
		List<Map> menus = new ArrayList<Map>();
		Connection conn = null;
		String sql = null;
		ResultSet rs=null;
		CallableStatement call = null;
		String paramters=null;
//		groupid = groupid.replaceAll("~", ",");
		String dataSourceName = LoadProperties.getKeyValues("mainSystem", ds);	
		conn = DBhelper.getConnection(dataSourceName);//根据配置的数据源获得连接
		String dbName = DBhelper.getDatabaseProductName(conn);//根据数据连接获得数据库名
//		if("show".equalsIgnoreCase(menuType) && !"admin".equalsIgnoreCase(userid)
//				&& !"administrators".equalsIgnoreCase(groupid)){
//			sql = LoadProperties.getKeyValues(db, "sysmenu.showByGroupid");
//			sql = sql.replaceAll("<groupid>", groupid);
//		}else{
//			sql = LoadProperties.getKeyValues(db, "sysmenu.show");
//		}
		try {
			
			
			System.out.println("[menuType=========]: "+menuType);
			
//			Statement sm = conn.createStatement();
			System.out.println("[getmenu_sql======]: "+sql);
//			ResultSet rs = sm.executeQuery(sql);
			if("show".equalsIgnoreCase(menuType)) 
			{
				conn.setAutoCommit(false);
				if("oracle".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call GETMENU(?,?)}");
					call.registerOutParameter(2, OracleTypes.CURSOR);// 注册输出参数
				}else if("enterprisedb".equalsIgnoreCase(dbName)){
					call = conn.prepareCall("{call GETMENU(?,?)}");
					call.setNull(2,Types.REF);
					call.registerOutParameter(2, Types.REF);
				}
				else if ("PostgreSQL".equalsIgnoreCase(dbName))
				{
					call = conn.prepareCall("{call GETMENU(?,?)}");
					call.registerOutParameter(2, Types.OTHER);
				}else{
				 call =conn.prepareCall("{call GETMENU(?)}");
				}
				paramters = "userid="+userid+";groupid="+groupid;
				
				System.out.println("[SysMenuService.getmenuparams =========]: "+paramters);
				
				call.setObject(1, paramters);
				
				if ("oracle".equalsIgnoreCase(dbName) || "enterprisedb".equalsIgnoreCase(dbName) ||"PostgreSQL".equalsIgnoreCase(dbName)) {
					call.execute();
					rs = (ResultSet) call.getObject(2);
				}
				else{
					rs = call.executeQuery();
				}
				conn.commit();
			}
			else  //菜单设计update  权限管理 power
			{
				groupid = groupid.replaceAll("~", ",");
				if(!"admin".equalsIgnoreCase(userid) && !"1".equalsIgnoreCase(groupid))
				{
					sql = LoadProperties.getKeyValues(dbName, "sysmenu.showByGroupid");
					sql = sql.replaceAll("<groupid>", groupid);
				}
				else
				{
					sql = LoadProperties.getKeyValues(dbName, "sysmenu.show");
				}
				Statement sm = conn.createStatement();
				System.out.println("【getmenuSQL========】: "+sql);
				rs = sm.executeQuery(sql);
			}
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();
			Map node = null;
			String cname = null;
			int order = 1;//用来产生连续的序号
			while (rs.next()) {
				node = new HashMap();
				for (int i = 1; i <= count; i++) {
					cname = rsmd.getColumnName(i).toLowerCase();
					//如果是显示，则不使用数据库中的序号
					if ("iorder".equalsIgnoreCase(cname) && "show".equalsIgnoreCase(menuType))
						node.put(cname, order);//添加连续的序号到节点
					else
						node.put(cname, rs.getObject(i));
					//虚拟序号，用于menuType等于update时
					node.put("order",order);
				}
				order++;
				menus.add(node);
			}
		} catch (SQLException e) {
			System.err.println(e.getLocalizedMessage());
		}finally{
			if (call!=null) 
			{
				call.close();
				call = null;
			}
			if (rs != null) {
				rs.close();	
				rs = null;
			}
			if (conn != null)
			{
			    conn.close();
			    conn = null;
			}
		}
		return menus;
	}
	
	/**
	 * 生成菜单，可以根据用户权限，指定条件来生成JSON形式的菜单数据
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public static void show(HttpServletRequest request, HttpServletResponse response) throws IOException,JSONException, SQLException {
		response.setContentType("text/json; charset=utf-8");
		HttpSession session = request.getSession();
		String languageType = (String)session.getAttribute("languageType");//获得会话中的语言类型
		String userid = (String)session.getAttribute("userid");
		String menuType = request.getParameter("menutype");
		String groupid = (String)session.getAttribute("groupid");
		String ds = request.getParameter("ds");//数据源
		String tsdcf = request.getParameter("tsdcf");//配置文件
		
		//1.取得菜单数据
		//List<Map> menuList = (List<Map>)com.tsd.dao.ExecuteSql.exeSqlData(request, response, new ArrayList(),ds);
		List<Map> menuList = getMenu(userid,menuType,groupid,ds,tsdcf);
		if(menuList != null){
			List<Map> nodes = new ArrayList<Map>();
			List<Map> node_level_1 = new ArrayList<Map>();
			List<Map> node_level_2 = new ArrayList<Map>();
			List<Map> node_level_3 = new ArrayList<Map>();
			
			Integer node_level = null;//节点级别
			//ilevel,imenuid,smenuname,smenuurl,simgico,isvisible
			//2.将菜单数据按照ExtJS Tree支持的格式存放到集合中 
			for(Map e : menuList){
				Map node = new HashMap();
				node.put("iorder",e.get("iorder"));
				node.put("level",node_level=Integer.valueOf(e.get("ilevel").toString()));
				//node.put("cls","tree-node-level-"+node_level);
				node.put("id",e.get("imenuid"));
				node.put("text",getI18NText(e.get("smenuname").toString(),languageType));
				node.put("href",e.get("smenuurl"));
				node.put("icon",e.get("simgico"));
				node.put("hidden",!Boolean.valueOf(e.get("isvisible").toString()));
				node.put("children",new ArrayList<Map>());
				node.put("order",e.get("order"));
				nodes.add(node);
				if(node_level==1){
					node_level_1.add(node);//归类一级节点
				}else if(node_level==2){
					node_level_2.add(node);//归类二级节点
				}
				else if(node_level==3){
					node_level_3.add(node);//归类三级节点
				}
			}
			
			//3.将菜单关系设置正确
			//将四级节点添加到包含它的三级节点
			for (int i=0;i<node_level_3.size();i++) {
				Map n_3 = node_level_3.get(i);
				//获得当前二级节点位置
				int i_n_3 = Integer.valueOf(n_3.get("order").toString())-1;
				//将当前二级节点下的所有三级节点添加至其下
				A:for (int j = i_n_3+1; j < nodes.size(); j++) {
					j=(j>=nodes.size()?nodes.size():j);
					Map n_t = nodes.get(j);
					if(n_t.get("level").toString().equals("4")){
						((List)n_3.get("children")).add(n_t);
					}else{
						break A;
					}
				}
			}
			
			//将三级节点添加到包含它的二级节点
			for (int i=0;i<node_level_2.size();i++) {
				Map n_2 = node_level_2.get(i);
				//获得当前二级节点位置
				int i_n_2 = Integer.valueOf(n_2.get("order").toString())-1;
				//将当前二级节点下的所有三级节点添加至其下
				A:for (int j = i_n_2+1; j < nodes.size(); j++) {
					j=(j>=nodes.size()?nodes.size():j);
					Map n_t = nodes.get(j);
					if(n_t.get("level").toString().equals("3")){
						((List)n_2.get("children")).add(n_t);
					}else if(Integer.valueOf(n_t.get("level").toString())<=2){
						break A;
					}
				}
			}
			//将二级节点添加到包含它的一级节点
			for (int i=0;i<node_level_1.size();i++) {
				Map n_1 = node_level_1.get(i);
				//获得当前一级节点位置
				int i_n_1 = Integer.valueOf(n_1.get("order").toString())-1;
				//将当前一级节点下的所有二级节点添加至其下
				A:for (int j = i_n_1+1; j < nodes.size(); j++) {
					j=(j>=nodes.size()?nodes.size():j);
					Map n_t = nodes.get(j);
					String n_t_l = n_t.get("level").toString();
					if("2".equals(n_t_l)){
						((List)n_1.get("children")).add(n_t);
					}else if("1".equals(n_t_l)){
						break A;
					}
				}
			}
			
			//4.将集合中的菜单数据转换为ExtJS Tree 支持的JSON格式，并输出到客户端
			String jsonTreeData = getJSON(new JSONStringer(),node_level_1);
			System.out.println("[getmenu_data=======]: "+jsonTreeData);
			response.getWriter().print(jsonTreeData);
		}
	}
	/**
	 * 递归遍历节点列表，会将所有叶子节点遍历出来，转换为JSON格式返回
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	private static String getJSON(JSONStringer j,List<Map> l) throws JSONException{
		j.array();
			for (Map n : l) {
				j.object()
					.key("level").value(n.get("level"))
					.key("id").value(n.get("id"))
					.key("iorder").value(n.get("iorder"))
					.key("text").value(n.get("text"))
					.key("href").value(n.get("href"))
					.key("icon").value(n.get("icon"))
					.key("hidden").value(n.get("hidden"))
					.key("children");
					getJSON(j,(List<Map>)n.get("children"));
				j.endObject();
			}
		j.endArray();
		return j.toString();
	}
	
	/**
	 * 提取类似这样的格式{zh=开户/}{en=open/}
	 */
	private static String getI18NText(String text,String language){
		String lang;
		if(language==null || text.indexOf("{"+language+"=")==-1){
			language = "zh";
		}
		lang="{"+language+"=";
		int begin = text.indexOf(lang)+2+language.length();
		int end = text.indexOf("/}",begin);
		return text.substring(begin, end);
	}
}
