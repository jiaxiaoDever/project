package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tb_teacher_jx database table.
 * 
 */
@Entity
@Table(name="tb_teacher_jx")
public class TbTeacherJx implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="TEACHER_ID")
	private String teacherId;

	@Column(name="BIRTH_DATE")
	private String birthDate;

	@Column(name="BRANCH_ID")
	private String branchId;

	@Column(name="BRANCH_NAME")
	private String branchName;

	@Column(name="CHECK_NUM")
	private Integer checkNum;

	private String city;

	private String common;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	@Column(name="DUTE_AGE")
	private Integer duteAge;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DUTE_DATE")
	private Date duteDate;

	@Column(name="DUTE_LEVEL")
	private String duteLevel;

	@Column(name="DUTE_LEVEL_CODE")
	private String duteLevelCode;

	@Column(name="DUTE_LEVEL_NO")
	private String duteLevelNo;

	@Column(name="DUTE_LEVEL_PIC")
	private String duteLevelPic;

	@Column(name="DUTE_STAT")
	private String duteStat;

	@Column(name="DUTE_STAT_CODE")
	private String duteStatCode;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	@Column(name="IS_COURSE_NOTIC")
	private Integer isCourseNotic;

	@Column(name="IS_FULL_TIME")
	private Integer isFullTime;

	@Column(name="IS_HOT")
	private Integer isHot;

	@Column(name="IS_ON_DUTE")
	private Integer isOnDute;

	@Column(name="IS_ROAST_NOTIC")
	private Integer isRoastNotic;

	@Column(name="JX_ID")
	private String jxId;

	@Column(name="JX_NAME")
	private String jxName;

	@Column(name="LIKE_NUM")
	private Integer likeNum;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="NEAR_DUTE_DATE")
	private Date nearDuteDate;

	@Column(name="CARD_ID")
	private String cardId;

	private String province;

	private Integer score;

	@Column(name="SCORE_NUM")
	private Integer scoreNum;

	private Integer sex;

	@Column(name="STUDENT_NUM")
	private Integer studentNum;

	@Column(name="SUBJECT_ID")
	private String subjectId;

	@Column(name="SUBJECT_NAME")
	private String subjectName;

	@Column(name="TEA_ADDRESS")
	private String teaAddress;

	@Column(name="TEA_ETHNIC")
	private String teaEthnic;

	@Column(name="TEA_LOGO")
	private String teaLogo;

	@Column(name="TEA_NATIVE")
	private String teaNative;

	@Column(name="TEA_PHONE")
	private String teaPhone;

	@Column(name="TEA_QQ")
	private String teaQq;

	@Column(name="TEA_TEL")
	private String teaTel;

	@Column(name="TEACHER_AREA")
	private String teacherArea;

	@Column(name="TEACHER_NAME")
	private String teacherName;

	public TbTeacherJx() {
	}

	public String getTeacherId() {
		return this.teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	public String getBirthDate() {
		return this.birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
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

	public Integer getCheckNum() {
		return this.checkNum;
	}

	public void setCheckNum(Integer checkNum) {
		this.checkNum = checkNum;
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

	public Integer getDuteAge() {
		return this.duteAge;
	}

	public void setDuteAge(Integer duteAge) {
		this.duteAge = duteAge;
	}

	public Date getDuteDate() {
		return this.duteDate;
	}

	public void setDuteDate(Date duteDate) {
		this.duteDate = duteDate;
	}

	public String getDuteLevel() {
		return this.duteLevel;
	}

	public void setDuteLevel(String duteLevel) {
		this.duteLevel = duteLevel;
	}

	public String getDuteLevelCode() {
		return this.duteLevelCode;
	}

	public void setDuteLevelCode(String duteLevelCode) {
		this.duteLevelCode = duteLevelCode;
	}

	public String getDuteLevelNo() {
		return this.duteLevelNo;
	}

	public void setDuteLevelNo(String duteLevelNo) {
		this.duteLevelNo = duteLevelNo;
	}

	public String getDuteLevelPic() {
		return this.duteLevelPic;
	}

	public void setDuteLevelPic(String duteLevelPic) {
		this.duteLevelPic = duteLevelPic;
	}

	public String getDuteStat() {
		return this.duteStat;
	}

	public void setDuteStat(String duteStat) {
		this.duteStat = duteStat;
	}

	public String getDuteStatCode() {
		return this.duteStatCode;
	}

	public void setDuteStatCode(String duteStatCode) {
		this.duteStatCode = duteStatCode;
	}

	public Date getEditDate() {
		return this.editDate;
	}

	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}

	public Integer getIsCourseNotic() {
		return this.isCourseNotic;
	}

	public void setIsCourseNotic(Integer isCourseNotic) {
		this.isCourseNotic = isCourseNotic;
	}

	public Integer getIsFullTime() {
		return this.isFullTime;
	}

	public void setIsFullTime(Integer isFullTime) {
		this.isFullTime = isFullTime;
	}

	public Integer getIsHot() {
		return this.isHot;
	}

	public void setIsHot(Integer isHot) {
		this.isHot = isHot;
	}

	public Integer getIsOnDute() {
		return this.isOnDute;
	}

	public void setIsOnDute(Integer isOnDute) {
		this.isOnDute = isOnDute;
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

	public Integer getLikeNum() {
		return this.likeNum;
	}

	public void setLikeNum(Integer likeNum) {
		this.likeNum = likeNum;
	}

	public Date getNearDuteDate() {
		return this.nearDuteDate;
	}

	public void setNearDuteDate(Date nearDuteDate) {
		this.nearDuteDate = nearDuteDate;
	}

	public String getCardId() {
		return this.cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}

	public String getProvince() {
		return this.province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public Integer getScore() {
		return this.score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getScoreNum() {
		return this.scoreNum;
	}

	public void setScoreNum(Integer scoreNum) {
		this.scoreNum = scoreNum;
	}

	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Integer getStudentNum() {
		return this.studentNum;
	}

	public void setStudentNum(Integer studentNum) {
		this.studentNum = studentNum;
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

	

	public String getTeaAddress() {
		return teaAddress;
	}

	public void setTeaAddress(String teaAddress) {
		this.teaAddress = teaAddress;
	}

	public String getTeaEthnic() {
		return teaEthnic;
	}

	public void setTeaEthnic(String teaEthnic) {
		this.teaEthnic = teaEthnic;
	}

	public String getTeaLogo() {
		return teaLogo;
	}

	public void setTeaLogo(String teaLogo) {
		this.teaLogo = teaLogo;
	}

	public String getTeaNative() {
		return teaNative;
	}

	public void setTeaNative(String teaNative) {
		this.teaNative = teaNative;
	}

	public String getTeaPhone() {
		return teaPhone;
	}

	public void setTeaPhone(String teaPhone) {
		this.teaPhone = teaPhone;
	}

	public String getTeaQq() {
		return teaQq;
	}

	public void setTeaQq(String teaQq) {
		this.teaQq = teaQq;
	}

	public String getTeacherArea() {
		return this.teacherArea;
	}

	public void setTeacherArea(String teacherArea) {
		this.teacherArea = teacherArea;
	}

	public String getTeacherName() {
		return this.teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getTeaTel() {
		return teaTel;
	}

	public void setTeaTel(String teaTel) {
		this.teaTel = teaTel;
	}

	public TbTeacherJx(String teacherId, String birthDate, String branchId,
			String branchName, Integer checkNum, String city, String common,
			Date createDate, Integer duteAge, Date duteDate, String duteLevel,
			String duteLevelCode, String duteLevelNo, String duteLevelPic,
			String duteStat, String duteStatCode, Date editDate,
			Integer isCourseNotic, Integer isFullTime, Integer isHot,
			Integer isOnDute, Integer isRoastNotic, String jxId, String jxName,
			Integer likeNum, Date nearDuteDate, String cardId, String province,
			Integer score, Integer scoreNum, Integer sex, Integer studentNum,
			String subjectId, String subjectName, String teaAddress,
			String teaEthnic, String teaLogo, String teaNative, String teaPhone,
			String teaQq, String teaTel, String teacherArea, String teacherName) {
		super();
		this.teacherId = teacherId;
		this.birthDate = birthDate;
		this.branchId = branchId;
		this.branchName = branchName;
		this.checkNum = checkNum;
		this.city = city;
		this.common = common;
		this.createDate = createDate;
		this.duteAge = duteAge;
		this.duteDate = duteDate;
		this.duteLevel = duteLevel;
		this.duteLevelCode = duteLevelCode;
		this.duteLevelNo = duteLevelNo;
		this.duteLevelPic = duteLevelPic;
		this.duteStat = duteStat;
		this.duteStatCode = duteStatCode;
		this.editDate = editDate;
		this.isCourseNotic = isCourseNotic;
		this.isFullTime = isFullTime;
		this.isHot = isHot;
		this.isOnDute = isOnDute;
		this.isRoastNotic = isRoastNotic;
		this.jxId = jxId;
		this.jxName = jxName;
		this.likeNum = likeNum;
		this.nearDuteDate = nearDuteDate;
		this.cardId = cardId;
		this.province = province;
		this.score = score;
		this.scoreNum = scoreNum;
		this.sex = sex;
		this.studentNum = studentNum;
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.teaAddress = teaAddress;
		this.teaEthnic = teaEthnic;
		this.teaLogo = teaLogo;
		this.teaNative = teaNative;
		this.teaPhone = teaPhone;
		this.teaQq = teaQq;
		this.teaTel = teaTel;
		this.teacherArea = teacherArea;
		this.teacherName = teacherName;
	}

}