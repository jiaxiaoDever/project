package com.jiaxiao.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;

@Entity
public class TeacherCourses  implements Serializable {

	/** */
	private static final long serialVersionUID = 2019889771277794733L;

	private String teacherId;
	private TbTeacherJx tbTeacherJx;
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
