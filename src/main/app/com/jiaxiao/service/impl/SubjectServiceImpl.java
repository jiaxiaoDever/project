package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbSubject;
import com.jiaxiao.repository.SubjectDAO;
import com.jiaxiao.service.SubjectService;
import com.jiaxiao.service.impl.system.ImportServiceImpl;
import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.repository.mybatis.BaseRepository;

@Service(value = "subjectService")
@Transactional(readOnly = true)
public class SubjectServiceImpl extends ImportServiceImpl<TbSubject> implements
		SubjectService,ImportService<TbSubject> {

	@Autowired
	private SubjectDAO subjectDAO;
	@Override
	public BaseRepository<TbSubject> getMybatisDAO() {
		return subjectDAO;
	}


}
