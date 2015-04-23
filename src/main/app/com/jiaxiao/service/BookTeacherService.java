package com.jiaxiao.service;

import com.jiaxiao.ro.BookTeachers;
import com.jiaxiao.ro.CourseDay;

public interface BookTeacherService {

	/**
	 * @author 肖长江
	 * @date 2015-4-15
	 * @todo TODO 预约驾校
	 * @param openId 微信ID
	 * @return 返回预约驾校信息
	 */
	public BookTeachers bookTeacher(String openId) throws Exception;
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 查找某教练某天的课程详细信息
	 * @param teacherId 教练编号
	 * @param bookingDate 课程日期
	 * @return 返回教练课程日期那天课程详细信息
	 * @throws Exception
	 */
	public CourseDay FindTeacherCourseDetail(String teacherId,String bookingDate) throws Exception;
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 微信用户预约教练课程
	 * @param openId 微信openId
	 * @param courseId 课程编号
	 * @return 如果用户未绑定学员返回0,预约成功返回1,课程无空位返回2,修改数据库失败返回3,已无剩余课时返回4,当日可预约课时已满返回5,当前课程已经预约过返回6
	 * @throws Exception
	 */
	public int bookCourse(String openId,String courseId) throws Exception;
}
