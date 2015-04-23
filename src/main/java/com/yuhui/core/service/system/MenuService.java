package com.yuhui.core.service.system;

import java.util.List;

import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.service.base.BaseService;

public interface MenuService extends BaseService<MenuBase> {

	/**
	 * 根据父菜单ID获取子菜单
	 * 
	 * @param menu
	 * @return
	 */
	List<MenuBase> findByParentId(MenuBase menu);

	/**
	 * 根据父菜单code获取按钮
	 * 
	 * @param code
	 * @return
	 */
	public List<MenuBase> getButtonsByParentCode(String code, String userId);

	/**
	 * 更加角色编号获取角色所对应的菜单编号
	 * 
	 * @author 肖长江
	 * @date 2013-9-29
	 * @return
	 */
	public List<String> getMenuIdByRoleId(String id);

	/**
	 * 获取用户的菜单权限
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * 
	 * @param user
	 *            指定用户 ,用户编号不能为空
	 * @return 返回用户拥有的菜单对象集合(不包括按钮)
	 */
	public List<MenuBase> getUserMenus(UserBase user);
}
