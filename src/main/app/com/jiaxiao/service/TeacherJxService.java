package com.jiaxiao.service;

import com.jiaxiao.entity.TbTeacherJx;
import com.yuhui.core.service.base.BaseService;

public interface TeacherJxService extends BaseService<TbTeacherJx> {

	public int regTeacher(TbTeacherJx teacherJx,String openId) throws RuntimeException;
}
