package com.yuhui.core.utils;

import java.util.Map;

import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.utils.TreeUtils.TreeIniter;

public class ResourceTreeIniter implements TreeIniter<ResourceBase> {
	private Map<String, ResourceBase> mapTree = null;

	@Override
	public void set(ResourceBase treeNode) {
		setlocal(treeNode);
		setHost(treeNode);
		setPort(treeNode);
		setContext(treeNode);
	}

	private void setlocal(ResourceBase treeNode) {
		if (treeNode.getLocal() != null || !mapTree.containsKey(treeNode.getParentId()))
			return;
		ResourceBase parent = mapTree.get(treeNode.getParentId());
		if (parent.getLocal() == null) {
			setlocal(parent);
		} else {
			treeNode.setLocal(parent.getLocal());
		}
	}

	private void setHost(ResourceBase treeNode) {
		if (treeNode.getHost() != null || !mapTree.containsKey(treeNode.getParentId()))
			return;
		ResourceBase parent = mapTree.get(treeNode.getParentId());
		if (parent.getHost() == null) {
			setHost(parent);
		} else {
			//treeNode.setHost(parent.getHost());
			treeNode.setHost("192.168.1.197");
		}
	}

	private void setPort(ResourceBase treeNode) {
		if (treeNode.getPort() != null || !mapTree.containsKey(treeNode.getParentId()))
			return;
		ResourceBase parent = mapTree.get(treeNode.getParentId());
		if (parent.getPort() == null) {
			setPort(parent);
		} else {
			//treeNode.setPort(parent.getPort());
			treeNode.setPort("8088");
		}
	}

	private void setContext(ResourceBase treeNode) {
		if (treeNode.getContext() != null || !mapTree.containsKey(treeNode.getParentId()))
			return;
		ResourceBase parent = mapTree.get(treeNode.getParentId());
		if (parent.getContext() == null) {
			setContext(parent);
		} else {
			treeNode.setContext(parent.getContext());
		}
	}

	@Override
	public void setTreeMap(Map<String, ResourceBase> mapTree) {
		this.mapTree = mapTree;
	}
}
