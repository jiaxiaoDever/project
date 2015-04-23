package com.yuhui.core.entity.system;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.IdEntity;

/**
 * @author 肖长江
 * Portlet实体类
 */
@Entity
@Table(name = "tb_portlet")
public class Portlet extends IdEntity {

	/** */
	private static final long serialVersionUID = 1L;

	public Portlet() {
	}

	/**标题 */
	private String title;
	/**图标 */
	private String icon;
	/**描述 */
	private String description;
	/**编辑时间 */
	private Date editTime;
	/**URL */
	private String url;
	/**解析类型 0取页面1取json(包括js)2图片*/
	private Integer showType;
	/**备份的数据(备用扩展属性)  服务器启动，检测为取数据解析类型的系统portlet时，如果没有对应的URL，则生成该文件 */
	private String data;
	/**所属分类 1系统portlet2用户自定义portlet */
	private Integer category;
	/**创建用户编号 */
	private String userId;

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getEditTime() {
		return editTime;
	}
	public void setEditTime(Date editTime) {
		this.editTime = editTime;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getShowType() {
		return showType;
	}
	public void setShowType(Integer showType) {
		this.showType = showType;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public Integer getCategory() {
		return category;
	}
	public void setCategory(Integer category) {
		this.category = category;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}
