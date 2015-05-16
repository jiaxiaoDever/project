package com.jiaxiao.service;

import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.ro.TeacherRoasters;
import com.yuhui.core.service.base.BaseService;

public interface TeacherJxService extends BaseService<TbTeacherJx> {

	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 教练注册
	 * @param teacherJx 提交教练信息的教练对象
	 * @param openId 微信openId
	 * @return 返回值大于1代表成功，否则代表失败
	 * @throws RuntimeException
	 */
	public int regTeacher(TbTeacherJx teacherJx,String openId) throws RuntimeException;
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 微信用户绑定教练
	 * @param openId 微信用户openId
	 * @param teacherName 教练姓名
	 * @param password 密码
	 * @param teacherPhone 手机号
	 * @return 绑定成功返回1，找不到教练返回2，更新数据库失败返回3
	 * @throws RuntimeException
	 */
	public int bandToTeacher(String openId, String teacherName,
			String password, String teacherPhone) throws RuntimeException;
	
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 获取教练以后的课程
	 * @param teacherId 教练编号
	 * @return
	 */
	public TeacherRoasters getTeacherRoastAfter(String teacherId) throws Exception;
	
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 获取教练之前的课程
	 * @param teacherId 教练编号
	 * @return
	 */
	public TeacherRoasters getTeacherRoastBefore(String teacherId) throws Exception;
}
