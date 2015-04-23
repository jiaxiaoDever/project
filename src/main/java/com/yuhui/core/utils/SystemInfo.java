package com.yuhui.core.utils;
/**
 * 
* @ClassName: SystemInfo 
* @Description:  系统的信息
* @author xiexiaozhi 
* @date 2013-10-24 下午2:00:26 
*
 */
public class SystemInfo {

	/**
	 * 不需要记录日志的url 正则表达式
	 */
	private String noLogUrlRegx;
	
	/**
	 * 数据库SCHEMA
	 */
	private String schema;
	
	/**
	 * 数据库类型
	 */
	private String dialect;
	
	/**
	 * cas路径
	 */
	private String casUrl;
	/**
	 * shiro认证客户端路径
	 */
	private String clientServiceUrl;
	
	private String rptFlatUrl ;
	
	private String rptIrpUrl;
	
	private String rptAhocUrl;
	
	private String rptOlapUrl;
	
	
	

	public String getRptFlatUrl() {
		return rptFlatUrl;
	}

	public void setRptFlatUrl(String rptFlatUrl) {
		this.rptFlatUrl = rptFlatUrl;
	}

	public String getRptIrpUrl() {
		return rptIrpUrl;
	}

	public void setRptIrpUrl(String rptIrpUrl) {
		this.rptIrpUrl = rptIrpUrl;
	}

	public String getRptAhocUrl() {
		return rptAhocUrl;
	}

	public void setRptAhocUrl(String rptAhocUrl) {
		this.rptAhocUrl = rptAhocUrl;
	}

	public String getRptOlapUrl() {
		return rptOlapUrl;
	}

	public void setRptOlapUrl(String rptOlapUrl) {
		this.rptOlapUrl = rptOlapUrl;
	}

	public String getDialect() {
		return dialect;
	}

	public void setDialect(String dialect) {
		this.dialect = dialect;
	}

	public String getNoLogUrlRegx() {
		return noLogUrlRegx;
	}

	public void setNoLogUrlRegx(String noLogUrlRegx) {
		this.noLogUrlRegx = noLogUrlRegx;
	}

	public String getSchema() {
		return schema;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}

	public String getCasUrl() {
		return casUrl;
	}

	public void setCasUrl(String casUrl) {
		this.casUrl = casUrl;
	}

	public String getClientServiceUrl() {
		return clientServiceUrl;
	}

	public void setClientServiceUrl(String clientServiceUrl) {
		this.clientServiceUrl = clientServiceUrl;
	}
	
	
	
}
