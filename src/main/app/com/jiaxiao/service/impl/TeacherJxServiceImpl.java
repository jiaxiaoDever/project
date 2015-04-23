package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.repository.TeacherJxDAO;
import com.jiaxiao.service.TeacherJxService;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;

@Service(value = "teacherJxService")
@Transactional(readOnly = true)
public class TeacherJxServiceImpl extends BaseServiceImpl<TbTeacherJx> implements
		TeacherJxService {

	@Autowired
	private TeacherJxDAO teacherJxDAO;
	@Override
	public BaseRepository<TbTeacherJx> getMybatisDAO() {
		return teacherJxDAO;
	}


}
