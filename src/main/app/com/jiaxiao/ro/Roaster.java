package com.jiaxiao.ro;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.jiaxiao.entity.TbCourseSt;

public class Roaster {

	/** 课程编号*/
	@Id
	@Column(name="COURSE_ID")
	private String courseId;
	
	/** 剩余可约课次数*/
	@Column(name="CAN_SIGN_NUM")
	private Integer canSignNum;
	
	/** 可约课次数*/
	@Column(name="COURSE_IN_NUM")
	private Integer courseInNum;
	
	/** 所在时间段*/
	@Column(name="COURSE_TIMEAREA")
	private String courseTimearea;

	/** 所在时间段编码*/
	@Column(name="COURSE_TIMEAREA_CODE")
	private String courseTimeareaCode;
	
	/** 开始时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="START_TIME")
	private Date startTime;
	
	/** 结束时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="END_TIME")
	private Date endTime;
	
	/** 课程对应学员约课记录*/
	private List<TbCourseSt> courseSts = new ArrayList<TbCourseSt>();

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public Integer getCanSignNum() {
		return canSignNum;
	}

	public void setCanSignNum(Integer canSignNum) {
		this.canSignNum = canSignNum;
	}

	public Integer getCourseInNum() {
		return courseInNum;
	}

	public void setCourseInNum(Integer courseInNum) {
		this.courseInNum = courseInNum;
	}

	public String getCourseTimearea() {
		return courseTimearea;
	}

	public void setCourseTimearea(String courseTimearea) {
		this.courseTimearea = courseTimearea;
	}

	public String getCourseTimeareaCode() {
		return courseTimeareaCode;
	}

	public void setCourseTimeareaCode(String courseTimeareaCode) {
		this.courseTimeareaCode = courseTimeareaCode;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public List<TbCourseSt> getCourseSts() {
		return courseSts;
	}

	public void setCourseSts(List<TbCourseSt> courseSts) {
		this.courseSts = courseSts;
	}

	public Roaster() {
		super();
	}

	public Roaster(String courseId, Integer canSignNum, Integer courseInNum,
			String courseTimearea, String courseTimeareaCode, Date startTime,
			Date endTime, List<TbCourseSt> courseSts) {
		super();
		this.courseId = courseId;
		this.canSignNum = canSignNum;
		this.courseInNum = courseInNum;
		this.courseTimearea = courseTimearea;
		this.courseTimeareaCode = courseTimeareaCode;
		this.startTime = startTime;
		this.endTime = endTime;
		this.courseSts = courseSts;
	}
	
}
