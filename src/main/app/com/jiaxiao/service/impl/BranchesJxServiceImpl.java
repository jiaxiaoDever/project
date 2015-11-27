package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbBranchesJx;
import com.jiaxiao.repository.BranchesJxDAO;
import com.jiaxiao.service.BranchesJxService;
import com.jiaxiao.service.impl.system.ImportServiceImpl;
import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.repository.mybatis.BaseRepository;

@Service(value = "branchesJxService")
@Transactional(readOnly = true)
public class BranchesJxServiceImpl extends ImportServiceImpl<TbBranchesJx> implements
		BranchesJxService,ImportService<TbBranchesJx> {

	@Autowired
	private BranchesJxDAO branchesJxDAO;
	@Override
	public BaseRepository<TbBranchesJx> getMybatisDAO() {
		return branchesJxDAO;
	}

}
