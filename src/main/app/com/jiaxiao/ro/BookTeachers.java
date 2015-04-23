package com.jiaxiao.ro;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 肖长江
 * 预约教练对象
 */
public class BookTeachers {

	/**微信openId*/
	private String openId;
	/**用户是否绑定到指定学员了*/
	private boolean isBanded = false;
	/**学员编号*/
	private String studentId;
	/**用户所考的科目ID*/
	private String subjectId ;
	/**用户所考的科目名称*/
	private String subjectName ;
	/**用户所在的驾校网点ID*/
	private String branchId ;
	/**用户所在的驾校网点名称*/
	private String branchName ;
	/**用户查看的驾校网点和科目下的所有教练信息*/
	private Map<String, List<Teacher>> subjectTeachers = new HashMap<String, List<Teacher>>();
	
	
	public BookTeachers() {
		super();
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public boolean isBanded() {
		return isBanded;
	}
	public void setBanded(boolean isBanded) {
		this.isBanded = isBanded;
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
	public Map<String, List<Teacher>> getSubjectTeachers() {
		return subjectTeachers;
	}
	public void setSubjectTeachers(Map<String, List<Teacher>> subjectTeachers) {
		this.subjectTeachers = subjectTeachers;
	}
	public BookTeachers(String openId, boolean isBanded, String studentId,
			String subjectId, String subjectName, String branchId,
			String branchName,
			Map<String, List<Teacher>> subjectTeachers) {
		super();
		this.openId = openId;
		this.isBanded = isBanded;
		this.studentId = studentId;
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.branchId = branchId;
		this.branchName = branchName;
		this.subjectTeachers = subjectTeachers;
	}
	
	
}
