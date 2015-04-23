package com.yuhui.core.entity.base;

import org.apache.commons.collections.CollectionUtils;

public class TreeGenericBehavior<T extends Tree<T>> implements TreeBehavior<T> {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public boolean hasChildren(Tree<T> tree) {
		return CollectionUtils.isNotEmpty(tree.getChildren());
	}

}
