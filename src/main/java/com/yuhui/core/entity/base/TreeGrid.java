package com.yuhui.core.entity.base;

/**
 * jqGrid的类
 * 
 * @author zhangy
 * 
 * @param <T>
 *            主键类型
 */
public class TreeGrid<T> {
	private T id;
	private Integer level;
	private T parentId;
	private boolean isLeaf;
	private boolean expanded;

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public T getParentId() {
		return parentId;
	}

	public void setParentId(T parentId) {
		this.parentId = parentId;
	}

	public boolean isLeaf() {
		return isLeaf;
	}

	public void setLeaf(boolean isLeaf) {
		this.isLeaf = isLeaf;
	}

	public boolean isExpanded() {
		return expanded;
	}

	public void setExpanded(boolean expanded) {
		this.expanded = expanded;
	}

	public T getId() {
		return id;
	}

	public void setId(T id) {
		this.id = id;
	}

}
