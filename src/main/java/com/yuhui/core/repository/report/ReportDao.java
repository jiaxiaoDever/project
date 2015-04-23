package com.yuhui.core.repository.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.yuhui.core.repository.mybatis.MyBatisRepository;
import com.yuhui.core.utils.page.PageParameter;

@Repository("reportDao")
@MyBatisRepository()
public interface ReportDao {

	/**
	 * 
	* @Title: getReportTypeTreeNodes 
	* @Description: 获取报表目录 
	* @param  id
	* @param  userId
	* @return List<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportTypeTreeNodes(@Param(value="parameters") Map<String, Object> parameters);
	
	/**
	 * 
	* @Title: getAllReportTypeTreeNodes 
	* @Description: 获取所有报表目录
	* @return List<HashMap>    返回类型 
	* @throws
	*/
	@SuppressWarnings("rawtypes")
	public List<HashMap> getAllReportTypeTreeNodes(String userId);
	
	/**
	 * 
	* @Title: getReportTreeNodes 
	* @Description: 获取目录下的报表 
	* @param  id
	* @return List<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportTreeNodes(String id);
	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportTreeNodesForPage(PageParameter page,@Param(value="parameters")Map<String,Object> parameters);
	public int queryTreeNodesCount(@Param(value="parameters") Map<String, Object> parameters);
    /**
     * 
    * @Title: getAllReports 
    * @Description: 获取所以报表
    * @param @return    设定文件 
    * @return List<HashMap>    返回类型 
    * @throws
     */
	
	@SuppressWarnings("rawtypes")
	public List<HashMap> getAllReports(String userId);
	@SuppressWarnings("rawtypes")
	public List<HashMap> getAllReportsForPage(PageParameter page,@Param(value="parameters")Map<String,Object> parameters);
	public int queryRootReportCount(@Param(value="parameters") Map<String, Object> parameters);
	/**
	 * 
	* @Title: updateReport 
	* @Description: 修改报表名称
	* @param  id 报表ID
	* @param  name 修改后的名称
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean updateReportName(@Param(value="parameters") Map<String, Object> parameters);
	
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
	* @Description: 删除报表,可支持多个删除多个 ，目前不删除文件
	* @param  parameters 存放数组
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean deleteReports(@Param(value="parameters") Map<String, Object> parameters);
	/**
	 * 
	* @Title: addDir 
	* @Description: 添加报表目录
	* @param @param id
	* @param @param name
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean addDir(@Param(value="parameters") Map<String, Object> parameters);
	/**
	 * 
	* @Title: editDir 
	* @Description: 修改目录名称
	* @param @param id
	* @param @param name
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean editDir(@Param(value="parameters") Map<String, Object> parameters);
	
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
	* @param @param parameters
	* @return boolean    返回类型 
	* @throws
	 */
	public boolean addReport(@Param(value="parameters") Map<String, Object> parameters);
	
	/**
	 * 
	* @Title: checkDir 
	* @Description: 检查是否有同一目录下同名的目录
	* @param @param parameters
	* @return int    返回类型 
	* @throws
	 */
	public int checkDir(@Param(value="parameters") Map<String, Object> parameters);
	
	public int checkEditDir(@Param(value="parameters") Map<String, Object> parameters);
	
	public boolean addReportNote(@Param(value="parameters") Map<String, Object> parameters);
	
	public boolean addReportMessage(@Param(value="parameters") Map<String, Object> parameters);
	
	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportNotes(String reportId);
	
	@SuppressWarnings("rawtypes")
	public List<HashMap>  getMyAgencyInfo(PageParameter page,@Param(value="parameters") Map<String,Object> parameters);
	
	@SuppressWarnings("rawtypes")
	public List<HashMap> getMyAgenciedInfo(PageParameter page,@Param(value="parameters") Map<String,Object> parameters);
	
	
	public boolean submitAgen(@Param(value="parameters") Map<String, Object> parameters);
	
	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportInfo(String reportId);
	
	
	@SuppressWarnings("rawtypes")
	public List<HashMap> executeReportSql(PageParameter page,@Param(value="parameters") Map<String,Object> parameters);
	
	public Integer getCountByName(String name);
}
