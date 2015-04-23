package com.yuhui.core.utils;

import java.util.Map;

import com.yuhui.core.entity.content.ContentTypeBase;
import com.yuhui.core.utils.TreeUtils.TreeIniter;

public class ContentTypeTreeIniter implements TreeIniter<ContentTypeBase> {
	@SuppressWarnings("unused")
	private Map<String, ContentTypeBase> mapTree = null;

	public ContentTypeTreeIniter() {
	}

	@Override
	public void set(ContentTypeBase treeNode) {
	}

	@Override
	public void setTreeMap(Map<String, ContentTypeBase> mapTree) {
		this.mapTree = mapTree;
	}
}
