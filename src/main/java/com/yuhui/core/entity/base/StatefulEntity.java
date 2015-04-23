package com.yuhui.core.entity.base;

import java.util.Date;

import javax.persistence.MappedSuperclass;

/**
 * 统一定义id,state,stateDate的entity基类.
 */
@MappedSuperclass
public class StatefulEntity extends IdEntity {

	/**
	 *
	 */
	private static final long serialVersionUID = -2076761874331898993L;

	/** 状态 */
	protected Integer state;

	/** 更新日期 */
	protected Date stateDate;

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Date getStateDate() {
		return stateDate;
	}

	public void setStateDate(Date stateDate) {
		this.stateDate = stateDate;
	}

}
