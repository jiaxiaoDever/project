package com.yuhui.core.entity.system;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.IdEntity;

/**
 * @author 肖长江
 * portlet页面布局实体类
 */
@Entity
@Table(name = "tb_pagelayout_portlet")
public class PortPageLayout extends IdEntity {

	/** */
	private static final long serialVersionUID = 1L;

	public PortPageLayout() {
	}

	/**用户或组或角色 编号 */
	private String forId;
	/**布局绑定类型  1用户2角色3用户组 */
	private Integer forType;
	/**编辑时间 */
	private Date editTime;
	/**布局内容 json数据 */
	private String layoutContext;

	public String getForId() {
		return forId;
	}
	public void setForId(String forId) {
		this.forId = forId;
	}
	public Integer getForType() {
		return forType;
	}
	public void setForType(Integer forType) {
		this.forType = forType;
	}
	public Date getEditTime() {
		return editTime;
	}
	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}
	public String getLayoutContext() {
		return layoutContext;
	}
	public void setLayoutContext(String layoutContext) {
		this.layoutContext = layoutContext;
	}
	
	
}
