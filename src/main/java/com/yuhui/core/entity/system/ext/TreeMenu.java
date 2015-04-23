package com.yuhui.core.entity.system.ext;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.IdClass;
import javax.persistence.Table;

import com.yuhui.core.entity.base.TreeNode;
@Entity
@Table(name = "tb_sys_menu")
@IdClass(value=String.class)
public class TreeMenu extends TreeNode<String> implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8772580634443220368L;


	/** 描述 */
	private String description;

	/** 菜单在同一层次上的排序 */
	private int sort;

	/** 备用 */
	private String code;
	/**
	 * 按钮样式
	 */
	private String icon;
	/**
	 * 菜单url或按钮触发
	 */
	private String link;
	/**
	 * 类型,0菜单，1按钮，2其它
	 */
	private int type;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}
