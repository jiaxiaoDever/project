package com.yuhui.core.entity.content;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.StatefulEntity;

/**
 * 附件类
 * @author zhangy
 * 
 */
@Entity
@Table(name = "tb_attach")
public class AttachBase extends StatefulEntity {

	private static final long serialVersionUID = 1L;
	/**
	 * 附件名称
	 */
	private String name;
	
	/**
	 * 简介
	 */
	private String intro;
	
	/**
	 * 文件类型
	 */
	private String fileType;
	/**
	 * 文件路径
	 */
	private String url;
	/**
	 * 目标ID,如内容ID
	 */
	private String targetId;
	/**
	 * 目标类型，区分目标ID所在表，先用表名作为类型
	 */
	private String targetType;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	public String getTargetType() {
		return targetType;
	}
	public void setTargetType(String targetType) {
		this.targetType = targetType;
	}
}
