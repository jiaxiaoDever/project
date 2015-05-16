package com.jiaxiao.entity;

import java.util.List;

public class RoasterCourses {

	private String roasterId;
	private TbRoasterJx tbRoasterJx;
	private List<TbCourseSt> tbCourseSts;
	public String getTeacherId() {
		return roasterId;
	}
	public void setTeacherId(String teacherId) {
		this.roasterId = teacherId;
	}
	public TbRoasterJx getTbRoasterJx() {
		return tbRoasterJx;
	}
	public void setTbRoasterJx(TbRoasterJx tbRoasterJx) {
		this.tbRoasterJx = tbRoasterJx;
	}
	public List<TbCourseSt> getTbCourseSts() {
		return tbCourseSts;
	}
	public void setTbCourseSts(List<TbCourseSt> tbCourseSts) {
		this.tbCourseSts = tbCourseSts;
	}
	public RoasterCourses() {
		super();
	}
	public RoasterCourses(String teacherId, TbRoasterJx tbRoasterJx,
			List<TbCourseSt> tbCourseSts) {
		super();
		this.roasterId = teacherId;
		this.tbRoasterJx = tbRoasterJx;
		this.tbCourseSts = tbCourseSts;
	}
	
	
}
