package com.yuhui.core.utils;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 
* @ClassName: H2Server 
* @Description:  h2数据库启动服务器类,服务器启动，则数据库也启动
* @author xiexiaozhi 
* @date 2013-10-17 上午11:37:24 
*
 */
public class H2Server implements ServletContextListener{
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	
	ServletContext context;
	 
	@SuppressWarnings("unused")
	public void start() {
		
		//测试db服务器是否启动
		boolean run = this.isRun();
		
		if(!run){
			//获取数据库服务器启动路径
			File f = new File(Thread.currentThread().getContextClassLoader().getResource("").getPath());
			String root = f.getParentFile().getParent();
			String h2serverPath= root+File.separator+"database"+
					File.separator+"h2"+File.separator+"bin"+File.separator;
			System.out.println(h2serverPath);
			
			String dist = "";
			
			//获取操作系统类型
			String sys = System.getProperty("os.name");
			sys = sys.toLowerCase();
			if(sys.indexOf("windows")!= -1){
				dist = "cmd /c java -jar "+h2serverPath+"h2-1.3.173.jar";
			}else {
				dist = h2serverPath+"h2.sh";
			}
			
			//启动服务器
			try {
				System.out.println("正在启动h2..."); 
				Process child = Runtime.getRuntime().exec(dist);
				System.out.println("启动h2成功");
				//this.test();
			} catch (IOException e) {
				 System.out.println("启动h2出错：" + e.toString());   
	             
		            e.printStackTrace();   
		            throw new RuntimeException(e); 
			}
			
			
			

		}
		
		
         
    }  
	
	public void stop() {   
         
    }
	
	public boolean isRun(){
		boolean f = false ;
		try {
			Class.forName("org.h2.Driver");
			 Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/baseframe" ,   
		                "sa", "sa");   
		         
	            conn.close(); 
	           f = true ;
		} catch (ClassNotFoundException e) {
			
			//e.printStackTrace();
			//System.out.println("H2驱动未找到......");
			f = false ;
		} catch (SQLException e) {
			
			//e.printStackTrace();
			//System.out.println("H2数据库未启动......");
			f = false ;
		} 
		
		return f;
	}
	
	
	public void test(){
		try {
			Class.forName("org.h2.Driver");
			 Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/~/baseframe" ,   
		                "sa", "sa");   
		        Statement stat = conn.createStatement();  
		        //stat.execute("CREATE TABLE TEST(NAME VARCHAR)");   
	            //stat.execute("INSERT INTO TEST VALUES('Hello World')");   
		        ResultSet result = stat.executeQuery("SELECT NAME FROM TEST ");   
	            int i = 1;   
	            while (result.next()) {   
	                System.out.println(i++ + ":" + result.getString("NAME"));   
	            }   
	            result.close();   
	            stat.close();   
	            conn.close();   
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args){
		
		try {
			org.h2.tools.Server.shutdownTcpServer("tcp://localhost:9092", null, false, false);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}

	
	public void contextDestroyed(ServletContextEvent arg0) {
		this.context = null ;
		
	}

	public void contextInitialized(ServletContextEvent arg0) {
		this.context = arg0.getServletContext(); 
		this.start();
		
	}
}
