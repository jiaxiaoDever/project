package com.yuhui.core.service.report.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.entity.report.Report;
import com.yuhui.core.repository.report.ReportDao;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.report.ReportService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.utils.SqlUtils;
import com.yuhui.core.utils.UUID;
import com.yuhui.core.utils.page.Page;
import com.yuhui.core.utils.page.PageParameter;
import com.yuhui.core.web.report.AgencyInfo;
import com.yuhui.core.web.report.NoteVo;
import com.yuhui.core.web.report.ReportTreeNode;

/**
 * 
 * @ClassName: ReportServiceImpl
 * @Description: 报表服务实现类
 * @author xiexiaozhi
 * @date 2013-12-6 上午10:56:27
 * 
 */
@Service(value = "reportService")
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;

	/**
	 * @Title: getTreeNodes
	 * @Description: 获取报表目录以及目录下的报表
	 * @param id
	 *            目录ID
	 * @param userId
	 *            用户ID
	 * @return List<ReportTreeNode> 返回类型
	 * @throws
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List<ReportTreeNode> getTreeNodes(String id, String userId) {

		List<ReportTreeNode> results = new ArrayList<ReportTreeNode>();

		HashMap map = null;

		ReportTreeNode node = null;

		// 处理目录信息
		Map<String, Object> paraMap = new HashMap<String, Object>();

		paraMap.put("id", id);

		paraMap.put("userId", userId);

		List<HashMap> dirList = this.reportDao.getReportTypeTreeNodes(paraMap);

		if (dirList != null && dirList.size() > 0) {

			for (int i = 0, size = dirList.size(); i < size; i++) {

				map = dirList.get(i);

				node = new ReportTreeNode();

				results.add(this.genReportTypeNode(node, map));

			}

			dirList.clear();
			dirList = null;
		}

		// 处理报表
		List<HashMap> reportList = this.reportDao.getReportTreeNodes(id);

		if (reportList != null && reportList.size() > 0) {

			for (int i = 0, size = reportList.size(); i < size; i++) {

				map = reportList.get(i);

				node = new ReportTreeNode();

				results.add(this.genReportNode(node, map, id));

			}

			reportList.clear();
			reportList = null;
		}

		return results;
	}

	/**
	 * 
	 * @Title: getGridData
	 * @Description: 获取报表列表
	 * @param id
	 * @return List<ReportTreeNode> 返回类型
	 * @throws
	 */
	@SuppressWarnings("rawtypes")
	public List<ReportTreeNode> getGridData(String id) {
		List<ReportTreeNode> results = new ArrayList<ReportTreeNode>();
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap map = null;

		ReportTreeNode node = null;

		List<HashMap> reportList = null;

		// 处理报表
		if ("-1".equals(id) || "root".equals(id)) {
			reportList = this.reportDao.getAllReports(user.getId());
		} else {
			reportList = this.reportDao.getReportTreeNodes(id);
		}

		if (reportList != null && reportList.size() > 0) {

			for (int i = 0, size = reportList.size(); i < size; i++) {

				map = reportList.get(i);

				node = new ReportTreeNode();

				results.add(this.genReportNode(node, map, id));

			}

			reportList.clear();
			reportList = null;
		}

		return results;
	}

	@SuppressWarnings("rawtypes")
	public Page<ReportTreeNode> queryReportForPage(Report report, int pageNumber, int pageSize) {
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);

		List<ReportTreeNode> results = new ArrayList<ReportTreeNode>();
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		HashMap map = null;

		ReportTreeNode node = null;

		List<HashMap> reportList = null;
		Map<String, Object> paraMap = new HashMap<String, Object>();
		int countnum = 0;
		if (StringUtils.isNotBlank(report.getName())) {
			paraMap.put("name", "%" + report.getName() + "%");
		}
		paraMap.put("rptShow", report.getRptShow());
		paraMap.put("state", report.getState());
		// 处理报表
		if ("-1".equals(report.getId()) || "root".equals(report.getId()) || StringUtils.isBlank(report.getId())) {
			paraMap.put("id", user.getId());
			reportList = this.reportDao.getAllReportsForPage(page, paraMap);
			countnum = this.reportDao.queryRootReportCount(paraMap);
		} else {
			paraMap.put("id", report.getId());
			reportList = this.reportDao.getReportTreeNodesForPage(page, paraMap);
			countnum = this.reportDao.queryTreeNodesCount(paraMap);
		}

		if (reportList != null && reportList.size() > 0) {

			for (int i = 0, size = reportList.size(); i < size; i++) {

				map = reportList.get(i);

				node = new ReportTreeNode();

				results.add(this.genReportNode(node, map, report.getId()));

			}

			reportList.clear();
			reportList = null;
		}

		page.setTotalCount(countnum);
		int totalPage = countnum / page.getPageSize() + ((countnum % page.getPageSize() == 0) ? 0 : 1);
		page.setTotalPage(totalPage);
		Page<ReportTreeNode> result = new Page<ReportTreeNode>(page, results);
		return result;
	}

	@SuppressWarnings({ "rawtypes" })
	private ReportTreeNode genReportTypeNode(ReportTreeNode node, HashMap typeMap) {
		if (typeMap != null) {
			String fomatter = Integer.parseInt(typeMap.get(this.getKey("PRIVILEGE")).toString()) == 0 ? "公有" : "私有";
			node.setId((String) typeMap.get(this.getKey("ID")));
			node.setName((String) typeMap.get(this.getKey("NAME")) + "(" + fomatter + ")");
			node.setParentId((String) typeMap.get(this.getKey("PARENT_ID")));
			node.setPrivilege("" + typeMap.get(this.getKey("PRIVILEGE")));
			node.setIsParent(true);
			node.setDataAttr(null);
		}
		return node;
	}

	@SuppressWarnings("rawtypes")
	private ReportTreeNode genReportNode(ReportTreeNode node, HashMap reportMap, String parentId) {
		if (reportMap != null) {
			node.setId((String) reportMap.get(this.getKey("ID")));
			node.setName((String) reportMap.get(this.getKey("NAME")));
			node.setParentId(parentId);
			node.setIsParent(false);
			Report r = new Report();
			r.setId(node.getId());
			r.setName(node.getName());
			r.setReportType((String) reportMap.get(this.getKey("REPORT_TYPE")));
			r.setReportTypeName((String) reportMap.get(this.getKey("REPORT_TYPE_NAME")));
			r.setRptClass((String) reportMap.get(this.getKey("RPT_CLASS")));
			r.setRptShow((String) reportMap.get(this.getKey("RPT_SHOW")));
			r.setUrl((String) reportMap.get(this.getKey("URL")));
			r.setQueryCondition((String) reportMap.get(this.getKey("QUERY_CONDITION")));
			r.setTempDir((String) reportMap.get(this.getKey("TEMP_DIR")));
			r.setFdfsFileName((String) reportMap.get(this.getKey("FDFS_FILENAME")));
			r.setGroupName((String) reportMap.get(this.getKey("GROUP_NAME")));
			r.setState((String) reportMap.get(this.getKey("STATE")));
			r.setStateDate(reportMap.get(this.getKey("STATE_DATE")) + "");
			r.setUserId((String) reportMap.get(this.getKey("USER_ID")));
			r.setUserName((String) reportMap.get(this.getKey("USER_NAME")));
			node.setDataAttr(r);
		}
		return node;
	}

	@Override
	@Transactional(readOnly = false)
	public boolean updateReport(String id, String name, String rptShow, String rptType, String state) {
		Map<String, Object> paraMap = new HashMap<String, Object>();

		paraMap.put("id", id);

		paraMap.put("name", name);
		paraMap.put("rptShow", rptShow);
		paraMap.put("rptType", rptType);
		paraMap.put("state", state);

		return this.reportDao.updateReportName(paraMap);
	}

	@Override
	@Transactional(readOnly = false)
	public boolean deleteReport(String id) {
		return this.reportDao.deleteReport(id);
	}

	@Override
	@Transactional(readOnly = false)
	public boolean deleteReports(String[] ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		return this.reportDao.deleteReports(map);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<HashMap> getAllReportTypeTreeJson() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		List<HashMap> all = (List<HashMap>) CacheUtils.get(Constants.CACHE_REPORT_TREE);

		if (all == null || all.size() == 0) {
			all = this.reportDao.getAllReportTypeTreeNodes(user.getId());
			// CacheUtils.set(Constants.CACHE_REPORT_TREE, all);

		}

		return all;
	}

	private String getKey(String key) {
		return SqlUtils.getResultKey(key);
	}

	@Override
	public boolean addDir(String id, String name, String userId, String userName, String privilege) {
		Map<String, Object> paraMap = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = new java.util.Date();
		String str = sdf.format(date);
		String uid = UUID.Gen_UUID();

		paraMap.put("id", uid);

		paraMap.put("name", name);

		paraMap.put("parent_id", id);
		paraMap.put("description", name);
		paraMap.put("state", Constants.STATE_VALID);
		paraMap.put("state_date", str);
		paraMap.put("sort", 1);
		paraMap.put("privilege", privilege);
		paraMap.put("userId", userId);
		paraMap.put("userName", userName);

		boolean f = this.reportDao.addDir(paraMap);

		this.reflush();

		return f;
	}

	@Override
	public boolean editDir(String id, String name) {
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("id", id);

		paraMap.put("name", name);

		boolean f = this.reportDao.editDir(paraMap);

		this.reflush();

		return f;
	}

	@Override
	public boolean deleteDir(String id) {

		boolean f = this.reportDao.deleteDir(id);

		this.reflush();

		return f;
	}

	private void reflush() {
		CacheUtils.set(Constants.CACHE_REPORT_TREE, null);
	}

	@Override
	public boolean addReport(String userId, String userName, String name, String reportType, String rptClassName, String showType, String url, String state) {
		Map<String, Object> paraMap = new HashMap<String, Object>();

		String uid = UUID.Gen_UUID();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = new java.util.Date();
		String str = sdf.format(date);

		paraMap.put("id", uid);
		paraMap.put("name", name);
		paraMap.put("temp_dir", url);
		paraMap.put("user_id", userId);
		paraMap.put("url", url);
		paraMap.put("state", state);
		paraMap.put("state_date", str);
		paraMap.put("report_type", reportType);
		paraMap.put("sort", 1);
		paraMap.put("rpt_class", rptClassName);
		paraMap.put("rpt_show", showType);
		paraMap.put("user_name", userName);

		return this.reportDao.addReport(paraMap);
	}

	@Override
	public int checkDir(String id, String name, String act) {
		Map<String, Object> paraMap = new HashMap<String, Object>();
		if ("new".equals(act)) {
			paraMap.put("parent_id", id);

			paraMap.put("name", name);
			return this.reportDao.checkDir(paraMap);
		} else {

			paraMap.put("name", name);
			paraMap.put("id", id);
			return this.reportDao.checkEditDir(paraMap);
		}
	}

	@SuppressWarnings("unused")
	@Override
	public NoteVo saveNote(String reportId, String receiveId, String receiveName, String msg, String type, String url, String name) {
		Map<String, Object> paraMap = new HashMap<String, Object>();
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date date = new java.util.Date();
		String str = sdf.format(date);

		// 如果是转发

		String uid = UUID.Gen_UUID();
		paraMap.put("id", uid);
		paraMap.put("name", name);
		paraMap.put("leftTime", str);
		paraMap.put("reportId", reportId);
		paraMap.put("userId", user.getId());
		paraMap.put("userName", user.getName());
		paraMap.put("receiveId", receiveId);
		paraMap.put("receiveName", receiveName);
		paraMap.put("msg", msg);
		paraMap.put("url", url);
		paraMap.put("type", type);
		paraMap.put("state", 0);

		paraMap.put("reportState", "SOA");

		this.reportDao.addReportNote(paraMap);

		Map<String, Object> param = null;
		if (!"0".equals(type) && receiveId != null && !"".equals(receiveId)) {
			String[] arr = receiveId.split(",");
			String[] arrName = receiveName.split(",");
			uid = UUID.Gen_UUID();

			param = new HashMap<String, Object>();

			param.put("name", name);
			param.put("state_date", str);
			param.put("rpt_id", reportId);
			param.put("sender_id", user.getId());
			param.put("sender_name", user.getName());

			param.put("receive_state", "SOA");
			param.put("content", msg);
			param.put("messageurl", url);
			param.put("is_report", type);
			param.put("is_read", 0);
			param.put("state_desc", msg);

			param.put("send_state", "SOA");
			param.put("state", "SOA");

			for (int i = 0; i < arr.length; i++) {

				uid = UUID.Gen_UUID();
				param.remove("id");

				param.put("id", uid);

				param.remove("receive_id");
				param.put("receive_id", arr[i]);

				this.reportDao.addReportMessage(param);
			}
		}

		NoteVo nv = new NoteVo();
		nv.setCommonDate(str);
		nv.setMsg(msg);
		nv.setUserName(user.getName());

		return nv;
	}

	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportNotes(String reportId) {
		return this.reportDao.getReportNotes(reportId);
	}

	@SuppressWarnings("rawtypes")
	public Page<AgencyInfo> getMyAgencyInfo(String flag, int pageNumber, int pageSize) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);
		Map<String, Object> paraMap = new HashMap<String, Object>();

		paraMap.put("userId", user.getId());
		if (null == flag || "".equals(flag)) {
			flag = "SOA";

		}

		List<HashMap> list = null;
		if ("SOF".equals(flag)) { // 我的已办，
			String[] states = new String[] { "SOF" };
			paraMap.put("states", states);
			paraMap.put("state", "SOW");
			list = this.reportDao.getMyAgenciedInfo(page, paraMap);
		} else { // 我的代办 1. 处理接收人是当前登录者，需要签收和回写的单;2.处理发送者为当前登录者，需要确认归档的单
			String[] states = new String[] { "SOA", "SOS" }; // 需要签收或回写的单
			paraMap.put("states", states);
			paraMap.put("state", "SOW"); // 需要确认的单
			list = this.reportDao.getMyAgencyInfo(page, paraMap);
		}

		List<AgencyInfo> rs = new ArrayList<AgencyInfo>();
		AgencyInfo ai = null;
		HashMap map = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0, len = list.size(); i < len; i++) {
			ai = new AgencyInfo();
			map = list.get(i);

			ai.setId((String) map.get("id"));
			ai.setContent((String) map.get("content"));
			ai.setName((String) map.get("name"));
			ai.setRptId((String) map.get("rpt_id"));
			ai.setSenderName((String) map.get("sender_name"));
			ai.setSenderId((String) map.get("sender_id"));
			ai.setState((String) map.get("state"));
			ai.setStateDate(map.get("state_date") != null ? sdf.format((Date) map.get("state_date")) : "");
			ai.setUrl((String) map.get("messageurl"));
			ai.setStateDesc((String) map.get("state_desc"));
			ai.setStateName((String) map.get("state"));
			rs.add(ai);

		}

		Page<AgencyInfo> pager = new Page<AgencyInfo>(page, rs);

		return pager;
	}

	public boolean submitAgen(String id, String type, String msg, String senderId, String senderName) {
		Map<String, Object> paraMap = new HashMap<String, Object>();
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();

		// 将接受人和发送人对调。
		String userId = user.getId();
		String userName = user.getName();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date date = new java.util.Date();
		String str = sdf.format(date);

		paraMap.put("id", id);
		paraMap.put("type", type);
		paraMap.put("msg", msg);
		paraMap.put("receiveId", senderId);
		paraMap.put("senderName", userName);
		paraMap.put("senderId", userId);
		paraMap.put("stateDate", str);

		return this.reportDao.submitAgen(paraMap);
	}

	@SuppressWarnings("rawtypes")
	public List<HashMap> getReportInfo(String reportId) {
		return this.reportDao.getReportInfo(reportId);
	}

	@SuppressWarnings("rawtypes")
	public Page<HashMap> executeSql(String sql, int pageNumber, int pageSize) {
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);
		Map<String, Object> paraMap = new HashMap<String, Object>();

		paraMap.put("sqltmp", sql);
		List<HashMap> list = this.reportDao.executeReportSql(page, paraMap);

		return new Page<HashMap>(page, list);

	}

	public Integer getCountByName(String name) {
		return this.reportDao.getCountByName(name);
	}
}
