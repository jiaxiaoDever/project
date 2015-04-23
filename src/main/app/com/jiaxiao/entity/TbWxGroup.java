package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tb_wx_group database table.
 * 
 */
@Entity
@Table(name="tb_wx_group")
public class TbWxGroup implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="WXGROUP_ID")
	private String wxgroupId;

	private String common;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	@Column(name="GROUP_ID")
	private String groupId;

	@Column(name="GROUP_NAME")
	private String groupName;

	@Column(name="JX_PUBLIC_ID")
	private String jxPublicId;

	@Column(name="MEMBER_NUM")
	private Integer memberNum;

	@Column(name="PUBLIC_ID")
	private String publicId;

	@Column(name="PUBLIC_NAME")
	private String publicName;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="REMOVE_DATE")
	private Date removeDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="SYN_DATE")
	private Date synDate;

	public TbWxGroup() {
	}

	public String getWxgroupId() {
		return this.wxgroupId;
	}

	public void setWxgroupId(String wxgroupId) {
		this.wxgroupId = wxgroupId;
	}

	public String getCommon() {
		return this.common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getEditDate() {
		return this.editDate;
	}

	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}

	public String getGroupId() {
		return this.groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return this.groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getJxPublicId() {
		return this.jxPublicId;
	}

	public void setJxPublicId(String jxPublicId) {
		this.jxPublicId = jxPublicId;
	}

	public Integer getMemberNum() {
		return this.memberNum;
	}

	public void setMemberNum(Integer memberNum) {
		this.memberNum = memberNum;
	}

	public String getPublicId() {
		return this.publicId;
	}

	public void setPublicId(String publicId) {
		this.publicId = publicId;
	}

	public String getPublicName() {
		return this.publicName;
	}

	public void setPublicName(String publicName) {
		this.publicName = publicName;
	}

	public Date getRemoveDate() {
		return this.removeDate;
	}

	public void setRemoveDate(Date removeDate) {
		this.removeDate = removeDate;
	}

	public Date getSynDate() {
		return this.synDate;
	}

	public void setSynDate(Date synDate) {
		this.synDate = synDate;
	}

}