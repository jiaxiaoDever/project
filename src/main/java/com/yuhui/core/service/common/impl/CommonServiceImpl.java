package com.yuhui.core.service.common.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.entity.common.SqlColumn;
import com.yuhui.core.entity.common.SysEnum;
import com.yuhui.core.repository.common.SqlColumnDAO;
import com.yuhui.core.repository.common.SysEnumDAO;
import com.yuhui.core.service.common.CommonService;

@Service(value = "commonService")
@Transactional(readOnly = true)
public class CommonServiceImpl implements CommonService {
	@Autowired
	private SysEnumDAO sysEnumDAO;
	@Autowired
	private SqlColumnDAO sqlColumnDAO;
	@Override
	public List<SysEnum> findAllEnum() {
		return sysEnumDAO.findAll(SysEnum.class);
	}
	@Override
	public List<SqlColumn> findAllColumns(){
		return sqlColumnDAO.findAllColumns();
	}
}
