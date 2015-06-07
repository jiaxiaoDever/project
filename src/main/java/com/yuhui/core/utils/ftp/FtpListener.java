package com.yuhui.core.utils.ftp;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.util.Properties;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;


/**
 * 
* @ClassName: FtpListener 
* @Description:  spring 实例化该类时，启动线程池执行定时push 日志文件任务
* @author xiexiaozhi 
* @date 2013-10-16 上午10:57:47 
*
 */
public class FtpListener {

	
	public void start(){
		System.out.println("启动线程池");
		ScheduledThreadPoolExecutor pool = new ScheduledThreadPoolExecutor(2);
		//实例化线程
		UploadThread ut = new UploadThread(new UploadLogFileService());
		
		int interval =20;
		
		try{
			interval = Integer.parseInt(getInterval());
		}catch(Exception ex){
			
		}
		
		pool.scheduleWithFixedDelay(ut, 0, interval, TimeUnit.SECONDS);
	}
	
	private static String getInterval(){
 		String interval_str ="";
 		InputStream in = null;
		try {
			String s =UploadLogFileService.class.getResource("/").toURI().getPath()+"application.properties";
			Properties prop = new Properties();
			in =  new FileInputStream(s);
			prop.load(in);
			interval_str = prop.getProperty("upload_interval");
			 
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}catch (URISyntaxException e) {
			e.printStackTrace();
		}finally{
			try {
				in.close();
			} catch (IOException e) {
				
			}
		}
		
		return interval_str ;
 	}

}
