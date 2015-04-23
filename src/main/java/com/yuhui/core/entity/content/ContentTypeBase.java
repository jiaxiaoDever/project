package com.yuhui.core.entity.content;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.StatefulTree;
import com.yuhui.core.entity.base.StatefulTreeEntity;
import com.yuhui.core.repository.mybatis.OrderBy;

/**
 * 内容分类类
 * 
 * @author zhangy
 * 
 */
@Entity
@Table(name = "tb_content_type")
@OrderBy(value = "sort")
public class ContentTypeBase extends StatefulTreeEntity<ContentTypeBase> implements StatefulTree<ContentTypeBase> {

	private static final long serialVersionUID = 1L;
	/** 简介 */
	private String enName;
	/** 简介 */
	private String intro;
	/** 发布人ID */
	private String userId;
	/** 发布人名称 */
	private String userName;
	/** 图片，可做封面 */
	private String pic;
	/** 菜单在同一层次上的排序 */
	private Integer sort;

	public String getEnName() {
		return enName;
	}

	public void setEnName(String enName) {
		this.enName = enName;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
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

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
}
