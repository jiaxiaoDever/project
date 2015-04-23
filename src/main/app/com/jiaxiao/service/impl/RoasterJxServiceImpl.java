package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbRoasterJx;
import com.jiaxiao.repository.RoasterJxDAO;
import com.jiaxiao.service.RoasterJxService;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;

@Service(value = "roasterJxService")
@Transactional(readOnly = true)
public class RoasterJxServiceImpl extends BaseServiceImpl<TbRoasterJx> implements
		RoasterJxService {

	@Autowired
	private RoasterJxDAO roasterJxDAO;
	@Override
	public BaseRepository<TbRoasterJx> getMybatisDAO() {
		return roasterJxDAO;
	}

}
