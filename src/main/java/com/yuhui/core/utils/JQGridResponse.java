package com.yuhui.core.utils;

import java.util.List;
import java.util.Map;

/**
 * jqgrid 返回json对象
 * @author ztq
 *
 */
public class JQGridResponse {  
    private int total; //total pages  
    private int page; //current page  
    private int records; //total records  
    private List<Map<String, Object>> rows;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRecords() {
		return records;
	}
	public void setRecords(int records) {
		this.records = records;
	}
	public List<Map<String, Object>> getRows() {
		return rows;
	}
	public void setRows(List<Map<String, Object>> rows) {
		this.rows = rows;
	}  
}
