package com.yuhui.core.web.system;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.system.PortPageLayout;
import com.yuhui.core.entity.system.Portlet;
import com.yuhui.core.entity.system.RolePortlet;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.system.PortletService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.utils.LocaleUtils;

/**
 * @author 肖长江
 * portlet管理
 */
@Controller
@RequestMapping(value = "/portlet")
public class PortletController {

	@Autowired
	private PortletService portletService;
	public PortletController() {
	}

	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 查找当前登录用户拥有的系统portlet和自定义portlet的集合
	 * @return
	 */
	@RequestMapping("findUserPortlets")
	@ResponseBody
	public List<Portlet> findUserPortlets(HttpSession session){
		Object uObject = session.getAttribute("user");
		List<Portlet> ps = portletService.findUserPortlets((UserBase)uObject);
		return ps;
	}
	
	
	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 获取当前登录用户的portlet页面布局
	 * @return
	 */
	@RequestMapping("loadLayout")
	@ResponseBody
	public PortPageLayout loadLayout(HttpSession session){
		Object uObject = session.getAttribute("user");
		PortPageLayout ppLayout=portletService.findUserPortPageLayout((UserBase)uObject);
		return ppLayout;
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 加载指定角色的portlet页面默认布局
	 * @param roleId
	 * @return
	 */
	@RequestMapping("loadRoleLayout")
	@ResponseBody
	public PortPageLayout loadRoleLayout(String roleId){
		PortPageLayout ppLayout=portletService.findRolePortPageLayout(roleId);
		return ppLayout;
	}
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查找所有的系统portlet
	 * @return
	 */
	@RequestMapping("findSysPortlets")
	@ResponseBody
	public List<Portlet> findSysPortlets(){
		List<Portlet> ps = portletService.findSysPortlets();
		return ps;
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查找所有角色对应的Portlet
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("findAllRolePortlets")
	@ResponseBody
	public List<RolePortlet> findAllRolePortlets(){
		return (List<RolePortlet>) CacheUtils.get(Constants.CACHE_ROLE_PORTLET);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查找指定角色对应的Portlet 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("findRolePortlets")
	@ResponseBody
	public List<Portlet> findRolePortlets(String roleId){
		Map<String, List<Portlet>> rpsMap = (Map<String, List<Portlet>>) CacheUtils.get(Constants.CACHE_ROLE_PORTLET_MAP);
		if(rpsMap != null && roleId != null && rpsMap.containsKey(roleId)) return rpsMap.get(roleId);
		return null;
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 保存角色对应的默认portlet布局信息
	 * @param layout
	 * @return
	 */
	@RequestMapping("saveRoleLayout")
	@ResponseBody
	public AjaxResult saveRoleLayout(PortPageLayout layout){
		if(layout != null && layout.getForId() != null && !"".equals(layout.getForId())){			
			layout.setEditTime(new Date());
			layout.setForType(2);
			portletService.saveLayout(layout);
		}
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), layout);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-7
	 * @todo TODO 保存用户的portlet布局信息
	 * @param layout
	 * @return
	 */
	@RequestMapping("saveUserLayout")
	@ResponseBody
	public AjaxResult saveUserLayout(PortPageLayout layout) {
		layout.setEditTime(new Date());
		layout.setForType(1);
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		layout.setForId(user.getId());
		portletService.saveLayout(layout);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), layout);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 保存系统portlet信息
	 * @param portlet
	 * @return
	 */
	@RequestMapping("saveSysPortlet")
	@ResponseBody
	public AjaxResult saveSysPortlet(Portlet portlet){
		portlet.setCategory(1);
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		portlet.setUserId(user.getId());
		portlet.setEditTime(new Date());
		portletService.addSysPortlet(portlet);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), portlet);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 保存用户自定义portlet信息
	 * @param portlet
	 * @return
	 */
	@RequestMapping("saveUserPortlet")
	@ResponseBody
	public AjaxResult saveUserPortlet(Portlet portlet){
		portlet.setCategory(2);
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		portlet.setUserId(user.getId());
		portlet.setEditTime(new Date());
		portletService.addSysPortlet(portlet);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), portlet);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 添加portlet到一个或多个角色
	 * @param portletId
	 * @param roleIds
	 * @return
	 */
	@RequestMapping("savePortletToAllRole")
	@ResponseBody
	public  AjaxResult savePortletToAllRole(String portletId,String roleIds){
		portletService.addRolePortlet(roleIds, portletId);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), portletId);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 删除某个portlet，不管是系统portlet还是自定义portlet,要求是谁添加的才能谁删除
	 * @param portlet
	 * @return
	 */
	@RequestMapping("removePortlet")
	@ResponseBody
	public AjaxResult removePortlet(Portlet portlet){
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		portlet.setUserId(user.getId());
		portletService.removePortlet(portlet);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), portlet);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 移除某个portlet与所有角色的绑定
	 * @param portlet
	 * @return
	 */
	@RequestMapping("removePortletOfRoles")
	@ResponseBody
	public AjaxResult removePortletOfRoles(Portlet portlet){
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		portlet.setUserId(user.getId());
		portletService.removePortletOfRoles(portlet);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), portlet);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 移除某个角色上绑定的某个portlet
	 * @param roleId
	 * @param portletId
	 * @return
	 */
	@RequestMapping("removeRolePortlet")
	@ResponseBody
	public AjaxResult removeRolePortlet(String roleId,String portletId){
		portletService.removeRolePortlet(roleId, portletId);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), portletId);
	}
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 移除某个角色上绑定的所有的portlet
	 * @param roleId
	 * @return
	 */
	@RequestMapping("removeRoleAllPortlet")
	@ResponseBody
	public AjaxResult removeRoleAllPortlet(String roleId){
		portletService.removeRoleAllPortlet(roleId);
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), roleId);
	}
	
}
