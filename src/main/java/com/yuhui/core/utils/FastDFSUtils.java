package com.yuhui.core.utils;



import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;

import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient;

/**
 * 
* @ClassName: FastDFSUtils 
* @Description:  FastDFS文件操作类
* @author xiexiaozhi 
* @date 2013-10-17 上午11:39:07 
*
 */
public class FastDFSUtils {

	private StorageClient storageClient;
	
	public FastDFSUtils(){
		try {
			ClientGlobal.init(configPath());
			storageClient = new StorageClient(null, null);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 文件上传
	 * @param b 文件流
	 * @param fileExt 文件后缀
	 * @return 存储的group,filename
	 */
	public String[] upload(byte[] b,String fileExt){
		String[] results = null;
		try {
			results = storageClient.upload_file(b, fileExt, null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return results;
	}
	
	/**
	 * 文件下载
	 * @param group 组名
	 * @param filename 文件名称
	 * @return 文件的二进制流
	 */
	public byte[] download(String group,String filename){
		byte[] b = null;
		try {
			b = storageClient.download_file(group, filename);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	
	/**
	 * 删除文件
	 * @param group 组名
	 * @param filename 文件名
	 * @return 是否成功
	 */
	public boolean delete(String group,String filename){
		int i = 1;
		try {
			i = storageClient.delete_file(group, filename);   
		} catch (Exception e) {
			e.printStackTrace();
		}
		return i == 0;
	}
	
	/**
	 * 获得配置文件路径
	 * @return 配置文件路径
	 */
	private String configPath(){
		try {
			return FastDFSUtils.class.getResource("/").toURI().getPath()+"fdfs_client.conf";
		} catch (URISyntaxException e) {
			e.printStackTrace();
			return "";
		}  
	}
	
	public static void main(String[] args){
		FastDFSUtils f = new FastDFSUtils();
		byte[] b = f.download("group1", "M00/00/00/wKgBB1IW2l7wdoK-AAAIyrpGf408.jrxml");
		System.out.println(b.length);
		try {
			System.out.println(new String(b,"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
