package com.yuhui.core.entity.base;

import java.io.Serializable;
import java.util.List;

public interface StatefulTreeBehavior<T extends StatefulTree<T>> extends Serializable {

	public boolean hasChildren(StatefulTree<T> tree, Integer state);

	public List<T> getChildren(StatefulTree<T> tree, Integer state);

	public List<T> getChildren(StatefulTree<T> tree, Integer state, boolean isRecursive);

}
