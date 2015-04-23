package com.yuhui.core.utils;


/**
@author xxz
@version v2.0
 */

import java.net.InetAddress;
import java.net.UnknownHostException;

import java.util.Date;
import java.util.StringTokenizer;



public class UUID
{
  public static String Gen_UUID()
  {
    String result = null;

    //
    String H_Way = "a";

    //
    String H_IP = null;
    String Defalult_IP = "FFFFFFFF";
    try
    {
      InetAddress Local = InetAddress.getLocalHost();
      H_IP = Local.getHostAddress();
      StringTokenizer st = new StringTokenizer(H_IP,".");
      H_IP = Long.toHexString(Integer.parseInt(st.nextToken()) * Math.round(Math.pow(2,24))
                              + Integer.parseInt(st.nextToken()) * Math.round(Math.pow(2,16))
                              + Integer.parseInt(st.nextToken()) * Math.round(Math.pow(2,8))
                              + Integer.parseInt(st.nextToken()));
      if(H_IP.length() < 8)
      {
        H_IP = "0" + H_IP;
      }
    }
    catch(UnknownHostException e)
    {
      H_IP = Defalult_IP;
    }

    //
    String H_Now = Long.toHexString(new Date().getTime());
    while(H_Now.length() < 12)
    {
      H_Now = "0" + H_Now;
    }
    while(H_Now.length() > 12)
    {
      H_Now = H_Now.substring(H_Now.length() - 12,H_Now.length());
    }

    //
    char C_Random[] = new char[4];
    C_Random[0] = Random_Char();
    C_Random[1] = Random_Char();
    C_Random[2] = Random_Char();
    C_Random[3] = Random_Char();
    String H_Random = String.valueOf(C_Random);

    //
    char C_Random2[] = new char[3];
    C_Random2[0] = Random_Char();
    C_Random2[1] = Random_Char();
    C_Random2[2] = Random_Char();
    String H_Nouse = String.valueOf(C_Random2);

    result = H_Way + H_IP + H_Now + H_Random + H_Nouse;

    //
    byte H_Check = (byte)result.charAt(0);
    for(int temp_int = 1;temp_int < result.length(); temp_int ++)
    {
       H_Check = (byte)((byte)result.charAt(temp_int) ^ (byte)H_Check);
    }
    if(H_Check <= 0xf)
    {
       result += "0" + Integer.toHexString(H_Check);
    }
    else
    {
      result += Integer.toHexString(H_Check);
    }


    return result;
  }

  private static final char Random_Char()
  {
    char result = 58;
    while(((result > 57) && (result < 65)) || ((result > 90) && (result < 97)))
    {
       result = (char)(((Math.random() * Integer.MAX_VALUE) % 62) + 48);//10�����֣�52����ĸ
    }

    return result;
  }
  
  
  public static  String getRandom_Char_to4()
  {
	  //
	    char C_Random[] = new char[4];
	    C_Random[0] = Random_Char();
	    C_Random[1] = Random_Char();
	    C_Random[2] = Random_Char();
	    C_Random[3] = Random_Char();
	    String H_Random = String.valueOf(C_Random);
	    return H_Random;
  }
  
  public static String Gen_22BUUID(){
	return null;//new StringGenerator(22,22).next();
  }
}
