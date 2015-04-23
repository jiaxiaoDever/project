package com.yuhui.core.web.report;

import com.yuhui.core.entity.report.Report;
/**
 * 
* @ClassName: ReportTreeNode 
* @Description:  报表树节点
* @author xiexiaozhi 
* @date 2013-12-5 下午5:01:23 
*
 */
public class ReportTreeNode {

	//id
	private String id;
	
	//父id
	private String parentId;
	
	//名称
	private String name;
	
	//是否叶子
	private boolean isParent;
	
	private String privilege;
	
	public String getPrivilege() {
		return privilege;
	}

	public void setPrivilege(String privilege) {
		this.privilege = privilege;
	}

	//自定义的属性，只有是叶子节点时有数据，目录为null
	private Report dataAttr;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(boolean isParent) {
		this.isParent = isParent;
	}

	public Report getDataAttr() {
		return dataAttr;
	}

	public void setDataAttr(Report dataAttr) {
		this.dataAttr = dataAttr;
	}
	
	
	
	
}
