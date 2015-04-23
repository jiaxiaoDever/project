package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbBranchesJx;
import com.jiaxiao.repository.BranchesJxDAO;
import com.jiaxiao.service.BranchesJxService;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;

@Service(value = "branchesJxService")
@Transactional(readOnly = true)
public class BranchesJxServiceImpl extends BaseServiceImpl<TbBranchesJx> implements
		BranchesJxService {

	@Autowired
	private BranchesJxDAO branchesJxDAO;
	@Override
	public BaseRepository<TbBranchesJx> getMybatisDAO() {
		return branchesJxDAO;
	}

}
