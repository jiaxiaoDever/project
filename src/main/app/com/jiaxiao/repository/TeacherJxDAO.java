package com.jiaxiao.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

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
	 * @date 2015-5-11
	 * @todo TODO 根据微信openId获取绑定的教练对象
	 * @param openId 微信openId
	 * @return 微信openId获取绑定的教练对象
	 */
	public TbTeacherJx getBandedTeacherJx(String openId);
}
