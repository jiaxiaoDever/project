package com.yuhui.core.entity.base;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

/**
 * 统一定义id,state,stateDate的entity基类.
 */
@MappedSuperclass
public class StatefulTreeEntity<T extends StatefulTree<T>> extends StatefulEntity implements StatefulTree<T> {
	@Transient
	private TreeBehavior<T> treeBehavior = new TreeGenericBehavior<T>();
	@Transient
	private StatefulTreeBehavior<T> statefulTreeBehavior = new StatefulTreeGenericBehavior<T>();

	private String parentId;
	@Transient
	private boolean isParent;
	@Transient
	private List<T> children;

	private String name;

	/**
	 * 
	 */
	private static final long serialVersionUID = 8787792169518036468L;

	public void setChildren(List<T> children) {
		this.children = children;
	}

	@Override
	public List<T> getChildren() {
		return children;
	}

	public List<T> getChildren(Integer state) {
		return statefulTreeBehavior.getChildren(this, state);
	}

	public List<T> getAllChildren(T entity){
		List<T> ls = new ArrayList<T>();
		addAllChildren(entity, ls);
		return ls;
	}
	
	protected void addAllChildren(T entity,List<T> ls){
		List<T> tls = entity.getChildren();
		if(tls != null && tls.size() > 0){
			ls.addAll(tls);
			for(T en:tls){
				addAllChildren(en, ls);
			}
		}
	}
	
	@Override
	public boolean hasChildren() {
		return treeBehavior.hasChildren(this);
	}

	@Override
	public boolean hasChildren(Integer state) {
		return statefulTreeBehavior.hasChildren(this, state);
	}

	@Override
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	@Override
	public boolean getIsParent() {
		return this.isParent;
	}

	public void setIsParent(boolean isParent) {
		this.isParent = isParent;
	}

	@Override
	public void addChild(T treeNode) {
		if (this.children == null) {
			this.children = new ArrayList<T>();
		}
		this.children.add(treeNode);
	}

}
