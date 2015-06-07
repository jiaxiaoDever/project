package com.yuhui.core.utils.ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.util.Properties;

import javax.xml.parsers.*;
import org.xml.sax.SAXException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * 
* @ClassName: UploadLogFileService 
* @Description:  上传日志文件服务
* @author xiexiaozhi 
* @date 2013-10-16 上午11:05:30 
*
 */
public class UploadLogFileService {

	public  SeforgeFtpUtils ftp = null;
	private String ftpHost;
	private int ftpPort;
	private String ftpUser;
	private String ftpPwd;
	private String localLogPath;
	
	private String logFileNameHead ;
	
	/**
	 * 
	* <p>Title: </p> 
	* <p>Description:构造函数，读取配置信息 </p>
	 */
	public UploadLogFileService(){
		InputStream in = null;
		try {
			String s =UploadLogFileService.class.getResource("/").toURI().getPath()+"application.properties";
			String xml =UploadLogFileService.class.getResource("/").toURI().getPath()+"logback.xml";
			Properties prop = new Properties();
			in =  new FileInputStream(s);
			prop.load(in);
			 ftpHost = prop.getProperty("ftpHost");
			 ftpPort = Integer.parseInt(prop.getProperty("ftpPort"));
			 ftpUser = prop.getProperty("ftpUser");
			 ftpPwd = prop.getProperty("ftpPassword");
			
			
			ftp = new SeforgeFtpUtils(ftpHost, ftpPort, ftpUser, ftpPwd);
			
			//解析logback.xml文件配置
			parsersXml(xml);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (URISyntaxException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 
	* @Title: upload 
	* @Description: 上传
	* @return void    返回类型 
	* @throws
	 */
	public void upload(String logFileName){
		
		
		InputStream input =null;
		try {
			input = new FileInputStream(new File(localLogPath+logFileName));
			
		} catch (FileNotFoundException e) {
			System.out.println("无法找到日志文件："+localLogPath+logFileName);
		}
		if(input!=null)
			ftp.uploadFile( "", logFileName, input);//第一个参数“”表示在根目录下
		
	}
	public void logoutFtp(){
		ftp.logout();
	}
	public void disconnect(){
		ftp.disconnect();
	}
	
	public boolean connectFtp(){
		return ftp.connect();
	}
	
	public String getLogFileNameHead(){
		return logFileNameHead;
	}
	
	public void parsersXml(String xml) {
		         //实例化一个文档构建器工厂
		         DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		         try {
		             //通过文档构建器工厂获取一个文档构建器
		             DocumentBuilder db = dbf.newDocumentBuilder();
		             //通过文档通过文档构建器构建一个文档实例
		             Document doc = db.parse(xml);
		             //获取所有名字为 “person” 的节点
		            NodeList list = doc.getElementsByTagName("property");
		            Element ip_element = (Element)list.item(0);
		            Element dir_element = (Element)list.item(1);
		            logFileNameHead =ip_element.getAttribute("value");
		            localLogPath  = dir_element.getAttribute("value");
		            
		        } catch (ParserConfigurationException ex) {
		            ex.printStackTrace();
		         } catch (IOException ex) {
		            ex.printStackTrace();
		         } catch (SAXException ex) {
		             ex.printStackTrace();
		         }
		    }
	
}
