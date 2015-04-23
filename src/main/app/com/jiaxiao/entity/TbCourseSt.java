package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tb_course_st database table.
 * 
 */
@Entity
@Table(name="tb_course_st")
public class TbCourseSt implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ST_COURSE_ID")
	private String stCourseId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="BOOK_TIME")
	private Date bookTime;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CANCEL_DATE")
	private Date cancelDate;

	@Column(name="CANCEL_INFO")
	private String cancelInfo;

	@Column(name="CAR_SCORE")
	private Integer carScore;

	private String common;

	@Column(name="COURSE_ID")
	private String courseId;

	@Column(name="COURSE_NAME")
	private String courseName;

	@Column(name="COURSE_STAT")
	private String courseStat;

	@Column(name="COURSE_STAT_CODE")
	private String courseStatCode;

	@Column(name="IMPL_COURSE_STAT")
	private String implCourseStat;

	@Column(name="IMPL_COURSE_STAT_CODE")
	private String implCourseStatCode;

	@Column(name="IS_CANCEL_BOOK")
	private Integer isCancelBook;

	@Column(name="IS_NORMAL_CANCEL")
	private Integer isNormalCancel;

	@Column(name="IS_UNCARE_UNIMPL")
	private Integer isUncareUnimpl;

	@Column(name="LEARN_INFO")
	private String learnInfo;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="OVER_TIME")
	private Date overTime;

	@Column(name="SCORE_INFO")
	private String scoreInfo;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="SCORE_TIME")
	private Date scoreTime;

	@Column(name="SERVICE_SCORE")
	private Integer serviceScore;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="START_TIME")
	private Date startTime;

	@Column(name="STUDENT_ID")
	private String studentId;

	@Column(name="STUDENT_NAME")
	private String studentName;

	@Column(name="TEACHER_REPLY_INFO")
	private String teacherReplyInfo;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="TEACHER_REPLY_TIME")
	private Date teacherReplyTime;

	@Column(name="TEACHER_SCORE")
	private Integer teacherScore;

	@Column(name="UNIMPL_INFO")
	private String unimplInfo;

	public TbCourseSt() {
	}

	public String getStCourseId() {
		return this.stCourseId;
	}

	public void setStCourseId(String stCourseId) {
		this.stCourseId = stCourseId;
	}

	public Date getBookTime() {
		return this.bookTime;
	}

	public void setBookTime(Date bookTime) {
		this.bookTime = bookTime;
	}

	public Date getCancelDate() {
		return this.cancelDate;
	}

	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
	}

	public String getCancelInfo() {
		return this.cancelInfo;
	}

	public void setCancelInfo(String cancelInfo) {
		this.cancelInfo = cancelInfo;
	}

	public Integer getCarScore() {
		return this.carScore;
	}

	public void setCarScore(Integer carScore) {
		this.carScore = carScore;
	}

	public String getCommon() {
		return this.common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public String getCourseId() {
		return this.courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getCourseName() {
		return this.courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
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

	public String getImplCourseStat() {
		return this.implCourseStat;
	}

	public void setImplCourseStat(String implCourseStat) {
		this.implCourseStat = implCourseStat;
	}

	public String getImplCourseStatCode() {
		return this.implCourseStatCode;
	}

	public void setImplCourseStatCode(String implCourseStatCode) {
		this.implCourseStatCode = implCourseStatCode;
	}

	public Integer getIsCancelBook() {
		return this.isCancelBook;
	}

	public void setIsCancelBook(Integer isCancelBook) {
		this.isCancelBook = isCancelBook;
	}

	public Integer getIsNormalCancel() {
		return this.isNormalCancel;
	}

	public void setIsNormalCancel(Integer isNormalCancel) {
		this.isNormalCancel = isNormalCancel;
	}

	public Integer getIsUncareUnimpl() {
		return this.isUncareUnimpl;
	}

	public void setIsUncareUnimpl(Integer isUncareUnimpl) {
		this.isUncareUnimpl = isUncareUnimpl;
	}

	public String getLearnInfo() {
		return this.learnInfo;
	}

	public void setLearnInfo(String learnInfo) {
		this.learnInfo = learnInfo;
	}

	public Date getOverTime() {
		return this.overTime;
	}

	public void setOverTime(Date overTime) {
		this.overTime = overTime;
	}

	public String getScoreInfo() {
		return this.scoreInfo;
	}

	public void setScoreInfo(String scoreInfo) {
		this.scoreInfo = scoreInfo;
	}

	public Date getScoreTime() {
		return this.scoreTime;
	}

	public void setScoreTime(Date scoreTime) {
		this.scoreTime = scoreTime;
	}

	public Integer getServiceScore() {
		return this.serviceScore;
	}

	public void setServiceScore(Integer serviceScore) {
		this.serviceScore = serviceScore;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public String getStudentId() {
		return this.studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getStudentName() {
		return this.studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getTeacherReplyInfo() {
		return this.teacherReplyInfo;
	}

	public void setTeacherReplyInfo(String teacherReplyInfo) {
		this.teacherReplyInfo = teacherReplyInfo;
	}

	public Date getTeacherReplyTime() {
		return this.teacherReplyTime;
	}

	public void setTeacherReplyTime(Date teacherReplyTime) {
		this.teacherReplyTime = teacherReplyTime;
	}

	public Integer getTeacherScore() {
		return this.teacherScore;
	}

	public void setTeacherScore(Integer teacherScore) {
		this.teacherScore = teacherScore;
	}

	public String getUnimplInfo() {
		return this.unimplInfo;
	}

	public void setUnimplInfo(String unimplInfo) {
		this.unimplInfo = unimplInfo;
	}

}