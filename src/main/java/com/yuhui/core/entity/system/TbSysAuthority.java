package com.yuhui.core.entity.system;

import javax.persistence.Entity;
import javax.persistence.IdClass;
import javax.persistence.Table;

import com.yuhui.core.entity.base.StatefulEntity;
/**
 * @author 肖长江
 * 操作权限
 */
@Entity
@Table(name = "tb_sys_authority")
@IdClass(value=String.class)
public class TbSysAuthority extends StatefulEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3200107882698031059L;

	private RoleBase role;

	private MenuBase menu;
	/**
	 * 角色名称
	 */
	private String symbol;

	/**
	 * 级别 1:'中国电信', 2:'省级',3:'市级',4:'县级',5:'营服'
	 */
	private String orgLevel;

	/**
	 * 地址
	 */
	private String url;

	/**
	 * 操作项 RWD
	 */
	private String opt;
	public TbSysAuthority() {
	}
	public RoleBase getRole() {
		return role;
	}
	public void setRole(RoleBase role) {
		this.role = role;
	}
	public MenuBase getMenu() {
		return menu;
	}
	public void setMenu(MenuBase menu) {
		this.menu = menu;
	}
	public String getSymbol() {
		return symbol;
	}
	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}
	public String getOrgLevel() {
		return orgLevel;
	}
	public void setOrgLevel(String orgLevel) {
		this.orgLevel = orgLevel;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public TbSysAuthority(RoleBase role, MenuBase menu,
			String symbol, String orgLevel, String url, String opt) {
		super();
		this.role = role;
		this.menu = menu;
		this.symbol = symbol;
		this.orgLevel = orgLevel;
		this.url = url;
		this.opt = opt;
	}


}
