package com.yuhui.core.entity.base;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

public class StatefulTreeGenericBehavior<T extends StatefulTree<T>> implements StatefulTreeBehavior<T>, Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public boolean hasChildren(StatefulTree<T> tree, Integer state) {
		return CollectionUtils.isNotEmpty(getChildren(tree, state, false));
	}

	public List<T> getChildren(StatefulTree<T> tree, Integer state) {
		return getChildren(tree, state, false);
	}

	public List<T> getChildren(StatefulTree<T> tree, Integer state, boolean isRecursive) {
		List<T> list = new ArrayList<T>();
		if (CollectionUtils.isNotEmpty(tree.getChildren())) {
			Iterator<T> it = tree.getChildren().iterator();
			while (it.hasNext()) {
				T t = it.next();
				if (t.getState() == state) {
					list.add(t);
					if (isRecursive) {
						getChildren(t, state, isRecursive);
					}
				}
			}
		}
		return list;
	}

}
