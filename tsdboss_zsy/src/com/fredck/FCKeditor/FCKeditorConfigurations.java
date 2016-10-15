 /*****************************************************************
 * name: FCKeditorConfigurations.java
 * author: Simone Chiaretta
 * version: 2.3 2005-08-11 16:29:00
 * description: FCKeditor是一款功能强大的开源在线文本编辑器(DHTML editor)，
 *                   它使你在web上可以使用类似微软Word 的桌面文本编辑器的许多强大功能。
 *                   它是轻量级且不必在客户端进行任何方式的安装。
 *                   FCKeditor兼容 Firefox, Mozilla, Netscape 和 IE。
 * modify: 2010-11-19 luoyulong 添加注释
 *****************************************************************/
/*
 * FCKeditor - The text editor for internet
 * Copyright (C) 2003-2005 Frederico Caldeira Knabben
 * 
 * Licensed under the terms of the GNU Lesser General Public License:
 * 		http://www.opensource.org/licenses/lgpl-license.php
 * 
 * For further information visit:
 * 		http://www.fckeditor.net/
 * 
 * File Name: FCKeditorConfigurations.java
 * 	FCKeditor configurations container.
 * 
 * Version:  2.3
 * Modified: 2005-08-11 16:29:00
 * 
 * File Authors:
 * 		Simone Chiaretta (simo@users.sourceforge.net)
 */


package com.fredck.FCKeditor;

import java.util.*;

/**
 * Contains the configuration settings for the FCKEditor.<br>
 * Adding element to this collection you can override the settings specified in the config.js file.
 *
 * @author Simone Chiaretta (simo@users.sourceforge.net)
 */
public class FCKeditorConfigurations extends HashMap{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
     * Initialize the configuration collection
     */
	public FCKeditorConfigurations() {
		super();
	}

	/**
     * Generate the url parameter sequence used to pass this configuration to the editor.
     *
     *
     *@return html endocode sequence of configuration parameters
     */	
	public String getUrlParams() {
		StringBuffer osParams = new StringBuffer();
		
		for(Iterator i=this.entrySet().iterator();i.hasNext();) {
			Map.Entry entry = (Map.Entry) i.next();
			if(entry.getValue()!=null)
				osParams.append("&"+encodeConfig(entry.getKey().toString())+"="+encodeConfig(entry.getValue().toString()));
		}
		return osParams.toString();
	}
	
	private String encodeConfig(String txt) {
		txt=txt.replaceAll("&","%26");
		txt=txt.replaceAll("=","%3D");
		txt=txt.replaceAll("\"","%22");
		return txt;
	}
	
}
