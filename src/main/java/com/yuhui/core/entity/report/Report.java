package com.yuhui.core.entity.report;
/**
 * 
* @ClassName: Report 
* @Description:  报表实体类
* @author xiexiaozhi 
* @date 2013-11-11 下午5:34:38 
*
 */
public class Report {
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	
	private String name ;
	
	private String tempDir;
	
	private String userId;
	
	private String userName;
	
	private String id;
	
	private String url ;
	
	private String reportType;
	
	private String rptClass ;
	
	private String rptShow ;
	
	private String queryCondition ;
	
	private String groupName;
	
	private String fdfsFileName;
	
	private String isShowCondition;
	
	private String reportTypeName;
	
	private String state;
	
	private String stateDate;
	

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getReportTypeName() {
		return reportTypeName;
	}

	public void setReportTypeName(String reportTypeName) {
		this.reportTypeName = reportTypeName;
	}

	public String getIsShowCondition() {
		return isShowCondition;
	}

	public void setIsShowCondition(String isShowCondition) {
		this.isShowCondition = isShowCondition;
	}
	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getFdfsFileName() {
		return fdfsFileName;
	}

	public void setFdfsFileName(String fdfsFileName) {
		this.fdfsFileName = fdfsFileName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTempDir() {
		return tempDir;
	}

	public void setTempDir(String tempDir) {
		this.tempDir = tempDir;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getRptClass() {
		return rptClass;
	}

	public void setRptClass(String rptClass) {
		this.rptClass = rptClass;
	}

	public String getRptShow() {
		return rptShow;
	}

	public void setRptShow(String rptShow) {
		this.rptShow = rptShow;
	}

	public String getQueryCondition() {
		return queryCondition;
	}

	public void setQueryCondition(String queryCondition) {
		this.queryCondition = queryCondition;
	}

	public String getStateDate() {
		return stateDate;
	}

	public void setStateDate(String stateDate) {
		this.stateDate = stateDate;
	}
	
	
	
	
	
	
}

