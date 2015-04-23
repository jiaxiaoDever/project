package com.yuhui.core.entity.base;

import java.io.Serializable;

public interface TreeBehavior<T extends Tree<T>> extends Serializable {

	public boolean hasChildren(Tree<T> tree);

}
