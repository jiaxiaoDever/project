package com.yuhui.core.entity.base;

import java.util.List;
public interface StatefulTree<T extends StatefulTree<T>> extends Tree<T> {

	public Integer getState();

	public boolean hasChildren(Integer state);

	public List<T> getChildren(Integer state);

}
