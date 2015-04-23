package com.yuhui.core.utils.page;
/**
 * 
* @ClassName: Dialect 
* @Description:  分页拦截
* @author xiexiaozhi 
* @date 2013-9-13 下午4:36:53 
*
 */
public abstract class Dialect {

	  public static enum Type{  
	        MYSQL,  
	        ORACLE,
	        DB2,
	        H2,
	        SYBASE,
	        SQLSERVER,
	        SQLSERVER2005,
	        HSQL,
	        POSTGRESQL,
	        DERBY
	        
	    }  
	     /**
	      * 
	     * @Title: getLimitString 
	     * @Description: 分页语句 
	     * @param @param sql
	     * @param @param page
	     * @param @return    设定文件 
	     * @return String    返回类型 
	     * @throws
	      */
	    public abstract String getLimitString(String sql, PageParameter page); 
}
