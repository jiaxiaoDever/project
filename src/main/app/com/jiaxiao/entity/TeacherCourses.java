package com.jiaxiao.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;

/**
 * @author 肖长江
 * 教练课程信息
 * 
 */
@Entity
public class TeacherCourses  implements Serializable {

	/** */
	private static final long serialVersionUID = 2019889771277794733L;

	/** 教练编号*/
	private String teacherId;
	/** 教练详细信息*/
	private TbTeacherJx tbTeacherJx;
	/** 教练课程详细信息*/
	private List<TbRoasterJx> tbRoasterJxs;
	public TbTeacherJx getTbTeacherJx() {
		return tbTeacherJx;
	}
	public void setTbTeacherJx(TbTeacherJx tbTeacherJx) {
		this.tbTeacherJx = tbTeacherJx;
	}
	public TeacherCourses() {
		super();
	}
	public List<TbRoasterJx> getTbRoasterJxs() {
		return tbRoasterJxs;
	}
	public void setTbRoasterJxs(List<TbRoasterJx> tbRoasterJxs) {
		this.tbRoasterJxs = tbRoasterJxs;
	}
	public String getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}
	public TeacherCourses(String teacherId, TbTeacherJx tbTeacherJx,
			List<TbRoasterJx> tbRoasterJxs) {
		super();
		this.teacherId = teacherId;
		this.tbTeacherJx = tbTeacherJx;
		this.tbRoasterJxs = tbRoasterJxs;
	}
	
	
}
