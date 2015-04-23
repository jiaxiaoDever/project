package com.yuhui.core.utils;


import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@Transactional
public class JdbcTemplatePagnation {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	/**
	 * 构造 Oracle数据分页SQL
	 * @param queryString
	 * @param startIndex
	 * @param pageSize
	 * @return
	 */
    public String getOraclePageSQL(String queryString, Integer startIndex, Integer pageSize){
        if (StringUtils.isEmpty(queryString)){
            return null;
        }
        startIndex = (startIndex - 1) * pageSize;
        int endIndex = startIndex + pageSize;
        String endSql = "select * from (select rOraclePageSQL.*,ROWNUM as currentRow from (" +
                queryString + ") rOraclePageSQL where rownum <=" + endIndex + ") where currentRow>" + startIndex;
        return endSql;
    }

    /**
     * 构造数据总数查询 SQL
     * @param queryString
     * @return
     */
    public String getCountQuerySQL(String queryString){
        String sql = "";
        if (StringUtils.isNotEmpty(queryString)){
            sql = "select count(*) from (" + queryString + ") xCount";
        }
        return sql;
    }

    /**
     * 数据查询
     * @param queryString
     * @param countQueryString
     * @param startIndex
     * @param pageSize
     * @param values
     * @return
     */
//	public Page<Map<String,Object>> getPageBySQL(String queryString, String countQueryString, Pageable pages){
//		List<Map<String,Object>> items = null;
//        if (StringUtils.isEmpty(countQueryString)){
//            countQueryString = this.getCountQuerySQL(queryString);
//        }
//        String pageQueryString = queryString;
//        pageQueryString = this.getPageSQL(queryString, pages.getPageNumber(), pages.getPageSize());
//        Integer count = this.getCount(countQueryString);
//        items = jdbcTemplate.queryForList(pageQueryString);
//        
//        Page<Map<String,Object>> page = new PageImpl<Map<String,Object>>(items, pages, count);
//        return page;
//    }

    /**
     * 数据分页查询.
     * @param queryString
     * @param startIndex
     * @param pageSize
     * @return
     */
    @SuppressWarnings("unused")
	private String getPageSQL(String queryString, Integer startIndex, Integer pageSize){
        return this.getOraclePageSQL(queryString, startIndex, pageSize);
    }

    @SuppressWarnings("deprecation")
	public Integer getCount(String queryString){
        return jdbcTemplate.queryForInt(queryString);
    }


}
