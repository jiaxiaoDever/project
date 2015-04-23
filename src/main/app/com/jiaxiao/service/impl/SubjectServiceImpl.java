package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbSubject;
import com.jiaxiao.repository.SubjectDAO;
import com.jiaxiao.service.SubjectService;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;

@Service(value = "subjectService")
@Transactional(readOnly = true)
public class SubjectServiceImpl extends BaseServiceImpl<TbSubject> implements
		SubjectService {

	@Autowired
	private SubjectDAO subjectDAO;
	@Override
	public BaseRepository<TbSubject> getMybatisDAO() {
		return subjectDAO;
	}


}
