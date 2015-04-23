package com.jiaxiao.ro;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 肖长江
 * 教练一天的课程情况
 */
public class CourseDay {

	/**课程日期*/
	private String day;
	/**科目编号*/
	private String subjectId;
	/**科目名称*/
	private String subjectName;
	/**教练编号*/
	private String teacherId;
	/**教练名称*/
	private String teacherName;
	/**当天可接纳总人数*/
	private String totalNum;
	/**现在剩余可以预约人数*/
	private String canBookNum;
	/**上午可接纳总人数*/
	private String totalNumOfMorn;
	/**上午剩余可预约人数*/
	private String canBookNumOfMorn;
	/**下午可接纳总人数*/
	private String totalNumOfAftern;
	/**下午剩余可预约人数*/
	private String canBookNumOfAftern;
	
	/**上午课程详情*/
	private List<Course> coursesOfMorn = new ArrayList<Course>();
	/**下午课程详情*/
	private List<Course> coursesOfAftern = new ArrayList<Course>();
	
	public CourseDay() {
		super();
	}
	public CourseDay(String day, String subjectId, String subjectName,
			String teacherId, String teacherName, String totalNum,
			String canBookNum, String totalNumOfMorn, String canBookNumOfMorn,
			String totalNumOfAftern, String canBookNumOfAftern,
			List<Course> coursesOfMorn, List<Course> coursesOfAftern) {
		super();
		this.day = day;
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.totalNum = totalNum;
		this.canBookNum = canBookNum;
		this.totalNumOfMorn = totalNumOfMorn;
		this.canBookNumOfMorn = canBookNumOfMorn;
		this.totalNumOfAftern = totalNumOfAftern;
		this.canBookNumOfAftern = canBookNumOfAftern;
		this.coursesOfMorn = coursesOfMorn;
		this.coursesOfAftern = coursesOfAftern;
	}
	public String getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}
	public String getTeacherName() {
		return teacherName;
	}
	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public String getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(String totalNum) {
		this.totalNum = totalNum;
	}
	public String getCanBookNum() {
		return canBookNum;
	}
	public void setCanBookNum(String canBookNum) {
		this.canBookNum = canBookNum;
	}
	public String getTotalNumOfMorn() {
		return totalNumOfMorn;
	}
	public void setTotalNumOfMorn(String totalNumOfMorn) {
		this.totalNumOfMorn = totalNumOfMorn;
	}
	public String getCanBookNumOfMorn() {
		return canBookNumOfMorn;
	}
	public void setCanBookNumOfMorn(String canBookNumOfMorn) {
		this.canBookNumOfMorn = canBookNumOfMorn;
	}
	public String getTotalNumOfAftern() {
		return totalNumOfAftern;
	}
	public void setTotalNumOfAftern(String totalNumOfAftern) {
		this.totalNumOfAftern = totalNumOfAftern;
	}
	public String getCanBookNumOfAftern() {
		return canBookNumOfAftern;
	}
	public void setCanBookNumOfAftern(String canBookNumOfAftern) {
		this.canBookNumOfAftern = canBookNumOfAftern;
	}
	public List<Course> getCoursesOfMorn() {
		return coursesOfMorn;
	}
	public void setCoursesOfMorn(List<Course> coursesOfMorn) {
		this.coursesOfMorn = coursesOfMorn;
	}
	public List<Course> getCoursesOfAftern() {
		return coursesOfAftern;
	}
	public void setCoursesOfAftern(List<Course> coursesOfAftern) {
		this.coursesOfAftern = coursesOfAftern;
	}
	
	
}
