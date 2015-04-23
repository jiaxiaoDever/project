package com.jiaxiao.ro;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 肖长江
 * 教练对象信息
 */
public class Teacher {

	/**教练编号*/
	private String teacherId;
	/**教练名称*/
	private String teacherName;
	/**教练所在驾校编号*/
	private String jxId;
	/**教练所在驾校名称*/
	private String jxName;
	/**教练所在网点编号*/
	private String branchId;
	/**教练所在网点名称*/
	private String branchName;
	/**教练所教科目编号*/
	private String subjectId ;
	/**教练所教科目名称*/
	private String subjectName ;
	/**教练头像地址*/
	private String tLogo;
	/**教练评分*/
	private String scroe;
	/**教练点评数*/
	private String scroeNum;
	/**教练浏览数*/
	private String checkNum;
	/**教练被赞数*/
	private String likeNum;
	/**教练教龄(月)*/
	private String duteAge;
	/**教练性别*/
	private String sex;
	/**教练是否为明星教练*/
	private boolean isHot;
	/**驾校教练未来几天的课程信息*/
	private List<CourseDay> courseDays = new ArrayList<CourseDay>();
	
	public Teacher() {
		super();
	}
	
	public Teacher(String teacherId, String teacherName, String jxId,
			String jxName, String branchId, String branchName,
			String subjectId, String subjectName, String tLogo, String scroe,
			String scroeNum, String checkNum, String likeNum, String duteAge,
			String sex, boolean isHot, List<CourseDay> courseDays) {
		super();
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.jxId = jxId;
		this.jxName = jxName;
		this.branchId = branchId;
		this.branchName = branchName;
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.tLogo = tLogo;
		this.scroe = scroe;
		this.scroeNum = scroeNum;
		this.checkNum = checkNum;
		this.likeNum = likeNum;
		this.duteAge = duteAge;
		this.sex = sex;
		this.isHot = isHot;
		this.courseDays = courseDays;
	}

	public List<CourseDay> getCourseDays() {
		return courseDays;
	}

	public void setCourseDays(List<CourseDay> courseDays) {
		this.courseDays = courseDays;
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
	public String getJxId() {
		return jxId;
	}
	public void setJxId(String jxId) {
		this.jxId = jxId;
	}
	public String getJxName() {
		return jxName;
	}
	public void setJxName(String jxName) {
		this.jxName = jxName;
	}
	public String getBranchId() {
		return branchId;
	}
	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
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
	public String gettLogo() {
		return tLogo;
	}
	public void settLogo(String tLogo) {
		this.tLogo = tLogo;
	}
	public String getScroe() {
		return scroe;
	}
	public void setScroe(String scroe) {
		this.scroe = scroe;
	}
	public String getScroeNum() {
		return scroeNum;
	}
	public void setScroeNum(String scroeNum) {
		this.scroeNum = scroeNum;
	}
	public String getCheckNum() {
		return checkNum;
	}
	public void setCheckNum(String checkNum) {
		this.checkNum = checkNum;
	}
	public String getLikeNum() {
		return likeNum;
	}
	public void setLikeNum(String likeNum) {
		this.likeNum = likeNum;
	}
	public String getDuteAge() {
		return duteAge;
	}
	public void setDuteAge(String duteAge) {
		this.duteAge = duteAge;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public boolean isHot() {
		return isHot;
	}
	public void setHot(boolean isHot) {
		this.isHot = isHot;
	}
	
	
}
