package com.jiaxiao.entity;

import java.io.Serializable;

import javax.persistence.Entity;

import com.jiaxiao.entity.TbCourseSt;
import com.jiaxiao.entity.TbRoasterJx;

/**
 * @author 肖长江
 * 学员已约课程信息
 */
@Entity
public class StudentCourse  implements Serializable{

	/** */
	private static final long serialVersionUID = -4704751329665892950L;
	/** 学员课程信息编号*/
	private String stCourseId;
	/** 对应教练课程信息*/
	private TbRoasterJx roasterJx;
	/** 学员课程详细信息*/
	private TbCourseSt courseSt;
	public String getStCourseId() {
		return stCourseId;
	}
	public void setStCourseId(String stCourseId) {
		this.stCourseId = stCourseId;
	}
	public TbRoasterJx getRoasterJx() {
		return roasterJx;
	}
	public void setRoasterJx(TbRoasterJx roasterJx) {
		this.roasterJx = roasterJx;
	}
	public TbCourseSt getCourseSt() {
		return courseSt;
	}
	public void setCourseSt(TbCourseSt courseSt) {
		this.courseSt = courseSt;
	}
	public StudentCourse(String stCourseId, TbRoasterJx roasterJx,
			TbCourseSt courseSt) {
		super();
		this.stCourseId = stCourseId;
		this.roasterJx = roasterJx;
		this.courseSt = courseSt;
	}
	public StudentCourse() {
		super();
	}
	
	
}
