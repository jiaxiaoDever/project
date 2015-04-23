package com.yuhui.core.web.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.utils.Constants;
import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.report.Report;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.report.ReportService;
import com.yuhui.core.utils.LocaleUtils;
import com.yuhui.core.utils.SpringContextUtils;
import com.yuhui.core.utils.SystemInfo;
import com.yuhui.core.utils.page.Page;
import com.yuhui.core.utils.page.PageParameter;

/**
 * 
* @ClassName: ReportControllor 
* @Description:  报表列表，查看访问控制器
* @author xiexiaozhi 
* @date 2013-12-5 下午2:16:55 
*
 */
@Controller
@RequestMapping(value = "/report")
public class ReportControllor {

	@Autowired
	private ReportService reportService;
	/**
	 * 
	* @Title: index 
	* @Description: 报表入口 
	* @param  session
	* @return String    页面路径 
	* @throws
	 */
	@SuppressWarnings("unused")
	@RequestMapping("index")
	public String index(HttpSession session) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		//session.setAttribute(arg0, arg1)
		
		return "report/reports";
	}
	
	@RequestMapping("getRptTree")
	@ResponseBody
	public List<ReportTreeNode> getRptTree(String id){
		List<ReportTreeNode> list = null;
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		//id 为空，则是查询根目录
		if(id == null || "".equals(id)){
			list = new ArrayList<ReportTreeNode>();
			id = "root" ;
			ReportTreeNode root = new ReportTreeNode();
			root.setDataAttr(null);
			root.setId("root");
			root.setName("报表分类");
			root.setIsParent(true);
			root.setParentId(null);
			list.add(root);
		}
		//查询单个目录
		else {
			
			list = this.reportService.getTreeNodes(id, user==null?"":user.getId());
		}
		
		return list;
	}
	/**
	 * 
	* @Title: getGrid 
	* @Description: 根据报表目录获取报表列表 
	* @param  id
	* @return List<ReportTreeNode>    返回类型 
	* @throws
	 */
	@RequestMapping("getRptGrid")
	@ResponseBody
	public List<ReportTreeNode> getGrid(String id){
		return this.reportService.getGridData(id);
	}
	@RequestMapping("queryReportForPage")
	@ResponseBody
	public Page<ReportTreeNode> queryReportForPage(Report queryObj, int page, int rows) {
		return reportService.queryReportForPage(queryObj, page, rows);
	}
	@RequestMapping("getCountByName")
	@ResponseBody
	public AjaxResult getCountByName(String name){
		Integer count = reportService.getCountByName(name);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), count);
	}
	/**
	 * 
	* @Title: updateReport 
	* @Description: 更新报表名称
	* @param  id
	* @param  name
	* @return AjaxResult    返回类型 
	* @throws
	 */
	@RequestMapping("updateReport")
	@ResponseBody
	public AjaxResult updateReport(String id,String name,String rptShow,String rptType,String state){
		this.reportService.updateReport(id, name,rptShow,rptType,state);
		return AjaxResult.success();
	}
	
	/**
	 * 
	* @Title: deleteReport 
	* @Description: 删除报表
	* @param  id
	* @return AjaxResult    返回类型 
	* @throws
	 */
	@RequestMapping("deleteReport")
	@ResponseBody
	public AjaxResult deleteReport(String id){
		 this.reportService.deleteReport(id);
		 return AjaxResult.success();
	}
	/**
	 * 
	* @Title: deleteReport 
	* @Description: 删除报表
	* @param  id
	* @return AjaxResult    返回类型 
	* @throws
	 */
	@RequestMapping("deleteReports")
	@ResponseBody
	public AjaxResult deleteReports(String ids){
		 String [] delIds = ids.split(",");
		 this.reportService.deleteReports(delIds);
		 return AjaxResult.success();
	}
	
	/**
	 * 
	* @Title: getReportUrls 
	* @Description: 获取报表查看路径
	* @return String    返回类型 
	* @throws
	 */
	@RequestMapping("getReportUrls")
	@ResponseBody
	public String getReportUrls(){
		StringBuffer sb = new StringBuffer();
		SystemInfo si =(SystemInfo)SpringContextUtils.getBean("sysinfo");
		sb.append("{");
		sb.append("report_flat_url:").append("\""+si.getRptFlatUrl()+"\"").append(",");
		sb.append("report_ireport_url:").append("\""+si.getRptIrpUrl()+"\"").append(",");
		sb.append("report_adhoc_url:").append("\""+si.getRptAhocUrl()+"\"").append(",");
		sb.append("report_olap_url:").append("\""+si.getRptOlapUrl()+"\"");
		sb.append("}");
		return sb.toString();
	}
	
	/**
	 * 
	* @Title: createUpdateForm 
	* @Description: 报表修改表单
	* @param @param req
	* @param @return    设定文件 
	* @return String    返回类型 
	* @throws
	 */
	@RequestMapping("createUpdateForm")
	public String createUpdateForm(javax.servlet.http.HttpServletRequest req){
		String name = req.getParameter("name");
		String rptShow = req.getParameter("rpt_show");
		String rptType = req.getParameter("rpt_type");
		String rptTypeName = req.getParameter("rpt_type_name");
		String state = req.getParameter("state");
		req.setAttribute("name", name);
		req.setAttribute("rpt_show", rptShow);
		req.setAttribute("rpt_type", rptType);
		req.setAttribute("rpt_type_name", rptTypeName);
		req.setAttribute("state", state);
		return "report/updateForm";
	}
	
	/**
	 * 
	* @Title: getReportTypeTreeJson 
	* @Description: 获取报表的目录树JSON，一次性
	* @return List<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("getReportTypeTreeJson")
	@ResponseBody
	public List<HashMap> getReportTypeTreeJson(){
		
		return this.reportService.getAllReportTypeTreeJson();
	}
	
	/**
	 * 
	* @Title: toDeployForm 
	* @Description: 跳转到发布页面 
	* @param @param req
	* @return String    返回类型 
	* @throws
	 */
	@RequestMapping("toDeployForm")
	public String toDeployForm(javax.servlet.http.HttpServletRequest req){
		String pname = req.getParameter("pname");
		String pid =req.getParameter("pid");
		req.setAttribute("pname", pname);
		req.setAttribute("pid", pid);
		return "report/reportDeploy";
	}
	
	/**
	 * 
	* @Title: addReport 
	* @Description: 添加报表
	* @param @param req
	* @return AjaxResult    返回类型 
	* @throws
	 */
	@RequestMapping("addReport")
	@ResponseBody
	public AjaxResult addReport(javax.servlet.http.HttpServletRequest req){
		String name = req.getParameter("name");
		String reportType  = req.getParameter("report_type");
		
		String rptClassName = req.getParameter("rpt_class_name");
		String showType = req.getParameter("show_type") ;
		
		String url =req.getParameter("url");
		
		String state =req.getParameter("state");
		state = state==null||"".equals(state)?Constants.STATE_VALID+"":state;
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		this.reportService.addReport(user.getId(),user.getName(), name, reportType, rptClassName, showType, url, state);
		return AjaxResult.success();
	}
	
	/**
	 * 
	* @Title: getMyAgencyInfos 
	* @Description: 获取代办已办信息
	* @param @param req
	* @return Page<AgencyInfo>    返回类型 
	* @throws
	 */
	@RequestMapping("getMyAgencyInfos")
	@ResponseBody
	public Page<AgencyInfo> getMyAgencyInfos(javax.servlet.http.HttpServletRequest req){
		String p = (String)req.getParameter("page");
		String r = (String)req.getParameter("rows");
		
		int page = p==null||"".equals(p)?0:Integer.parseInt(p);
		int rows = r==null||"".equals(r)?0:Integer.parseInt(r);
		
		String flag = (String)req.getParameter("flag");
		
		
		return this.reportService.getMyAgencyInfo(flag, page, rows);
	}
	
	@RequestMapping("submitAgen")
	@ResponseBody
	public AjaxResult submitAgen(javax.servlet.http.HttpServletRequest req){
		String id = req.getParameter("id");
		String type =req.getParameter("type");
		String msg = req.getParameter("msg");
		String senderId = req.getParameter("senderId");
		String senderName = req.getParameter("senderName");
		
		this.reportService.submitAgen(id, type, msg,senderId,senderName);
		return AjaxResult.success();
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping("showAdhocReport")
	public String showAdhocReport(javax.servlet.http.HttpServletRequest req){
		String id = req.getParameter("id");
		List<HashMap> maps = this.reportService.getReportInfo(id);
		if(maps !=null && maps.size()>0){
			HashMap map = maps.get(0);
			String sql = (String)map.get("temp_dir");
			String reportJson = (String)map.get("temp_xml");
			
			req.setAttribute("sql", sql);
			req.setAttribute("json", reportJson);
			return "report/adhocReport";
		}
		
		return "report/adhocReport";
	}
	
	/**
	 * 
	* @Title: executeSql 
	* @Description: TODO(执行自定义sql) 
	* @param @param req
	* @return Page<HashMap>    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("executeSql")
	@ResponseBody
	public Page<HashMap> executeSql(javax.servlet.http.HttpServletRequest req){
		String p = (String)req.getParameter("page");
		String r = (String)req.getParameter("rows");
		
		int page = p==null||"".equals(p)?0:Integer.parseInt(p);
		int rows = r==null||"".equals(r)?0:Integer.parseInt(r);
		String sql = req.getParameter("sql");
		if(sql == null ||"".equals(sql)){
			PageParameter pages = new PageParameter();
			pages.setCurrentPage(page);
			pages.setPageSize(rows);
			return new Page<HashMap>(pages,new ArrayList<HashMap>());
		}
		return this.reportService.executeSql(sql, page, rows);
	}
	
}
