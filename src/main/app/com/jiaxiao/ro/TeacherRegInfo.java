package com.jiaxiao.ro;

import java.io.Serializable;
import java.util.List;

import com.jiaxiao.entity.TbBranchesJx;
import com.jiaxiao.entity.TbSysData;

public class TeacherRegInfo implements Serializable  {

	/** */
	private static final long serialVersionUID = 7613567119340722446L;
	/** 驾校编号*/
	private String jxId;
	/** 驾校名称*/
	private String jxName;
	/** 网点信息*/
	private List<TbBranchesJx> branches;
	/** 准教车型(数据字典对象)*/
	private List<TbSysData> teaCarTypes;
	/** 训练车型(数据字典对象)*/
	private List<TbSysData> carTypes;
	public String getJxId() {
		return jxId;
	}
	public void setJxId(String jxId) {
		this.jxId = jxId;
	}
	public String getJxName() {
		return jxName;
	}
	public void setJxName(String jxName) {
		this.jxName = jxName;
	}
	public List<TbBranchesJx> getBranches() {
		return branches;
	}
	public void setBranches(List<TbBranchesJx> branches) {
		this.branches = branches;
	}
	public List<TbSysData> getTeaCarTypes() {
		return teaCarTypes;
	}
	public void setTeaCarTypes(List<TbSysData> teaCarTypes) {
		this.teaCarTypes = teaCarTypes;
	}
	public List<TbSysData> getCarTypes() {
		return carTypes;
	}
	public void setCarTypes(List<TbSysData> carTypes) {
		this.carTypes = carTypes;
	}
	public TeacherRegInfo(String jxId, String jxName,
			List<TbBranchesJx> branches, List<TbSysData> teaCarTypes,
			List<TbSysData> carTypes) {
		super();
		this.jxId = jxId;
		this.jxName = jxName;
		this.branches = branches;
		this.teaCarTypes = teaCarTypes;
		this.carTypes = carTypes;
	}
	public TeacherRegInfo() {
		super();
	}
	
}
