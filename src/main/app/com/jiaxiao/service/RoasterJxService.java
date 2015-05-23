package com.jiaxiao.service;

import java.util.Date;

import com.jiaxiao.entity.TbRoasterJx;
import com.jiaxiao.entity.TbTeacherJx;
import com.yuhui.core.service.base.BaseService;

public interface RoasterJxService extends BaseService<TbRoasterJx> {

	public int addTeacherDayRoast(TbTeacherJx teacherJx,Date day);
}
