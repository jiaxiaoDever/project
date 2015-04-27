package com.jiaxiao.ro;

import java.io.Serializable;

/**
 * @author 肖长江
 * 驾校课程信息
 */
public class Course  implements Serializable{
 
	/** */
	private static final long serialVersionUID = -2647304306496331932L;
	/**课程编号*/
	private String courseId;
	/**课程名称*/
	private String courseName;
	/**开始时间*/
	private String startTime;
	/**结束时间*/
	private String endTime;
	/**课程所属时间段*/
	private String courseTimearea;
	/**可约车人数*/
	private String courseInNum;
	/**剩余可约车人数*/
	private String canSignNum;
	
	public Course() {
		super();
	}
	public Course(String courseId, String courseName, String startTime,
			String endTime, String courseTimearea, String courseInNum,
			String canSignNum) {
		super();
		this.courseId = courseId;
		this.courseName = courseName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.courseTimearea = courseTimearea;
		this.courseInNum = courseInNum;
		this.canSignNum = canSignNum;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getStartTime() {
		if(startTime != null && !"".equals(startTime) && startTime.length() > 11){
			return startTime.substring(11);
		} 
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		if(endTime != null && !"".equals(endTime) && endTime.length() > 11) {
			return endTime.substring(11);
		} 
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getCourseTimearea() {
		return courseTimearea;
	}
	public void setCourseTimearea(String courseTimearea) {
		this.courseTimearea = courseTimearea;
	}
	public String getCourseInNum() {
		return courseInNum;
	}
	public void setCourseInNum(String courseInNum) {
		this.courseInNum = courseInNum;
	}
	public String getCanSignNum() {
		return canSignNum;
	}
	public void setCanSignNum(String canSignNum) {
		this.canSignNum = canSignNum;
	}
	
	
}
