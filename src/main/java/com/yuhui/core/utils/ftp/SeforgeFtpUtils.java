package com.yuhui.core.utils.ftp;





import java.io.FileNotFoundException;



import java.io.IOException;

import java.io.InputStream;

import java.io.OutputStream;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.ftp.FTP;

import org.apache.commons.net.ftp.FTPClient;

import org.apache.commons.net.ftp.FTPClientConfig;

import org.apache.commons.net.ftp.FTPFile;

import org.apache.commons.net.ftp.FTPReply;

/**
 * 
* @ClassName: SeforgeFtpUtils 
* @Description:  FTP 文件操作类
* @author xiexiaozhi 
* @date 2013-10-9 下午2:05:56 
*
 */
public class SeforgeFtpUtils {

	FTPClient ftp ;
	
	private String url;
	private int port;
	private String username;
	private String password;
	
	
	public SeforgeFtpUtils(String url, int port, String username,

			String password){
		
		ftp = new FTPClient();
		
		this.url = url;
		this.port = port ;
		this.username = username;
		this.password = password ;

	}
	/**
	 * 
	* @Title: connect 
	* @Description: 连接FTP
	* @param 
	* @return boolean 连接成功与否
	* @throws
	 */
	public boolean connect(){
		
		
	
		try {
				int reply;
		
				// 连接FTP服务器
		
				// 如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器
		
				ftp.connect(url, port);
		
				// 下面三行代码必须要，而且不能改变编码格式，否则不能正确下载中文文件
		
				ftp.setControlEncoding("GBK");
		
				FTPClientConfig conf = new FTPClientConfig(FTPClientConfig.SYST_NT);
		
				conf.setServerLanguageCode("zh");
		
				// 登录ftp
		
				ftp.login(username, password);
		
				// 看返回的值是不是230，如果是，表示登陆成功
		
				reply = ftp.getReplyCode();
				
				
		
				// 以2开头的返回值就会为真
		
				if (!FTPReply.isPositiveCompletion(reply)) {
		
					ftp.disconnect();
		
					System.out.println("连接服务器失败");
		
					return false;
		
				}
				
			}catch(Exception ex){
				return false ;
			}
		return true;
	}
	/**
	 * 
	* @Title: logout 
	* @Description: 退出ftp 
	* @return void    返回类型 
	* @throws
	 */
	public void logout(){
		// 退出ftp

		try {
			ftp.logout();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 
	* @Title: disconnect 
	* @Description: 断掉ftp连接 
	* @return void    返回类型 
	* @throws
	 */
	public void disconnect(){
		if (ftp.isConnected()) {

			try {

				ftp.disconnect();

			} catch (IOException ioe) {

			}

		}
	}

	/**
	 * 
	* @Title: uploadFile 
	* @Description: 上传文件 
	* @param @param path 需要被上传文件的存放路径
	* @param @param filename 上传文件的文件名
	* @param @param input  上传文件的文件流
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean uploadFile( String path, String filename, InputStream input) {

		// filename:要上传的文件

		// path :上传的路径

		// 初始表示上传失败

		boolean success = false;

		// 创建FTPClient对象

		 

		try {

			
			System.out.println("登陆服务器成功");

			//ftp.changeWorkingDirectory(path);// 转移到FTP服务器目录

			

			System.out.println("upload path:"+path);

			System.out.println(filename);
			
			

			

			String filename2 = new String(filename.getBytes("GBK"),
					"ISO-8859-1");

			String path1 = new String(path.getBytes("GBK"), "ISO-8859-1");

			// 转到指定上传目录

			ftp.changeWorkingDirectory(path1);
			long size =input.available();
			
			System.out.println("file size :"+size);
			
			FTPFile[] fs = ftp.listFiles(); // 得到目录的相应文件列表
			if(fs!= null && fs.length>0){
				for(int i=0;i<fs.length;i++){
					FTPFile f =fs[i];
					if(f.getName().equals(filename) && f.getSize() >=size ){
						System.out.println(filename+"文件没有变化，不需要上传");
						input.close();
						//success = true;
						return true;
					}
				}
			}
			
		

			// 将上传文件存储到指定目录

			// ftp.appendFile(new String(filename.getBytes("GBK"),"ISO-8859-1"),

			// input);

			ftp.setFileType(FTP.BINARY_FILE_TYPE);

			// 如果缺省该句 传输txt正常 但图片和其他格式的文件传输出现乱码

			ftp.storeFile(filename2, input);

			// 关闭输入流

			input.close();

		

			// 表示上传成功

			success = true;

			System.out.println("上传成功。。。。。。");

		} catch (IOException e) {

			e.printStackTrace();

		}

		return success;

	}

	/**
	 * 
	* @Title: deleteFile 
	* @Description: 删除FTP上的文件
	* @param @param url
	* @param @param port
	* @param @param username
	* @param @param password
	* @param @param path
	* @param @param filename
	* @param @return    设定文件 
	* @return boolean    返回类型 
	* @throws
	 */

	public boolean deleteFile(String url, int port, String username,

	String password, String path, String filename) {

		// filename:要上传的文件

		// path :上传的路径

		// 初始表示上传失败

		boolean success = false;

		// 创建FTPClient对象

		FTPClient ftp = new FTPClient();

		try {

			int reply;

			// 连接FTP服务器

			// 如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器

			ftp.connect(url, port);

			// 下面三行代码必须要，而且不能改变编码格式，否则不能正确下载中文文件

			ftp.setControlEncoding("GBK");

			FTPClientConfig conf = new FTPClientConfig(FTPClientConfig.SYST_NT);

			conf.setServerLanguageCode("zh");

			// 登录ftp

			ftp.login(username, password);

			// 看返回的值是不是230，如果是，表示登陆成功

			reply = ftp.getReplyCode();

			// 以2开头的返回值就会为真

			if (!FTPReply.isPositiveCompletion(reply)) {

				ftp.disconnect();

				System.out.println("连接服务器失败");

				return success;

			}

			System.out.println("登陆服务器成功");

			String filename2 = new String(filename.getBytes("GBK"),

			"ISO-8859-1");

			String path1 = new String(path.getBytes("GBK"), "ISO-8859-1");

			// 转到指定上传目录

			ftp.changeWorkingDirectory(path1);

			//FTPFile[] fs = ftp.listFiles(); // 得到目录的相应文件列表

			ftp.deleteFile(filename2);

			ftp.logout();

			success = true;

		} catch (IOException e) {

			System.out.println(e);

		} finally {

			if (ftp.isConnected()) {

				try {

					ftp.disconnect();

				} catch (IOException ioe) {

				}

			}

		}

		return success;

	}

	/**
	 * 
	* @Title: downFile 
	* @Description: 下载FTP上的文件 
	* @param @param ip
	* @param @param port
	* @param @param username
	* @param @param password
	* @param @param remotePath
	* @param @param fileName
	* @param @param outputStream
	* @param @param response
	* @param @return    设定文件 
	* @return boolean    返回类型 
	* @throws
	 */
	public static boolean downFile(String ip, int port, String username,

	String password, String remotePath, String fileName,

	OutputStream outputStream, HttpServletResponse response) {

		boolean success = false;

		FTPClient ftp = new FTPClient();

		try {

			int reply;

			ftp.connect(ip, port);

			// 下面三行代码必须要，而且不能改变编码格式

			ftp.setControlEncoding("GBK");

			FTPClientConfig conf = new FTPClientConfig(FTPClientConfig.SYST_NT);

			conf.setServerLanguageCode("zh");

			// 如果采用默认端口，可以使用ftp.connect(url) 的方式直接连接FTP服务器

			ftp.login(username, password);// 登录

			ftp.setFileType(FTPClient.BINARY_FILE_TYPE);

			reply = ftp.getReplyCode();

			if (!FTPReply.isPositiveCompletion(reply)) {

				ftp.disconnect();

				return success;

			}

			System.out.println("登陆成功。。。。");

			ftp.changeWorkingDirectory(remotePath);// 转移到FTP服务器目录

			FTPFile[] fs = ftp.listFiles(); // 得到目录的相应文件列表

			// System.out.println(fs.length);//打印列表长度

			for (int i = 0; i < fs.length; i++) {

				FTPFile ff = fs[i];

				if (ff.getName().equals(fileName)) {

					String filename = fileName;

					// 这个就就是弹出下载对话框的关键代码

					response.setHeader("Content-disposition",

					"attachment;filename="

					+ URLEncoder.encode(filename, "utf-8"));

					// 将文件保存到输出流outputStream中

					ftp.retrieveFile(new String(ff.getName().getBytes("GBK"),

					"ISO-8859-1"), outputStream);

					outputStream.flush();

					outputStream.close();

				}

			}

			ftp.logout();

			success = true;

		} catch (IOException e) {

			e.printStackTrace();

		} finally {

			if (ftp.isConnected()) {

				try {

					ftp.disconnect();

				} catch (IOException ioe) {

				}

			}

		}

		return success;

	}

	// 判断是否有重名方法

	public static boolean isDirExist(String fileName, FTPFile[] fs) {

		for (int i = 0; i < fs.length; i++) {

			FTPFile ff = fs[i];

			if (ff.getName().equals(fileName)) {

				return true; // 如果存在返回 正确信号

			}

		}

		return false; // 如果不存在返回错误信号

	}

	// 根据重名判断的结果 生成新的文件的名称

	public static String changeName(String filename, FTPFile[] fs) {

		int n = 0;

		// 创建一个可变的字符串对象 即StringBuffer对象，把filename值付给该对象

		StringBuffer filename1 = new StringBuffer("");

		filename1 = filename1.append(filename);

		System.out.println(filename1);

		while (isDirExist(filename1.toString(), fs)) {

			n++;

			String a = "[" + n + "]";

			System.out.println("字符串a的值是：" + a);

			int b = filename1.lastIndexOf(".");// 最后一出现小数点的位置

			int c = filename1.lastIndexOf("[");// 最后一次"["出现的位置

			if (c < 0) {

				c = b;

			}

			StringBuffer name = new StringBuffer(filename1.substring(0, c));// 文件的名字

			StringBuffer suffix = new StringBuffer(filename1.substring(b + 1));// 后缀的名称

			filename1 = name.append(a).append(".").append(suffix);

		}

		return filename1.toString();

	}

	/**
	 * 
	 * @param args
	 * 
	 * @throws FileNotFoundException
	 * 
	 *             测试程序
	 */

	public static void main(String[] args) throws FileNotFoundException {

		//String path = "";

		//File f1 = new File("C:\\新.txt");

		//String filename = f1.getName();

		//System.out.println(filename);

		// InputStream input = new FileInputStream(f1);

		// SeforgeFtpUtils a = new SeforgeFtpUtils();

		// a.uploadFile("172.25.5.193", 21, "shiyanming", "123", path, filename,
		// input);

		/*
		 * 
		 * String path ="D:\\ftpindex\\"; File f2 = new
		 * 
		 * File("D:\\ftpindex\\old.txt"); String filename2= f2.getName();
		 * 
		 * System.out.println(filename2); SeforgeFtpUtils a = new
		 * 
		 * SeforgeFtpUtils(); a.downFile("172.25.5.193", 21, "shi", "123", path,
		 * 
		 * filename2, "C:\\");
		 */

		//SeforgeFtpUtils a = new SeforgeFtpUtils();

		//a.deleteFile("192.168.0.100", 21, "shiyanming", "123", path, filename);

	}

}