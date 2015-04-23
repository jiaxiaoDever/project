package com.yuhui.core.service.report;

import java.util.HashMap;
import java.util.List;

import com.yuhui.core.entity.report.Report;
import com.yuhui.core.utils.page.Page;
import com.yuhui.core.web.report.AgencyInfo;
import com.yuhui.core.web.report.NoteVo;
import com.yuhui.core.web.report.ReportTreeNode;
/**
 * 
* @ClassName: ReportService 
* @Description:  报表服务接口
* @author xiexiaozhi 
* @date 2013-12-6 上午11:21:04 
*
 */
public interface ReportService {

	/**
	 * 
	* @Title: getTreeNodes 
	* @Description: 获取报表目录以及目录下的报表 
	* @param  id	目录ID
	* @param  userId 用户ID
	* @return List<ReportTreeNode>    返回类型 
	* @throws
	 */
	public List<ReportTreeNode> getTreeNodes(String id,String userId);
	
	/**
	 * 
	* @Title: getAllReportTypeTreeJson 
	* @Description: 获取所有报表目录树
	* @return List<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	public List<HashMap> getAllReportTypeTreeJson();
	
	/**
	 * 
	* @Title: getGridData 
	* @Description: 获取报表列表
	* @param  id
	* @return List<ReportTreeNode>    返回类型 
	* @throws
	 */
	public List<ReportTreeNode> getGridData(String id);
	
	public Page<ReportTreeNode> queryReportForPage(Report report, int pageNumber, int pageSize) ;
	/**
	 * 
	* @Title: updateReport 
	* @Description: 修改报表名称
	* @param  id 报表ID
	* @param  name 修改后的名称
	* @param  rptShow 修改后的显示方式
	* @param  rptType 修改后的目录
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean updateReport(String id ,String name,String rptShow,String rptType,
			String state);
	
	/**
	 * 
	* @Title: deleteReport 
	* @Description: 删除报表 ，目前不删除文件
	* @param  id
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean deleteReport(String id);
	
	/**
	 * 
	* @Title: deleteReports 
	* @Description: 删除报表,可支持多个,数组形式 ，目前不删除文件
	* @param  ids
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean deleteReports(String [] ids);
	/**
	 * 
	* @Title: addDir 
	* @Description: 添加报表目录
	* @param @param id
	* @param @param name
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean addDir(String id,String name,String userId,String userName,String privilege);
	/**
	 * 
	* @Title: editDir 
	* @Description: 修改目录名称
	* @param @param id
	* @param @param name
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean editDir(String id,String name);
	
	/**
	 * 
	* @Title: deleteDir 
	* @Description: 删除目录
	* @param @param id
	* @param @return    设定文件 
	* @throws
	 */
	public boolean deleteDir(String id);
	
	/**
	 * 
	* @Title: addReport 
	* @Description: 添加报表
	* @param @param name
	* @param @param reportType
	* @param @param rptClassName
	* @param @param showType
	* @param @param url
	* @param @param state
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean addReport(String userId,String userName,String name,String reportType,String rptClassName,String showType,
			String url,String state);
	
	/**
	 * 
	* @Title: checkDir 
	* @Description: TODO(check report type node) 
	* @param @param id
	* @param @param name
	* @param @param act
	* @return int    返回类型 
	* @throws
	 */
	public int checkDir(String id ,String name,String act);
	
	/**
	 * 
	* @Title: saveNote 
	* @Description: TODO(保存转发评论) 
	* @param @param reportId
	* @param @param receiveId
	* @param @param receiveName
	* @param @param msg
	* @param @param type
	* @param @param url
	* @param @param name
	* @return NoteVo    返回类型 
	* @throws
	 */
	public NoteVo saveNote(String reportId,String receiveId,String receiveName,String msg,
			String type,String url,String name);
	
	/**
	 * 
	* @Title: getReportNotes 
	* @Description: TODO(获取报表的评论转发消息) 
	* @param @param reportId
	* @param @return    设定文件 
	* @return List<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportNotes(String reportId);
	
	/**
	 * 
	* @Title: getMyAgencyInfo 
	* @Description: TODO(获取个人待办信息) 
	* @param @param flag
	* @param @param pageNumber
	* @param @param pageSize
	* @return Page<AgencyInfo>    返回类型 
	* @throws
	 */
	public Page<AgencyInfo> getMyAgencyInfo(String flag ,int pageNumber, int pageSize);
	
	/**
	 * 
	* @Title: submitAgen 
	* @Description: TODO(提交批阅信息) 
	* @param @param id
	* @param @param type
	* @param @param msg
	* @param @return    设定文件 
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean submitAgen(String id,String type,String msg,String senderId,String senderName);
	
	/**
	 * 
	* @Title: getReportInfo 
	* @Description: TODO(获取报表基本信息) 
	* @param @param reportId
	* @return List<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportInfo(String reportId);
	
	/**
	 * 
	* @Title: executeSql 
	* @Description: TODO(执行sql) 
	* @param @param sql
	* @param @return    设定文件 
	* @return Page<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	public Page<HashMap> executeSql(String sql,int pageNumber, int pageSize);
	/**
	 * 判断是否有重复的报表名称
	 * @param name 报表名称
	 * @return 个数
	 */
	public Integer getCountByName(String name);
}
