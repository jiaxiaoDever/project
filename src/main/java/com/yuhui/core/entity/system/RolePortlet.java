package com.yuhui.core.entity.system;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;

@Entity
public class RolePortlet  implements Serializable {

	/** */
	private static final long serialVersionUID = 1L;

	public RolePortlet() {
	}

	private String rid;
	private String name;
	private List<Portlet> portlets;

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public List<Portlet> getPortlets() {
		return portlets;
	}
	public void setPortlets(List<Portlet> portlets) {
		this.portlets = portlets;
	}
	public RolePortlet(String rid, List<Portlet> portlets) {
		super();
		this.rid = rid;
		this.portlets = portlets;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
