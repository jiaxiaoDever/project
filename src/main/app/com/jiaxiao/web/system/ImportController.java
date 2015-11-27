package com.jiaxiao.web.system;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import com.jiaxiao.entity.TbBaseJx;
import com.jiaxiao.entity.TbBranchesJx;
import com.jiaxiao.entity.TbStudentJx;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.security.ShiroUser;

/**
 * @author 肖长江
 * 导入数据控制器
 */
@Controller
@RequestMapping(value = "/import")
public class ImportController {

	@Autowired
	private ImportService<TbStudentJx> studentJxService;
	@Autowired
	private ImportService<TbTeacherJx> teacherJxService;
	@Autowired
	private ImportService<TbBaseJx> jxService;
	@Autowired
	private ImportService<TbBranchesJx> branchesJxService;
	
	
	@RequestMapping("preImport")
	public String preImport(){
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		return "import/import";
	}
	
	public List<File> upLoad(HttpServletRequest request) throws Exception {
		List<File> files = new ArrayList<File>();
		String upload_file_path=request.getSession().getServletContext().getRealPath("/")+"upload/" ;
		System.out.println(upload_file_path);
		// 设置工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置文件存储位置
		factory.setRepository(new File(upload_file_path));
		// 设置大小，如果文件小于设置大小的话，放入内存中，如果大于的话则放入磁盘中,单位是byte
		factory.setSizeThreshold(1024 * 1024);

		ServletFileUpload upload = new ServletFileUpload(factory);
		// 这里就是中文文件名处理的代码，其实只有一行
		upload.setHeaderEncoding("utf-8");
		String fileName = null;
		List<FileItem> list = upload.parseRequest(request);
		for (FileItem item : list) {
			if (item.isFormField()) {
				String name = item.getFieldName();
				String value = item.getString("utf-8");
				System.out.println(name);
				System.out.println(value);
				request.setAttribute(name, value);
			} else {
				String name = item.getFieldName();
				String value = item.getName();
				System.out.println(name);
				System.out.println(value);

				fileName = value + "_" + new Date().getTime();
				request.setAttribute(name, fileName);
				// 写文件到path目录，文件名问filename
				File nFile = new File(upload_file_path, fileName);
				item.write(nFile);
				files.add(nFile); 
			}
		}
		return files;
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("importData/{importType}")
	public String importData(HttpSession session,HttpServletRequest request,@PathVariable String importType) throws Exception{
		File upfile = null;
		List<File> files = upLoad(request);
		if(files != null && files.size() > 0) upfile = files.get(0);
		JSONObject jo = new JSONObject();
		if(upfile!=null && upfile.isFile()){			
			ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
			request.setAttribute("importType", importType);
			try {
				if("1".equals(importType)){
					List<TbBaseJx> successes = new ArrayList<TbBaseJx>();
					List<TbBaseJx> fails = new ArrayList<TbBaseJx>();
					List<Map<String, Object>> checkFails = new ArrayList<Map<String, Object>>();
					jxService.importEntity(upfile, successes, fails, checkFails);
					JSONArray ja = JSONArray.fromObject(successes);
					jo.put("successes", ja);
					JSONArray jaf = JSONArray.fromObject(fails);
					jo.put("fails", jaf);
					JSONArray jac = JSONArray.fromObject(checkFails);
					jo.put("checkFails", jac);
				}else if("2".equals(importType)){
					List<TbBranchesJx> successes = new ArrayList<TbBranchesJx>();
					List<TbBranchesJx> fails = new ArrayList<TbBranchesJx>();
					List<Map<String, Object>> checkFails = new ArrayList<Map<String, Object>>();
					branchesJxService.importEntity(upfile, successes, fails, checkFails);
					JSONArray ja = new JSONArray();
					ja.addAll(successes);
					jo.put("successes", ja);
					JSONArray jaf = new JSONArray();
					ja.addAll(fails);
					jo.put("fails", jaf);
					JSONArray jac = new JSONArray();
					ja.addAll(checkFails);
					jo.put("checkFails", jac);
				}else if("3".equals(importType)){
					List<TbTeacherJx> successes = new ArrayList<TbTeacherJx>();
					List<TbTeacherJx> fails = new ArrayList<TbTeacherJx>();
					List<Map<String, Object>> checkFails = new ArrayList<Map<String, Object>>();
					teacherJxService.importEntity(upfile, successes, fails, checkFails);
					JSONArray ja = new JSONArray();
					ja.addAll(successes);
					jo.put("successes", ja);
					JSONArray jaf = new JSONArray();
					ja.addAll(fails);
					jo.put("fails", jaf);
					JSONArray jac = new JSONArray();
					ja.addAll(checkFails);
					jo.put("checkFails", jac);
				}else if("4".equals(importType)){
					List<TbStudentJx> successes = new ArrayList<TbStudentJx>();
					List<TbStudentJx> fails = new ArrayList<TbStudentJx>();
					List<Map<String, Object>> checkFails = new ArrayList<Map<String, Object>>();
					studentJxService.importEntity(upfile, successes, fails, checkFails);
					JSONArray ja = new JSONArray();
					ja.addAll(successes);
					jo.element("successes", ja);
					JSONArray jaf = new JSONArray();
					ja.addAll(fails);
					jo.element("fails", jaf);
					JSONArray jac = new JSONArray();
					ja.addAll(checkFails);
					jo.element("checkFails", jac);
				}
				request.setAttribute("result",jo.toString());
				request.setAttribute("fmsg","已经导入机构信息!请查看导入结果");
				request.setAttribute("importFlag",1);
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("fmsg","导入失败，请核对您的Excel内容及格式是否正确！");
				request.setAttribute("importFlag",0);
			} 
		}else{			
			request.setAttribute("fmsg","文件传输异常！");
			request.setAttribute("importFlag",-1);
		}
		return "import/import";
	}

}
