package com.yuhui.core.utils;

import java.util.Map;

import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.utils.TreeUtils.TreeIniter;

public class OrgTreeIniter implements TreeIniter<Organization> {

	@SuppressWarnings("unused")
	private Map<String, Organization> mapTree = null;
	public OrgTreeIniter() {
	}

	@Override
	public void set(Organization treeNode) {
	}

	@Override
	public void setTreeMap(Map<String, Organization> mapTree) {
		this.mapTree = mapTree;
	}

	public OrgTreeIniter(Map<String, Organization> mapTree) {
		super();
		this.mapTree = mapTree;
	}

}
