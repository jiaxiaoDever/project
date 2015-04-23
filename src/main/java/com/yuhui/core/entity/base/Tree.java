package com.yuhui.core.entity.base;

import java.io.Serializable;
import java.util.List;
public interface Tree<T extends Tree<T>> extends Serializable {

	public String getId();

	public String getName();
	
	public String getParentId();

	public boolean hasChildren();

	public List<T> getChildren();
	public List<T> getAllChildren(T entity);

	public boolean getIsParent();

	public void addChild(T treeNode);

}
