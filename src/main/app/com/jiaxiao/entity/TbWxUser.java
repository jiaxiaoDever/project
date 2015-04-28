package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 微信用户信息
 */
@Entity
@Table(name="tb_wx_user")
public class TbWxUser implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 用户编号*/
	@Id
	@Column(name="USER_ID")
	private String userId;

	/** 网点编号*/
	@Column(name="BRANCH_ID")
	private String branchId;

	/** 关注时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CONTACT_DATE")
	private Date contactDate;

	/** 国籍*/
	private String country;

	/** 所在分组编号*/
	@Column(name="GROUP_ID")
	private String groupId;

	/** 所在分组名称*/
	@Column(name="GROUP_NAME")
	private String groupName;

	/** 是否绑定*/
	@Column(name="IS_BINDED")
	private Integer isBinded;

	/** 是否关注*/
	@Column(name="IS_CONTACT")
	private Integer isContact;

	/** 是否在线*/
	@Column(name="IS_ONLINE")
	private Integer isOnline;

	/** 所属驾校*/
	@Column(name="JX_ID")
	private String jxId;

	/** 关注驾校公众号编号*/
	@Column(name="JX_PUBLIC_ID")
	private String jxPublicId;

	/** 关注驾校公众号名称*/
	@Column(name="JX_PUBLIC_NAME")
	private String jxPublicName;

	/** 微信OPENID*/
	@Column(name="OPEN_ID")
	private String openId;

	/** 微信账号*/
	@Column(name="OPEN_ZH")
	private String openZh;

	/** 所在省*/
	private String province;

	/** 角色编码*/
	@Column(name="ROLE_CODE")
	private String roleCode;

	/** 角色名称*/
	@Column(name="ROLE_NAME")
	private String roleName;

	/** 性别*/
	private Integer sex;

	/** 城市*/
	private String sity;

	/** 绑定学院编号*/
	@Column(name="STUDENT_ID")
	private String studentId;

	/** 绑定教练编号*/
	@Column(name="TEACHER_ID")
	private String teacherId;

	/** 取消关注时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="UNCONTACT_DATE")
	private Date uncontactDate;

	/** 绑定微信唯一编号*/
	@Column(name="UNION_ID")
	private String unionId;

	/** 头像*/
	@Column(name="USER_LOGO")
	private String userLogo;

	/** 昵称*/
	@Column(name="USER_NAME")
	private String userName;

	/** 所在分组编号*/
	@Column(name="WXGROUP_ID")
	private String wxgroupId;

	public TbWxUser() {
	}

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBranchId() {
		return this.branchId;
	}

	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}

	public Date getContactDate() {
		return this.contactDate;
	}

	public void setContactDate(Date contactDate) {
		this.contactDate = contactDate;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
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

	public Integer getIsBinded() {
		return this.isBinded;
	}

	public void setIsBinded(Integer isBinded) {
		this.isBinded = isBinded;
	}

	public Integer getIsContact() {
		return this.isContact;
	}

	public void setIsContact(Integer isContact) {
		this.isContact = isContact;
	}

	public Integer getIsOnline() {
		return this.isOnline;
	}

	public void setIsOnline(Integer isOnline) {
		this.isOnline = isOnline;
	}

	public String getJxId() {
		return this.jxId;
	}

	public void setJxId(String jxId) {
		this.jxId = jxId;
	}

	public String getJxPublicId() {
		return this.jxPublicId;
	}

	public void setJxPublicId(String jxPublicId) {
		this.jxPublicId = jxPublicId;
	}

	public String getJxPublicName() {
		return this.jxPublicName;
	}

	public void setJxPublicName(String jxPublicName) {
		this.jxPublicName = jxPublicName;
	}

	public String getOpenId() {
		return this.openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getOpenZh() {
		return this.openZh;
	}

	public void setOpenZh(String openZh) {
		this.openZh = openZh;
	}

	public String getProvince() {
		return this.province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getRoleCode() {
		return this.roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getSity() {
		return this.sity;
	}

	public void setSity(String sity) {
		this.sity = sity;
	}

	public String getStudentId() {
		return this.studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getTeacherId() {
		return this.teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	public Date getUncontactDate() {
		return this.uncontactDate;
	}

	public void setUncontactDate(Date uncontactDate) {
		this.uncontactDate = uncontactDate;
	}

	public String getUnionId() {
		return this.unionId;
	}

	public void setUnionId(String unionId) {
		this.unionId = unionId;
	}

	public String getUserLogo() {
		return this.userLogo;
	}

	public void setUserLogo(String userLogo) {
		this.userLogo = userLogo;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getWxgroupId() {
		return this.wxgroupId;
	}

	public void setWxgroupId(String wxgroupId) {
		this.wxgroupId = wxgroupId;
	}

}