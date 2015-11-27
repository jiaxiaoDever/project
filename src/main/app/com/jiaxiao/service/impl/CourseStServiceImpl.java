package com.jiaxiao.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbCourseSt;
import com.jiaxiao.repository.CourseStDAO;
import com.jiaxiao.service.CourseStService;
import com.jiaxiao.service.impl.system.ImportServiceImpl;
import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.repository.mybatis.BaseRepository;

@Service(value = "courseStService")
@Transactional(readOnly = true)
public class CourseStServiceImpl extends ImportServiceImpl<TbCourseSt> implements
		CourseStService,ImportService<TbCourseSt> {

	@Autowired
	private CourseStDAO courseStDAO;
	@Override
	public BaseRepository<TbCourseSt> getMybatisDAO() {
		return courseStDAO;
	}

}
