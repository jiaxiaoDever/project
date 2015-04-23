package com.yuhui.core.entity.base;

import java.util.List;

public class JQPage<T> {
	/**
	 * 当前页码
	 */
	private int page;
	/**
	 * 数据总数
	 */
	private int records;
	/**
	 * 页码总数
	 */
	private int total;
	/**
	 * 实际模型数据的入口
	 */
	private List<T> rows;

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

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

}
