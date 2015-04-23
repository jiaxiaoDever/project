package com.yuhui.core.web.system;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.base.InitLoader;
import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.service.system.MenuService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.web.base.BaseControllerImpl;

/**
 * 菜单管理
 * 
 * @author 肖长江
 */
@Controller
@RequestMapping(value = "/system/menu")
public class MenuController extends BaseControllerImpl<MenuBase> {

	@Autowired
	private MenuService menuService;
	@Autowired
	InitLoader initLoader;

	/**
	 * 返回树形结构中父菜单下的子菜单
	 * 
	 * @param treeGrid
	 *            父菜单 必须传递
	 * @return
	 */
	@RequestMapping("getMenuByParentId")
	@ResponseBody
	public List<MenuBase> getMenuByParentId(MenuBase treeGrid) {
		return menuService.findByParentId(treeGrid);
	}

	/**
	 * 返回菜单树，从缓存中拿的数据
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getTree")
	@ResponseBody
	public List<MenuBase> getTree() {
		return (List<MenuBase>) CacheUtils.get(Constants.CACHE_ALL_MENU_TREE);
	}

	/**
	 * 返回资源树，从缓存中拿的数据
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getResTree")
	@ResponseBody
	public List<ResourceBase> getResTree() {
		return (List<ResourceBase>) CacheUtils.get(Constants.CACHE_RESOURCE_TREE);
	}

	/**
	 * 根据角色编号获取角色有的菜单编号集合
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param id
	 *            角色编号 必须传递
	 * @return
	 */
	@RequestMapping("getMenuIdByRoleId")
	@ResponseBody
	public List<String> getMenuIdByRoleId(String id) {
		return menuService.getMenuIdByRoleId(id);
	}

	/**
	 * 添加或编辑菜单数据，传递的参数中的ID如有值则认为是编辑菜单事件，否则认为是添加菜单事件
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param menuBase
	 *            需要新增或修改的菜单数据 必须传递
	 * @return
	 */
	@Override
	public AjaxResult save(MenuBase menuBase) {
		menuBase.setStateDate(new Date());
		menuBase.setState(0);
		return super.save(menuBase);
	}


	@Override
	public BaseService<MenuBase> getService() {
		return menuService;
	}

		@Override
	public void finallyCall(String modthodName ){
		initLoader.initMenuTree();
	}
}
