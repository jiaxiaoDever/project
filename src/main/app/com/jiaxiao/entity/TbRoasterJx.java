package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 教练课程信息
 */
@Entity
@Table(name="tb_roaster_jx")
public class TbRoasterJx implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 课程编号*/
	@Id
	@Column(name="COURSE_ID")
	private String courseId;

	/** 网点编号*/
	@Column(name="BRANCH_ID")
	private String branchId;

	/** 网点名称*/
	@Column(name="BRANCH_NAME")
	private String branchName;

	/** 剩余可约课次数*/
	@Column(name="CAN_SIGN_NUM")
	private Integer canSignNum;

	/** 备注*/
	private String common;

	/** 课时数*/
	@Column(name="COURSE_HOUR")
	private Integer courseHour;

	/** 可约课次数*/
	@Column(name="COURSE_IN_NUM")
	private Integer courseInNum;

	/** 课程简介*/
	@Column(name="COURSE_INFO")
	private String courseInfo;

	/** 课程名称*/
	@Column(name="COURSE_NAME")
	private String courseName;

	/** 课程上课通知提前小时数*/
	@Column(name="COURSE_NOTIC_B_HOUR")
	private Integer courseNoticBHour;

	/** 课程状态*/
	@Column(name="COURSE_STAT")
	private String courseStat;

	/** 状态编码*/
	@Column(name="COURSE_STAT_CODE")
	private String courseStatCode;

	/** 所在时间段*/
	@Column(name="COURSE_TIMEAREA")
	private String courseTimearea;

	/** 所在时间段编码*/
	@Column(name="COURSE_TIMEAREA_CODE")
	private String courseTimeareaCode;

	/** 创建时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	/** 编辑时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	/** 变更截止时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_END_TIME")
	private Date editEndTime;

	/** 结束时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="END_TIME")
	private Date endTime;

	/** 课程上课通知开关*/
	@Column(name="IS_COURSE_NOTIC")
	private Integer isCourseNotic;

	/** 课程排班通知教练开关*/
	@Column(name="IS_ROAST_NOTIC")
	private Integer isRoastNotic;

	/** 驾校编号*/
	@Column(name="JX_ID")
	private String jxId;

	/** 驾校名称*/
	@Column(name="JX_NAME")
	private String jxName;

	/** 线下预约人数*/
	@Column(name="OFFLINE_NUM")
	private Integer offlineNum;

	/** 课程排班通知延后小时数*/
	@Column(name="ROAST_NOTIC_A_HOUR")
	private Integer roastNoticAHour;

	/** 预约截止时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="SIGN_END_TIME")
	private Date signEndTime;

	/** 开始时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="START_TIME")
	private Date startTime;

	/** 科目编号*/
	@Column(name="SUBJECT_ID")
	private String subjectId;

	/** 科目名称*/
	@Column(name="SUBJECT_NAME")
	private String subjectName;

	/** 教练编号*/
	@Column(name="TEACHER_ID")
	private String teacherId;

	/** 教练名称*/
	@Column(name="TEACHER_NAME")
	private String teacherName;

	public TbRoasterJx() {
	}

	public String getCourseId() {
		return this.courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getBranchId() {
		return this.branchId;
	}

	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}

	public String getBranchName() {
		return this.branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public Integer getCanSignNum() {
		return this.canSignNum;
	}

	public void setCanSignNum(Integer canSignNum) {
		this.canSignNum = canSignNum;
	}

	public String getCommon() {
		return this.common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public Integer getCourseHour() {
		return this.courseHour;
	}

	public void setCourseHour(Integer courseHour) {
		this.courseHour = courseHour;
	}

	public Integer getCourseInNum() {
		return this.courseInNum;
	}

	public void setCourseInNum(Integer courseInNum) {
		this.courseInNum = courseInNum;
	}

	public String getCourseInfo() {
		return this.courseInfo;
	}

	public void setCourseInfo(String courseInfo) {
		this.courseInfo = courseInfo;
	}

	public String getCourseName() {
		return this.courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public Integer getCourseNoticBHour() {
		return this.courseNoticBHour;
	}

	public void setCourseNoticBHour(Integer courseNoticBHour) {
		this.courseNoticBHour = courseNoticBHour;
	}

	public String getCourseStat() {
		return this.courseStat;
	}

	public void setCourseStat(String courseStat) {
		this.courseStat = courseStat;
	}

	public String getCourseStatCode() {
		return this.courseStatCode;
	}

	public void setCourseStatCode(String courseStatCode) {
		this.courseStatCode = courseStatCode;
	}

	public String getCourseTimearea() {
		return this.courseTimearea;
	}

	public void setCourseTimearea(String courseTimearea) {
		this.courseTimearea = courseTimearea;
	}

	public String getCourseTimeareaCode() {
		return this.courseTimeareaCode;
	}

	public void setCourseTimeareaCode(String courseTimeareaCode) {
		this.courseTimeareaCode = courseTimeareaCode;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getEditDate() {
		return this.editDate;
	}

	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}

	public Date getEditEndTime() {
		return this.editEndTime;
	}

	public void setEditEndTime(Date editEndTime) {
		this.editEndTime = editEndTime;
	}

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Integer getIsCourseNotic() {
		return this.isCourseNotic;
	}

	public void setIsCourseNotic(Integer isCourseNotic) {
		this.isCourseNotic = isCourseNotic;
	}

	public Integer getIsRoastNotic() {
		return this.isRoastNotic;
	}

	public void setIsRoastNotic(Integer isRoastNotic) {
		this.isRoastNotic = isRoastNotic;
	}

	public String getJxId() {
		return this.jxId;
	}

	public void setJxId(String jxId) {
		this.jxId = jxId;
	}

	public String getJxName() {
		return this.jxName;
	}

	public void setJxName(String jxName) {
		this.jxName = jxName;
	}

	public Integer getOfflineNum() {
		return this.offlineNum;
	}

	public void setOfflineNum(Integer offlineNum) {
		this.offlineNum = offlineNum;
	}

	public Integer getRoastNoticAHour() {
		return this.roastNoticAHour;
	}

	public void setRoastNoticAHour(Integer roastNoticAHour) {
		this.roastNoticAHour = roastNoticAHour;
	}

	public Date getSignEndTime() {
		return this.signEndTime;
	}

	public void setSignEndTime(Date signEndTime) {
		this.signEndTime = signEndTime;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public String getSubjectId() {
		return this.subjectId;
	}

	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}

	public String getSubjectName() {
		return this.subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public String getTeacherId() {
		return this.teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	public String getTeacherName() {
		return this.teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public TbRoasterJx(String courseId, String branchId, String branchName,
			Integer canSignNum, String common, Integer courseHour,
			Integer courseInNum, String courseInfo, String courseName,
			Integer courseNoticBHour, String courseStat, String courseStatCode,
			String courseTimearea, String courseTimeareaCode, Date createDate,
			Date editDate, Date editEndTime, Date endTime,
			Integer isCourseNotic, Integer isRoastNotic, String jxId,
			String jxName, Integer offlineNum, Integer roastNoticAHour,
			Date signEndTime, Date startTime, String subjectId,
			String subjectName, String teacherId, String teacherName) {
		super();
		this.courseId = courseId;
		this.branchId = branchId;
		this.branchName = branchName;
		this.canSignNum = canSignNum;
		this.common = common;
		this.courseHour = courseHour;
		this.courseInNum = courseInNum;
		this.courseInfo = courseInfo;
		this.courseName = courseName;
		this.courseNoticBHour = courseNoticBHour;
		this.courseStat = courseStat;
		this.courseStatCode = courseStatCode;
		this.courseTimearea = courseTimearea;
		this.courseTimeareaCode = courseTimeareaCode;
		this.createDate = createDate;
		this.editDate = editDate;
		this.editEndTime = editEndTime;
		this.endTime = endTime;
		this.isCourseNotic = isCourseNotic;
		this.isRoastNotic = isRoastNotic;
		this.jxId = jxId;
		this.jxName = jxName;
		this.offlineNum = offlineNum;
		this.roastNoticAHour = roastNoticAHour;
		this.signEndTime = signEndTime;
		this.startTime = startTime;
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.teacherId = teacherId;
		this.teacherName = teacherName;
	}

}