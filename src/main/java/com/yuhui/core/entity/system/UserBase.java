package com.yuhui.core.entity.system;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.yuhui.core.entity.base.StatefulEntity;
import com.yuhui.core.repository.mybatis.OrderBy;

@Entity
@Table(name = "tb_sys_user")
@OrderBy(value = "STATE_DATE DESC")
public class UserBase extends StatefulEntity {

	private static final long serialVersionUID = 1L;

	private String username;

	private String password;

	private String salt;

	/** 姓名 */
	private String name;

	/** 员工性别 */
	private Integer sex;

	/** 固定电话 */
	private String phoneNbr;

	/** 小灵通 */
	private String phsNbr;

	/** 移动电话 */
	private String mobileNbr;

	/** 邮件地址 */
	private String emailAddr;

	@Transient
	private List<RoleBase> roles;

	private String channelId;

	private String staffId;

	private String isLogincode;

	private String corpId;

	private String regions;

	private String organizationId;

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getPhoneNbr() {
		return phoneNbr;
	}

	public void setPhoneNbr(String phoneNbr) {
		this.phoneNbr = phoneNbr;
	}

	public String getPhsNbr() {
		return phsNbr;
	}

	public void setPhsNbr(String phsNbr) {
		this.phsNbr = phsNbr;
	}

	public String getMobileNbr() {
		return mobileNbr;
	}

	public void setMobileNbr(String mobileNbr) {
		this.mobileNbr = mobileNbr;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public List<RoleBase> getRoles() {
		return roles;
	}

	public void setRoles(List<RoleBase> roles) {
		this.roles = roles;
	}

	public String getChannelId() {
		return channelId;
	}

	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

	public String getStaffId() {
		return staffId;
	}

	public void setStaffId(String staffId) {
		this.staffId = staffId;
	}

	public String getIsLogincode() {
		return isLogincode;
	}

	public void setIsLogincode(String isLogincode) {
		this.isLogincode = isLogincode;
	}

	public String getCorpId() {
		return corpId;
	}

	public void setCorpId(String corpId) {
		this.corpId = corpId;
	}

	public String getRegions() {
		return regions;
	}

	public void setRegions(String regions) {
		this.regions = regions;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(String organizationId) {
		this.organizationId = organizationId;
	}

	public UserBase(String username, String password, String salt, String name, Integer sex, String phoneNbr, String phsNbr, String mobileNbr, String emailAddr, String channelId,
			String staffId, String isLogincode, String corpId, String regions, String organizationId) {
		super();
		this.username = username;
		this.password = password;
		this.salt = salt;
		this.name = name;
		this.sex = sex;
		this.phoneNbr = phoneNbr;
		this.phsNbr = phsNbr;
		this.mobileNbr = mobileNbr;
		this.emailAddr = emailAddr;
		this.channelId = channelId;
		this.staffId = staffId;
		this.isLogincode = isLogincode;
		this.corpId = corpId;
		this.regions = regions;
		this.organizationId = organizationId;
	}

	public UserBase() {
		super();
	}

}
