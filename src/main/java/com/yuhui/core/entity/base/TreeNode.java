package com.yuhui.core.entity.base;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

/**
 * zTree的TreeNode类
 * 
 * @author zhangy
 * 
 * @param <T>
 *            主键类型
 */
@MappedSuperclass
public class TreeNode<T> {
	private T id;
	private Integer level;
	private String name;
	private T pId;
	private boolean isParent;
	private boolean expanded;
	private boolean inner;
	private List<? super TreeNode<T>> children;

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(boolean isParent) {
		this.isParent = isParent;
	}

	public boolean getExpanded() {
		return expanded;
	}

	public void setExpanded(boolean expanded) {
		this.expanded = expanded;
	}

	@Id
	public T getId() {
		return id;
	}

	public void setId(T id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public T getpId() {
		return pId;
	}

	public void setpId(T pId) {
		this.pId = pId;
	}

	public boolean isInner() {
		return inner;
	}

	public void setInner(boolean inner) {
		this.inner = inner;
	}

	public List<? super TreeNode<T>> getChildren() {
		return children;
	}

	public void setChildren(List<? super TreeNode<T>> children) {
		this.children = children;
	}

	public void addChild(TreeNode<T> treeNode) {
		if (this.children == null) {
			this.children = new ArrayList<TreeNode<T>>();
		}
		this.children.add(treeNode);
	}
}
