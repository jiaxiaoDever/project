package com.yuhui.core.entity.content;


import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.StatefulEntity;
import com.yuhui.core.repository.mybatis.OrderBy;

/**
 * 内容类
 * @author zhangy
 * 
 */
@Entity
@Table(name = "tb_content")
@OrderBy(value = "SORT ASC,STATE_DATE DESC")
public class ContentBase extends StatefulEntity {

	private static final long serialVersionUID = 1L;
	/**
	 * 内容分类Id
	 */
	private String contentTypeId;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 简介
	 */
	private String intro;
	
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 发布人ID
	 */
	private String userId;
	/**
	 * 发布人名称
	 */
	private String userName;
	/**
	 * 图片，可做封面
	 */
	private String pic;
	/**
	 * 创建日期
	 */
	private Date createDate;
	/** 菜单在同一层次上的排序 */
	private Integer sort;

	public String getContentTypeId() {
		return contentTypeId;
	}
	public void setContentTypeId(String contentTypeId) {
		this.contentTypeId = contentTypeId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
}
