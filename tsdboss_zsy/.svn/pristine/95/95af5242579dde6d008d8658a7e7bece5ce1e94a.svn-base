package com.tsd.service.util;

/**
 * HTML 过滤工具
 * 
 * @author luoyulong
 * @version 1.0, 2010-10-11 下午03:13:46
 * 
 */
public final class HTMLFilter {

	/**
	 * 将返回给浏览器的内容过滤为不会产生歧义的形式
	 * 
	 * @param message
	 *            内容
	 * @return 过滤后的内容
	 */
	public static String filter(String message) {

		if (message == null)
			return (null);

		char content[] = new char[message.length()];
		message.getChars(0, message.length(), content, 0);
		StringBuffer result = new StringBuffer(content.length + 50);
		for (int i = 0; i < content.length; i++) {
			switch (content[i]) {
			case '<':
				result.append("&lt;");
				break;
			case '>':
				result.append("&gt;");
				break;
			case '&':
				result.append("&amp;");
				break;
			case '"':
				result.append("&quot;");
				break;
			default:
				result.append(content[i]);
			}
		}
		return (result.toString());

	}

	public static void main(String[] args) {
		System.out.println(HTMLFilter.filter("<b>\"te&st\"</b>"));
	}
}
