package com.yuhui.core.web.common;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.common.TextIdBean;
import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.system.MenuService;
import com.yuhui.core.utils.EnumUtils;

@Controller
@RequestMapping(value = "/common/common")
public class CommonController {
	@Autowired
	private MenuService menuService;

	@RequestMapping("getMenuType")
	@ResponseBody
	public List<TextIdBean> getMenuType() {
		return EnumUtils.getIDStatus("tb_sys_menu", "type");
	}

	/**
	 * 返回菜单下的按钮
	 * 
	 * @param code
	 * @return
	 */
	@RequestMapping("getButtonsByParentCode")
	@ResponseBody
	public AjaxResult getButtonsByParentCode(String code) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		List<MenuBase> ls = null;
		if(user != null){
			String userId = user.getId();
			ls = menuService.getButtonsByParentCode(code,userId);
		}
		return AjaxResult.success(ls);
	}

}
