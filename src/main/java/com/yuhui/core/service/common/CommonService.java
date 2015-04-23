package com.yuhui.core.service.common;

import java.util.List;

import com.yuhui.core.entity.common.SqlColumn;
import com.yuhui.core.entity.common.SysEnum;

public interface CommonService {
	/**
	 * 获取所有枚举
	 * @return
	 */
	public List<SysEnum> findAllEnum();
	/**
	 * 获取所有表的列属性
	 * @return
	 */
	List<SqlColumn> findAllColumns();
}
