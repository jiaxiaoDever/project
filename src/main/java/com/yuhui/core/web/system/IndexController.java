package com.yuhui.core.web.system;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.system.MenuService;
import com.yuhui.core.service.system.UserService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.utils.MenuTreeIniter;
import com.yuhui.core.utils.TreeUtils;
import com.yuhui.core.utils.TreeUtils.TreeBuilder;

/**
 * 首页管理
 * 
 * @author 肖长江
 */
@Controller
@RequestMapping(value = "/index")
public class IndexController {

	@Autowired
	private UserService userService;
	@Autowired
	private MenuService menuService;

	/**
	 * 请求到首页,在请求作用域中添加了用户shiro用户对象
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param request
	 * @return
	 */
	@RequestMapping("")
	public String index(HttpSession session) {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		UserBase userBase = userService.findUserByUserName(user.getUsername());
		session.setAttribute("user", userBase);
		return "index";
	}

	/**
	 * 查询用户所有的菜单，先根据用户获取用户拥有的菜单列表，在组装初始化为树结构的菜单列表
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getMenu")
	@ResponseBody
	public List<MenuBase> getMenu() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		UserBase userBase = new UserBase();
		userBase.setId(user.getId());
		List<MenuBase> ls = menuService.getUserMenus(userBase);
		MenuTreeIniter menuIniter = new MenuTreeIniter((Map<String, ResourceBase>) CacheUtils.get(Constants.CACHE_RESOURCE_MAP));
		TreeBuilder<MenuBase> treeBuilder = TreeUtils.getTreeBuilder(ls, menuIniter);
		ls = treeBuilder.getRootList();
		if (ls != null && ls.size() > 0)
			ls = ls.get(0).getChildren();
		return ls;
	}

}
