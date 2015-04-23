package com.jiaxiao.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbCourseSt;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.entity.TeacherCourses;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("teacherJxDAO")
@MyBatisRepository()
public interface TeacherJxDAO extends BaseRepository<TbTeacherJx> {

	/**
	 * @author 肖长江
	 * @date 2015-4-17
	 * @todo TODO 查找指定网点下面所有排班了的在职教练及其报名中的课程信息
	 * @param branchId 网点编号
	 * @return 返回网点下面所有排班了的在职教练及其报名中课程信息
	 */
	public List<TeacherCourses> findTeacherCouresOnBranch(String branchId);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 查找指定教练某天课程的详细信息
	 * @param teacherId 教练编号
	 * @param bookingDate 日期
	 * @return 返回教练那天课程的详细信息
	 */
	public List<TeacherCourses> findTeacherCouresDetail(@Param(value="teacherId") String teacherId,@Param(value="bookingDate") String bookingDate);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 预约教练课程，课程可预约人数减一
	 * @param courseId 课程编号
	 * @return
	 */
	public int bookingTeacherCourse(String courseId);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 新增学员约课记录
	 * @param stc 学员约课对象
	 * @return
	 */
	public int addStudentCourse(TbCourseSt stc);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-22
	 * @todo TODO 给指定的学员信息的剩余课时数减一
	 * @param studentId 学员编号
	 * @return
	 */
	public int reduceStudentCanSianNum(String studentId);
}
