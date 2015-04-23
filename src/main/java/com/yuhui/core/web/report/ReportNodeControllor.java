package com.yuhui.core.web.report;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.service.report.ReportService;

/**
 * 
 * @ClassName: ReportNodeControllor
 * @Description: 报表评论和转发
 * @author xiexiaozhi
 * @date 2014-2-19 下午2:16:03
 * 
 */
@Controller
@RequestMapping(value = "/report")
public class ReportNodeControllor {

	@Autowired
	private ReportService reportService;

	@RequestMapping("saveNote")
	@ResponseBody
	public NoteVo saveNote(javax.servlet.http.HttpServletRequest req) {
		String reportId = req.getParameter("reportId");
		String name = req.getParameter("name");
		String msg = req.getParameter("msg");
		String type = req.getParameter("type");
		String url = req.getParameter("messageurl");

		// String orgId = req.getParameter("orgId");
		String receiveId = req.getParameter("receiveId");
		String receiveName = req.getParameter("receiveName");

		return this.reportService.saveNote(reportId, receiveId, receiveName, msg, type, url, name);

	}

	@SuppressWarnings("rawtypes")
	@RequestMapping("getReportNotes")
	@ResponseBody
	public List<NoteVo> getReportNotes(String reportId) {
		List<NoteVo> list = new ArrayList<NoteVo>();

		List<HashMap> result = this.reportService.getReportNotes(reportId);
		if (result != null && result.size() > 0) {
			HashMap map = null;
			NoteVo nv = null;

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			// java.util.Date date=new java.util.Date();
			// String str=sdf.format(date);

			for (int i = 0, len = result.size(); i < len; i++) {
				map = result.get(i);
				nv = new NoteVo();
				nv.setMsg((String) map.get("note_msg"));
				nv.setUserName((String) map.get("user_name"));
				nv.setCommonDate(sdf.format(map.get("left_time")));
				list.add(nv);
			}
		}
		return list;
	}
}
