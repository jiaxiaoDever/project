package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 学员已约课程详细信息
 */
@Entity
@Table(name="tb_course_st")
public class TbCourseSt implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 学员课程编号*/
	@Id
	@Column(name="ST_COURSE_ID")
	private String stCourseId;

	/** 预约时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="BOOK_TIME")
	private Date bookTime;

	/** 取消时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CANCEL_DATE")
	private Date cancelDate;

	/** 取消原因*/
	@Column(name="CANCEL_INFO")
	private String cancelInfo;

	/** 车况评分*/
	@Column(name="CAR_SCORE")
	private Integer carScore;

	/** 备注*/
	private String common;

	/** 对应教练课程编号*/
	@Column(name="COURSE_ID")
	private String courseId;

	/** 对应教练课程名称*/
	@Column(name="COURSE_NAME")
	private String courseName;

	/** 学员课程状态*/
	@Column(name="COURSE_STAT")
	private String courseStat;

	/** 学员课程状态编码*/
	@Column(name="COURSE_STAT_CODE")
	private String courseStatCode;

	/** 履约状态*/
	@Column(name="IMPL_COURSE_STAT")
	private String implCourseStat;

	/** 履约状态编码*/
	@Column(name="IMPL_COURSE_STAT_CODE")
	private String implCourseStatCode;

	/** 是否已经取消*/
	@Column(name="IS_CANCEL_BOOK")
	private Integer isCancelBook;

	/** 是否正常取消*/
	@Column(name="IS_NORMAL_CANCEL")
	private Integer isNormalCancel;

	/** 爽约可否原谅*/
	@Column(name="IS_UNCARE_UNIMPL")
	private Integer isUncareUnimpl;

	/** 学车心得*/
	@Column(name="LEARN_INFO")
	private String learnInfo;

	/** 下课时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="OVER_TIME")
	private Date overTime;

	/** 评论内容*/
	@Column(name="SCORE_INFO")
	private String scoreInfo;

	/** 评论时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="SCORE_TIME")
	private Date scoreTime;

	/** 服务评分*/
	@Column(name="SERVICE_SCORE")
	private Integer serviceScore;

	/** 开始上课时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="START_TIME")
	private Date startTime;

	/** 学员编号*/
	@Column(name="STUDENT_ID")
	private String studentId;

	/** 学员姓名*/
	@Column(name="STUDENT_NAME")
	private String studentName;

	/** 教练回复信息*/
	@Column(name="TEACHER_REPLY_INFO")
	private String teacherReplyInfo;

	/** 教练回复时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="TEACHER_REPLY_TIME")
	private Date teacherReplyTime;

	/** 教练评分*/
	@Column(name="TEACHER_SCORE")
	private Integer teacherScore;

	/** 爽约原因*/
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