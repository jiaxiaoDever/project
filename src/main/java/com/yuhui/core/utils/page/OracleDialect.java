package com.yuhui.core.utils.page;
/**
 * 
* @ClassName: OracleDialect 
* @Description:  oracle 分页
* @author xiexiaozhi 
* @date 2013-9-13 下午4:39:59 
*
 */
public class OracleDialect extends Dialect {

	@Override
	public String getLimitString(String sql, PageParameter page) {
		int start =(page.getCurrentPage()-1) * page.getPageSize();
		if(start < 0) start = 0;
		int end = start + page.getPageSize();
		sql = sql.trim();  
        StringBuffer pagingSelect = new StringBuffer(sql.length() + 100);  
          
        pagingSelect.append("select * from ( select row_.*, rownum rownum_ from ( ");  
          
        pagingSelect.append(sql);  
          
        pagingSelect.append(" ) row_ ) where rownum_ > ").append(start).append(" and rownum_ <= ").append(end);  
          
        System.out.println(pagingSelect.toString());
        return pagingSelect.toString(); 
		
	}

}
