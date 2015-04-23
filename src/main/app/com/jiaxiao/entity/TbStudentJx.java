package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;

import java.util.Date;


/**
 * The persistent class for the tb_student_jx database table.
 * 
 */
@Entity
@Table(name="tb_student_jx")
public class TbStudentJx implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="STUDENT_ID")
	private String studentId;

	@Column(name="BRANCH_ID")
	private String branchId;

	@Column(name="BRANCH_NAME")
	private String branchName;

	private String city;

	private String common;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DELETE_DATE")
	private Date deleteDate;

	@Column(name="DELETE_INFO")
	private String deleteInfo;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	@Column(name="EXCEPTION_BOOK_NUM")
	private Integer exceptionBookNum;

	@Column(name="IS_BOOKED_NOTIC")
	private Integer isBookedNotic;

	@Column(name="IS_IMPL_SCORE_NOTIC")
	private Integer isImplScoreNotic;

	@Column(name="IS_PRE_IMPL_NOTIC")
	private Integer isPreImplNotic;

	@Column(name="JX_ID")
	private String jxId;

	@Column(name="JX_NAME")
	private String jxName;

	@Column(name="LICENSE_TYPE")
	private String licenseType;

	@Column(name="LICENSE_TYPE_CODE")
	private String licenseTypeCode;

	@Column(name="LOCK_INFO")
	private String lockInfo;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="LOCK_TIME")
	private Date lockTime;

	private String password;

	@Column(name="PHONE_NUM")
	private String phoneNum;

	@Column(name="PRE_IMPL_NOTIC_B_HOUR")
	private Integer preImplNoticBHour;

	private String province;

	private String qq;

	private Integer sex;
	
	@Column(name="ST_ADDRESS")
	private String stAddress;

	@Column(name="ST_AREA")
	private String stArea;

	@Column(name="ST_WORK_ADDRESS")
	private String stWorkAddress;

	@Column(name="STUDENT_CARD_ID")
	private String studentCardId;

	@Column(name="STUDENT_NAME")
	private String studentName;

	@Column(name="STUDENT_STAT")
	private String studentStat;

	@Column(name="STUDENT_STAT_CODE")
	private String studentStatCode;

	@Column(name="SUBJECT_ID")
	private String subjectId;

	@Column(name="SUBJECT_NAME")
	private String subjectName;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="UNLOCK_TIME")
	private Date unlockTime;

	@Column(name="MAX_NUM_SIGN")
	private Integer maxNumSign;
	
	@Column(name="CAN_SIGN_COURSE_NUM")
	private Integer canSignCourseNum;
	
	@Column(name="OVER_COURSE_NUM")
	private Integer overCourseNum;
	
	@Column(name="ADD_COURSE_NUM")
	private Integer addCourseNum;
	
	@Column(name="TOTAL_COURSE_NUM")
	private Integer totalCourseNum;
	
	public TbStudentJx() {
	}

	public String getStudentId() {
		return this.studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
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

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCommon() {
		return this.common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getDeleteDate() {
		return this.deleteDate;
	}

	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}

	public String getDeleteInfo() {
		return this.deleteInfo;
	}

	public void setDeleteInfo(String deleteInfo) {
		this.deleteInfo = deleteInfo;
	}

	public Date getEditDate() {
		return this.editDate;
	}

	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}

	public Integer getExceptionBookNum() {
		return this.exceptionBookNum;
	}

	public void setExceptionBookNum(Integer exceptionBookNum) {
		this.exceptionBookNum = exceptionBookNum;
	}

	public Integer getIsBookedNotic() {
		return this.isBookedNotic;
	}

	public void setIsBookedNotic(Integer isBookedNotic) {
		this.isBookedNotic = isBookedNotic;
	}

	public Integer getIsImplScoreNotic() {
		return this.isImplScoreNotic;
	}

	public void setIsImplScoreNotic(Integer isImplScoreNotic) {
		this.isImplScoreNotic = isImplScoreNotic;
	}

	public Integer getIsPreImplNotic() {
		return this.isPreImplNotic;
	}

	public void setIsPreImplNotic(Integer isPreImplNotic) {
		this.isPreImplNotic = isPreImplNotic;
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

	public String getLicenseType() {
		return this.licenseType;
	}

	public void setLicenseType(String licenseType) {
		this.licenseType = licenseType;
	}

	public String getLicenseTypeCode() {
		return this.licenseTypeCode;
	}

	public void setLicenseTypeCode(String licenseTypeCode) {
		this.licenseTypeCode = licenseTypeCode;
	}

	public String getLockInfo() {
		return this.lockInfo;
	}

	public void setLockInfo(String lockInfo) {
		this.lockInfo = lockInfo;
	}

	public Date getLockTime() {
		return this.lockTime;
	}

	public void setLockTime(Date lockTime) {
		this.lockTime = lockTime;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNum() {
		return this.phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public Integer getPreImplNoticBHour() {
		return this.preImplNoticBHour;
	}

	public void setPreImplNoticBHour(Integer preImplNoticBHour) {
		this.preImplNoticBHour = preImplNoticBHour;
	}

	public String getProvince() {
		return this.province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getStAddress() {
		return this.stAddress;
	}

	public void setStAddress(String stAddress) {
		this.stAddress = stAddress;
	}

	public String getStArea() {
		return this.stArea;
	}

	public void setStArea(String stArea) {
		this.stArea = stArea;
	}

	public String getStWorkAddress() {
		return this.stWorkAddress;
	}

	public void setStWorkAddress(String stWorkAddress) {
		this.stWorkAddress = stWorkAddress;
	}

	public String getStudentCardId() {
		return this.studentCardId;
	}

	public void setStudentCardId(String studentCardId) {
		this.studentCardId = studentCardId;
	}

	public String getStudentName() {
		return this.studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getStudentStat() {
		return this.studentStat;
	}

	public void setStudentStat(String studentStat) {
		this.studentStat = studentStat;
	}

	public String getStudentStatCode() {
		return this.studentStatCode;
	}

	public void setStudentStatCode(String studentStatCode) {
		this.studentStatCode = studentStatCode;
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

	public Date getUnlockTime() {
		return this.unlockTime;
	}

	public void setUnlockTime(Date unlockTime) {
		this.unlockTime = unlockTime;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getMaxNumSign() {
		return maxNumSign;
	}

	public void setMaxNumSign(Integer maxNumSign) {
		this.maxNumSign = maxNumSign;
	}

	public Integer getCanSignCourseNum() {
		return canSignCourseNum;
	}

	public void setCanSignCourseNum(Integer canSignCourseNum) {
		this.canSignCourseNum = canSignCourseNum;
	}

	public Integer getOverCourseNum() {
		return overCourseNum;
	}

	public void setOverCourseNum(Integer overCourseNum) {
		this.overCourseNum = overCourseNum;
	}

	public Integer getAddCourseNum() {
		return addCourseNum;
	}

	public void setAddCourseNum(Integer addCourseNum) {
		this.addCourseNum = addCourseNum;
	}

	public Integer getTotalCourseNum() {
		return totalCourseNum;
	}

	public void setTotalCourseNum(Integer totalCourseNum) {
		this.totalCourseNum = totalCourseNum;
	}

	public TbStudentJx(String studentId, String branchId, String branchName,
			String city, String common, Date createDate, Date deleteDate,
			String deleteInfo, Date editDate, Integer exceptionBookNum,
			Integer isBookedNotic, Integer isImplScoreNotic,
			Integer isPreImplNotic, String jxId, String jxName,
			String licenseType, String licenseTypeCode, String lockInfo,
			Date lockTime, String password, String phoneNum,
			Integer preImplNoticBHour, String province, String qq, Integer sex,
			String stAddress, String stArea, String stWorkAddress,
			String studentCardId, String studentName, String studentStat,
			String studentStatCode, String subjectId, String subjectName,
			Date unlockTime, Integer maxNumSign, Integer canSignCourseNum,
			Integer overCourseNum, Integer addCourseNum, Integer totalCourseNum) {
		super();
		this.studentId = studentId;
		this.branchId = branchId;
		this.branchName = branchName;
		this.city = city;
		this.common = common;
		this.createDate = createDate;
		this.deleteDate = deleteDate;
		this.deleteInfo = deleteInfo;
		this.editDate = editDate;
		this.exceptionBookNum = exceptionBookNum;
		this.isBookedNotic = isBookedNotic;
		this.isImplScoreNotic = isImplScoreNotic;
		this.isPreImplNotic = isPreImplNotic;
		this.jxId = jxId;
		this.jxName = jxName;
		this.licenseType = licenseType;
		this.licenseTypeCode = licenseTypeCode;
		this.lockInfo = lockInfo;
		this.lockTime = lockTime;
		this.password = password;
		this.phoneNum = phoneNum;
		this.preImplNoticBHour = preImplNoticBHour;
		this.province = province;
		this.qq = qq;
		this.sex = sex;
		this.stAddress = stAddress;
		this.stArea = stArea;
		this.stWorkAddress = stWorkAddress;
		this.studentCardId = studentCardId;
		this.studentName = studentName;
		this.studentStat = studentStat;
		this.studentStatCode = studentStatCode;
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.unlockTime = unlockTime;
		this.maxNumSign = maxNumSign;
		this.canSignCourseNum = canSignCourseNum;
		this.overCourseNum = overCourseNum;
		this.addCourseNum = addCourseNum;
		this.totalCourseNum = totalCourseNum;
	}

}