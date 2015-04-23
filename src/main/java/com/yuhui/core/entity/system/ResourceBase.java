package com.yuhui.core.entity.system;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.StatefulTree;
import com.yuhui.core.entity.base.StatefulTreeEntity;
import com.yuhui.core.repository.mybatis.OrderBy;

@Entity
@Table(name = "tb_sys_resource")
@OrderBy(value = "sort")
public class ResourceBase extends StatefulTreeEntity<ResourceBase> implements StatefulTree<ResourceBase> {

	private static final long serialVersionUID = 1L;

	/** 描述 */
	private String description;
	/** 网络了协议 默认http */
	private String local;
	/** ip或域名 */
	private String host;
	/** 端口 */
	private String port;
	/** 路径 */
	private String path;
	/** 上下文，即web工程名称 */
	private String context;
	/** 编码 */
	private String code;
	/** 树深 */
	private Integer deep;
	/** 排序 */
	private Integer sort;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLocal() {
		return local;
	}

	public void setLocal(String local) {
		this.local = local;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getDeep() {
		return deep;
	}

	public void setDeep(Integer deep) {
		this.deep = deep;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
}
