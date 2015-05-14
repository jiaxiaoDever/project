package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbBaseJx;
import com.jiaxiao.repository.JxDAO;
import com.jiaxiao.service.JxService;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;

@Service(value = "jxService")
@Transactional(readOnly = true)
public class JxServiceImpl extends BaseServiceImpl<TbBaseJx> implements JxService {

	@Autowired
	private JxDAO jxDAO;
	@Override
	public BaseRepository<TbBaseJx> getMybatisDAO() {
		return jxDAO;
	}


}
