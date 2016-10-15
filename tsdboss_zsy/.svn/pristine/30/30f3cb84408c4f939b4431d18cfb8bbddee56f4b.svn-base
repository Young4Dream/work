package com.tsd.service.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



public class GetMac
{
    private String mPhysicalAddress = "";
    private int mPhysicalMacNumber = 0;
    private boolean isInit = false;
    public void init()
    {
        try
        {
            String line;
            Process process = Runtime.getRuntime().exec("cmd /c ipconfig /all");
            BufferedReader bufferedReader = new BufferedReader(
                            new InputStreamReader(process.getInputStream()));
            Pattern macPattern = Pattern.compile("([0-9A-Fa-f]{2})(-[0-9A-Fa-f]{2}){5}");
            Matcher macMatcher;
            boolean result;
            while ((line = bufferedReader.readLine()) != null)
            {
                if ("".equals(line))
                    continue;
                macMatcher = macPattern.matcher(line);
                result = macMatcher.find();
                if (result)
                {
                    mPhysicalMacNumber++;
                    if ("".equals(mPhysicalAddress))
                        mPhysicalAddress = macMatcher.group(0);
                    else
                        mPhysicalAddress += ("," + macMatcher.group(0));
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        isInit = true;
    }

    public String getPhysicalAddress()
    {
        if (isInit)
            return this.mPhysicalAddress;
        else
            return "Mac is not init.";
    }

    public int getPhysicalMacNumber()
    {
        if (isInit)
            return this.mPhysicalMacNumber;
        else
        {
            System.out.println("Mac is not init.");
            return 0;
        }
    }

    public static void main(String[] args)
    {	
    	GetMac mac = new GetMac();
        mac.init();
        System.out.println("MAC "+mac.getPhysicalMacNumber()+" address :" + mac.getPhysicalAddress());
    }
}
