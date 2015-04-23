package com.yuhui.core.utils.ftp;

import java.text.SimpleDateFormat;
import java.util.Date;

public class UploadThread implements Runnable{

	@SuppressWarnings("unused")
	private String uploadDate ="";//0点过后的当天第一次传，可能会有漏掉了昨天最后一次记录
	
	public UploadLogFileService ulf;
	
	public UploadThread(UploadLogFileService ulf){
		this.ulf = ulf;
		uploadDate = getNowTime();
	}
	
	@Override
	public void run() {
		if(ulf.connectFtp()){
			System.out.println("开始上传日志文件");
			String logFileNameHead = ulf.getLogFileNameHead();
			String dateStr = getNowTime();
			
			
			//info log file
			ulf.upload(logFileNameHead+"-"+"info-"+dateStr+".log");
			//error log file
			ulf.upload(logFileNameHead+"-"+"error-"+dateStr+".log");
			System.out.println("上传日志文件结束");
			
			ulf.logoutFtp();
			ulf.disconnect();
		}else{
			System.out.println("无法连接到FTP服务器");
		}
		
	}
	
	public static String getNowTime(){
		Date   now   =   new   Date();      
	    SimpleDateFormat   dateFormat   =   new   SimpleDateFormat("yyyy-MM-dd");
	    String str =dateFormat.format(now);
	    
	    
	    return str ;
	    
	}

}
