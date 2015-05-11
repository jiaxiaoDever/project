package com.jiaxiao.service;

import java.util.List;

import com.jiaxiao.entity.StudentCourse;
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
	 * @throws RuntimeException 抛出此异常说明事物回滚了，修改数据库失败，抛出异常的message为“3”，同返回3一样的意思
	 */
	public int bookCourse(String openId,String courseId) throws RuntimeException;
	
	/**
	 * @author 肖长江
	 * @date 2015-4-27
	 * @todo TODO 微信用户对应学员的已约教练课程信息
	 * @param openId 微信openId
	 * @return 如果用户未绑定学员,返回Null;否则返回用户对应学员的已预约教练课程信息
	 * @throws Exception
	 */
	public List<StudentCourse> bookedCourses(String openId) throws Exception;
	
	/**
	 * @author 肖长江
	 * @date 2015-4-29
	 * @todo TODO 取消已经预约的教练课程
	 * @param openId 微信用户openId
	 * @param stCourseId 学员课程编号
	 * @return 取消失败返回0，取消成功返回1，未绑定学员返回2，超出变更时间返回3，找不到教练课程返回4
	 * @throws RuntimeException 相关条件不满足，回滚事物；取消失败
	 */
	public int cancelCourse(String openId,String stCourseId) throws RuntimeException;
	
	/**
	 * @author 肖长江
	 * @date 2015-4-30
	 * @todo TODO 学员练车后对课程进行评价
	 * @param stCourseId 学员课程编号
	 * @param carScore 练车环境评分
	 * @param teacherScore 教练评分
	 * @param serviceScore 整体服务评分
	 * @param scoreInfo 评论内容
	 * @return 成功评论返回1，否则返回0
	 */
	public int scoreCourse(String stCourseId,Integer carScore,Integer teacherScore,Integer serviceScore,String scoreInfo);
}
