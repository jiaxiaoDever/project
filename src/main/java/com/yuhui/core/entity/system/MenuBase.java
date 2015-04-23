package com.yuhui.core.entity.system;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.yuhui.core.entity.base.StatefulTree;
import com.yuhui.core.entity.base.StatefulTreeEntity;
import com.yuhui.core.repository.mybatis.OrderBy;

@Entity
@Table(name = "tb_sys_menu")
@OrderBy(value = "sort")
public class MenuBase extends StatefulTreeEntity<MenuBase> implements StatefulTree<MenuBase> {

	private static final long serialVersionUID = 1L;

	/** 描述 */
	private String description;

	/** 菜单在同一层次上的排序 */
	private Integer sort;

	/** 备用 */
	private String code;
	@Column(name = "icon")
	private String iconSkin;
	@Transient
	private String link;
	private String resourceId;
	private Integer type;
	/** 不设置或默认为靠左left，right 靠右*/
	//private Integer align;
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIconSkin() {
		return iconSkin;
	}

	public void setIconSkin(String iconSkin) {
		this.iconSkin = iconSkin;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getResourceId() {
		return resourceId;
	}

	public void setResourceId(String resourceId) {
		this.resourceId = resourceId;
	}

//	public Integer getAlign() {
//		return align;
//	}
//
//	public void setAlign(Integer align) {
//		this.align = align;
//	}
	
}
