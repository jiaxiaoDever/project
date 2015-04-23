package com.yuhui.core.entity.report;

/**
 * 
* @ClassName: ReportNode 
* @Description:  报表评论实体
* @author xiexiaozhi 
* @date 2014-2-19 下午1:55:36 
*
 */
public class ReportNode {

	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	
	private String id;
	
	private String userId;
	
	private String userName;
	
	private String reportId;
	
	private String leftTime;
	
	private String noteMsg ;
	
	private String remark;
	
	private String receiveId;
	
	private String receiveName;
	
	private String singedUser;
	
	private String deleteUser;
	
	private String messageUrl;
	
	private String rptState;
	
	private String stateDesc;
	
	private int isReport;
	
	private String name;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getReportId() {
		return reportId;
	}

	public void setReportId(String reportId) {
		this.reportId = reportId;
	}

	public String getLeftTime() {
		return leftTime;
	}

	public void setLeftTime(String leftTime) {
		this.leftTime = leftTime;
	}

	public String getNoteMsg() {
		return noteMsg;
	}

	public void setNoteMsg(String noteMsg) {
		this.noteMsg = noteMsg;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(String receiveId) {
		this.receiveId = receiveId;
	}

	public String getReceiveName() {
		return receiveName;
	}

	public void setReceiveName(String receiveName) {
		this.receiveName = receiveName;
	}

	public String getSingedUser() {
		return singedUser;
	}

	public void setSingedUser(String singedUser) {
		this.singedUser = singedUser;
	}

	public String getDeleteUser() {
		return deleteUser;
	}

	public void setDeleteUser(String deleteUser) {
		this.deleteUser = deleteUser;
	}

	public String getMessageUrl() {
		return messageUrl;
	}

	public void setMessageUrl(String messageUrl) {
		this.messageUrl = messageUrl;
	}

	public String getRptState() {
		return rptState;
	}

	public void setRptState(String rptState) {
		this.rptState = rptState;
	}

	public String getStateDesc() {
		return stateDesc;
	}

	public void setStateDesc(String stateDesc) {
		this.stateDesc = stateDesc;
	}

	public int getIsReport() {
		return isReport;
	}

	public void setIsReport(int isReport) {
		this.isReport = isReport;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
