package com.yuhui.core.utils.page;
/**
 * 
* @ClassName: H2Dialect 
* @Description:  h2 分页
* @author xiexiaozhi 
* @date 2013-9-13 下午4:38:47 
*
 */
public class H2Dialect extends Dialect {

	@Override
	public String getLimitString(String sql, PageParameter page) {
		int offset = (page.getCurrentPage()-1)*page.getPageSize();
		int limit = page.getPageSize();
		return new StringBuffer(sql.length() + 50).
	            append(sql).
	            append(offset>0 ? " limit "+limit+" offset "+offset : " limit "+limit).
	            toString();
	}

}
