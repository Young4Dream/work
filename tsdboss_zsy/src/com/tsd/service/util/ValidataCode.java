package com.tsd.service.util;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;


/*******************************************************************************
 * 生成验证码
 * 
 * @author tongyong
 * 
 */
public class ValidataCode{
	
	public static void buildValidataImg(){
		BufferedImage image=new BufferedImage(100,40,BufferedImage.TYPE_INT_RGB);
		Graphics grap = image.getGraphics();
		Random rd = new Random();
		int max=230;
		int min=18;
		grap.setColor(getRanColor(max,min));
		grap.fillOval(0, 0, 99, 39);
//		grap.drawImage(img, x, y, width, height, bgcolor, observer)
	}

	private static Color getRanColor(int max, int min) {
		if(max>255){
			max=255;
		}
		if(min>255){
			min=255;
		}
		Random rd = new Random();
		int r = min+rd.nextInt(max-min);
		int g = min+rd.nextInt(max-min);
		int b = min+rd.nextInt(max-min);
		return new Color(r,g,b);
	}

}
