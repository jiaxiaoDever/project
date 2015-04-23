package com.yuhui.core.utils;

import java.util.Map;

import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.utils.TreeUtils.TreeIniter;

public class MenuTreeIniter implements TreeIniter<MenuBase> {
	@SuppressWarnings("unused")
	private Map<String, MenuBase> mapTree = null;
	private Map<String, ResourceBase> resMapTree = null;

	public MenuTreeIniter(Map<String, ResourceBase> resMapTree) {
		this.resMapTree = resMapTree;
	}

	@Override
	public void set(MenuBase treeNode) {
		setLink(treeNode);
	}

	private void setLink(MenuBase treeNode) {
		String rid = treeNode.getResourceId();
		if (rid != null && resMapTree.containsKey(rid)) {
			treeNode.setLink(getLink(resMapTree.get(rid)));
		}
	}

	private String getLink(ResourceBase resourceBase) {
		StringBuilder sb = new StringBuilder();
		if (resourceBase.getLocal() != null && !resourceBase.getLocal().equals("")) {
			sb.append(resourceBase.getLocal()).append("://");
		}
//		sb.append("localhost:8090");
		if (resourceBase.getHost() != null && !resourceBase.getHost().equals("")) {
			//sb.append(resourceBase.getHost());
			sb.append("192.168.1.197");//此处为自定义访问地址
		}
		if (resourceBase.getPort() != null && !resourceBase.getPort().equals("")) {
			//sb.append(":").append(resourceBase.getPort());
			String port = "8088";
			if("saiku".equals(resourceBase.getContext())) port = "8080";
			sb.append(":").append(port);//此处为自定义访问端口
		}
		if (resourceBase.getContext() != null && !resourceBase.getContext().equals("")) {
			sb.append("/").append(resourceBase.getContext());
		}
		if (resourceBase.getPath() != null && !resourceBase.getPath().equals("")) {
			sb.append("/").append(resourceBase.getPath());
		}
		return sb.toString();
	}

	@Override
	public void setTreeMap(Map<String, MenuBase> mapTree) {
		this.mapTree = mapTree;
	}
}
