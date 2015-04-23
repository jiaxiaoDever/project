package com.yuhui.core.web.report;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.report.ReportService;
/**
 * 
* @ClassName: ReportDirControllor 
* @Description:  报表目录管理
* @author xiexiaozhi 
* @date 2014-1-21 上午10:18:25 
*
 */
@Controller
@RequestMapping(value = "/reportdir")
public class ReportDirControllor {

	@Autowired
	private ReportService reportService;
	/**
	 * 
	* @Title: createDir 
	* @Description: 创建目录，
	* @param @param id  父节点ID
	* @param @param name  新目录的名称
	* @return String    返回类型 
	* @throws
	 */
	@RequestMapping("createDir")
	@ResponseBody
	public AjaxResult createDir(String id,String name,String privilege){
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		String userId = user.getId();
		System.out.println(userId);
		this.reportService.addDir(id, name, userId,user.getName(),privilege);
		return AjaxResult.success();
	}
	
	/**
	 * 
	* @Title: editDir 
	* @Description: 修改目录
	* @param @param id
	* @param @param name
	* @return AjaxResult    返回类型 
	* @throws
	 */
	@RequestMapping("editDir")
	@ResponseBody
	public AjaxResult editDir(String id ,String name){
	
		this.reportService.editDir(id, name);
		return AjaxResult.success();
	}
	
	@RequestMapping("deleteDir")
	@ResponseBody
	public AjaxResult deleteDir(String id){
		
		this.reportService.deleteDir(id);
		return AjaxResult.success();
	}
	
	@RequestMapping("dirForm")
	public String createDirForm(javax.servlet.http.HttpServletRequest req){
		String name = req.getParameter("name");
		String id = req.getParameter("id");
		String privilege = req.getParameter("privilege");
		
		req.setAttribute("name", name);
		req.setAttribute("id", id);
		req.setAttribute("privilege", privilege);
		return "report/dirForm";
	}
	/**
	 * 
	* @Title: checkDir 
	* @Description: 校验同一目录下是否有同名的目录
	* @param @param id 父目录ID
	* @param @param name
	* @return String    返回类型 
	* @throws
	 */
	@RequestMapping("checkDir")
	@ResponseBody
	public String checkDir(String id,String name,String act){
		String str ="false";
		int i = this.reportService.checkDir(id, name,act);
		if(i>0){
			str ="true";
		}
			
		return str;
	}
}
