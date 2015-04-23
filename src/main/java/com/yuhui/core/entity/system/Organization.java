package com.yuhui.core.entity.system;

import java.util.ArrayList;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.StatefulTree;
import com.yuhui.core.entity.base.StatefulTreeEntity;
import com.yuhui.core.repository.mybatis.OrderBy;

@Entity
@Table(name = "tb_sys_organization")
@OrderBy(value = "org_level")
public class Organization extends StatefulTreeEntity<Organization> implements StatefulTree<Organization> {

	private static final long serialVersionUID = 1L;

	/** 机构类型 */
	private String orgType;

	/** 机构等级 */
	private String orgLevel;

	/** 分公司编码 */
	private String corpCode;

	/** 描述 */
	private String description;

	private String substCode;

	private String branchCode;

	private String crmSubstCode;

	private String crmBranchCode;

	private Integer orgOrder;

	public String getCrmSubstCode() {
		return crmSubstCode;
	}

	public void setCrmSubstCode(String crmSubstCode) {
		this.crmSubstCode = crmSubstCode;
	}

	public String getCrmBranchCode() {
		return crmBranchCode;
	}

	public void setCrmBranchCode(String crmBranchCode) {
		this.crmBranchCode = crmBranchCode;
	}

	public String getOrgLevel() {
		return orgLevel;
	}

	public void setOrgLevel(String orgLevel) {
		this.orgLevel = orgLevel;
	}

	public String getCorpCode() {
		return corpCode;
	}

	public void setCorpCode(String corpCode) {
		this.corpCode = corpCode;
	}

	public String getOrgType() {
		return orgType;
	}

	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean hasChildren() {
		return false;
	}

	public String getSubstCode() {
		return substCode;
	}

	public void setSubstCode(String substCode) {
		this.substCode = substCode;
	}

	public String getBranchCode() {
		return branchCode;
	}

	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}


	public Integer getOrgOrder() {
		return orgOrder;
	}

	public void setOrgOrder(Integer orgOrder) {
		this.orgOrder = orgOrder;
	}

	@Override
	public void addChild(Organization treeNode) {
		if (this.getChildren() == null) {
			this.setChildren(new ArrayList<Organization>());
		}
		this.getChildren().add(treeNode);
	}

}
