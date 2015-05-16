package com.jiaxiao.ro;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TeacherRoasters {

	/** 教练编号*/
	private String teacherId;
	/** 教练名称*/
	private String teacherName;
	/** 驾校编号*/
	private String jxId;
	/** 驾校名称*/
	private String jxName;
	/** 网点编号*/
	private String branchId;
	/** 网点名称*/
	private String branchName;
	/** 统计开始日期*/
	private Date startDay;
	/** 统计结束日期*/
	private Date endDay;
	/** 总课时*/
	private int totolCoures;
	/** 未预约课时*/
	private int noCoures;
	
	/** 需要上课的课时数*/
	private int duteCoures;
	
	/** 课程详细情况*/
	private List<RoasterDay> roasterDays = new ArrayList<RoasterDay>();

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

	public Date getStartDay() {
		return startDay;
	}

	public void setStartDay(Date startDay) {
		this.startDay = startDay;
	}

	public Date getEndDay() {
		return endDay;
	}

	public void setEndDay(Date endDay) {
		this.endDay = endDay;
	}

	public int getTotolCoures() {
		return totolCoures;
	}

	public void setTotolCoures(int totolCoures) {
		this.totolCoures = totolCoures;
	}

	public int getNoCoures() {
		return noCoures;
	}

	public void setNoCoures(int noCoures) {
		this.noCoures = noCoures;
	}

	public int getDuteCoures() {
		return duteCoures;
	}

	public void setDuteCoures(int duteCoures) {
		this.duteCoures = duteCoures;
	}

	public List<RoasterDay> getRoasterDays() {
		return roasterDays;
	}

	public void setRoasterDays(List<RoasterDay> roasterDays) {
		this.roasterDays = roasterDays;
	}

	public TeacherRoasters() {
		super();
	}

	public TeacherRoasters(String teacherId, String teacherName, String jxId,
			String jxName, String branchId, String branchName, Date startDay,
			Date endDay, int totolCoures, int noCoures, int duteCoures,
			List<RoasterDay> roasterDays) {
		super();
		this.teacherId = teacherId;
		this.teacherName = teacherName;
		this.jxId = jxId;
		this.jxName = jxName;
		this.branchId = branchId;
		this.branchName = branchName;
		this.startDay = startDay;
		this.endDay = endDay;
		this.totolCoures = totolCoures;
		this.noCoures = noCoures;
		this.duteCoures = duteCoures;
		this.roasterDays = roasterDays;
	}
	
	
}
