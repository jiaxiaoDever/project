package com.jiaxiao.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.RoasterCourses;
import com.jiaxiao.entity.TbRoasterJx;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("roasterJxDAO")
@MyBatisRepository()
public interface RoasterJxDAO extends BaseRepository<TbRoasterJx> {

	/**
	 * @author 肖长江
	 * @date 2015-5-20
	 * @todo TODO 查询教练某天的课程总数
	 * @param teacherId 教练编号
	 * @param startDate 查询日期
	 * @return 返回那天的课程总数
	 */
	public int countTeacherDayRoast(@Param(value="teacherId") String teacherId,@Param(value="startDate") String startDate);
	/**
	 * @author 肖长江
	 * @date 2015-5-20
	 * @todo TODO 根据学员课程编号查找对应教练的课程信息
	 * @param stCourseId 学员课程编号
	 * @return
	 */
	public TbRoasterJx getRoasterByStudentCourse(String stCourseId);
	
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 获取教练当前和历史对应学员课程信息
	 * @param teacherId
	 * @return
	 */
	public List<RoasterCourses> getTeacherRoastCoures(@Param(value="teacherId") String teacherId,@Param(value="nowDate") String nowDate,@Param(value="beforeDay") Integer beforeDay,@Param(value="afterDay") Integer afterDay,@Param(value="order") String order  );
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 教练课程可预约人数加一
	 * @param courseId 课程编号
	 * @return
	 */
	public int addTeacherCourse(String courseId);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 预约教练课程，课程可预约人数减一
	 * @param courseId 课程编号
	 * @return
	 */
	public int bookingTeacherCourse(String courseId);
	
}
