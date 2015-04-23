package com.yuhui.core.utils.page;
/**
 * 
* @ClassName: MySqlDialect 
* @Description:  mysql 分页
* @author xiexiaozhi 
* @date 2013-9-13 下午4:39:38 
*
 */
public class MySqlDialect extends Dialect {

	@Override
	public String getLimitString(String sql, PageParameter page) {
		int offset = (page.getCurrentPage()-1)*page.getPageSize();
		int limit = page.getPageSize();
		return new StringBuffer(sql.length() + 50).
	            append(sql).
	            append(offset>0 ? " limit "+offset+" , "+limit : " limit "+limit).
	            toString();
	}

}
