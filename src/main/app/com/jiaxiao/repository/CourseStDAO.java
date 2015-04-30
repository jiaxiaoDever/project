package com.jiaxiao.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.StudentCourse;
import com.jiaxiao.entity.TbCourseSt;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("courseStDAO")
@MyBatisRepository()
public interface CourseStDAO  extends BaseRepository<TbCourseSt>{

	/**
	 * @author 肖长江
	 * @date 2015-4-22
	 * @todo TODO 查询学员某天已经预约的课程信息(只包括ID)
	 * @param studentId 学员编号
	 * @param bookingDate 预约日期
	 * @return
	 */
	public List<TbCourseSt> getDayBookNum(@Param(value="studentId") String studentId,@Param(value="bookingDate") String bookingDate);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-27
	 * @todo TODO 查询学员已经预约的所有课程信息
	 * @param studentId 学员编号
	 * @return
	 */
	public List<StudentCourse> findStudentBookedCourse(@Param(value="studentId") String studentId);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-29
	 * @todo TODO 取消已约课程，修改课程状态和写入取消时间
	 * @param stCourseId 已约课程编号
	 * @return
	 */
	public int cancelCourse(String stCourseId);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 新增学员约课记录
	 * @param stc 学员约课对象
	 * @return
	 */
	public int addStudentCourse(TbCourseSt stc);

}
