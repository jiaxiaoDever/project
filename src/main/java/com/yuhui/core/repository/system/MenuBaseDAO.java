package com.yuhui.core.repository.system;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

/**
 * 菜单DAO
 * @author zhangy
 *
 */
@Repository("menuBaseDAO")
@MyBatisRepository()
public interface MenuBaseDAO extends BaseRepository<MenuBase> {
	/**
	 * 根据菜单ID获取子菜单
	 * 
	 * @param menu
	 * @return
	 */
	public List<MenuBase> findByParentId(MenuBase menu);

	/**
	 * 获取菜单树，不包含按钮
	 * 
	 * @param menu
	 * @return
	 */
	public List<MenuBase> getMenus(MenuBase menu);

	/**
	 * 根据菜单code获取菜单的按钮
	 * 
	 * @param code
	 * @return
	 */
	public List<MenuBase> getButtonsByParentCode(@Param(value = "parameters") Map<String, String> params);

	public Integer getLastSortByParentId(String parentId);

	/**
	 * 根据角色编号获取角色对应的菜单编号
	 * 
	 * @author 肖长江
	 * @date 2013-9-29
	 * @param id
	 *            角色编号
	 * @return 返回角色拥有的菜单对象集合
	 */
	public List<String> getMenuIdByRoleId(String id);

	/**
	 * 根据用户编号查询用户对应的菜单(不包括按钮)
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param userId
	 *            用户编号
	 * @return 返回用户拥有的菜单对象集合
	 */
	public List<MenuBase> getUserMenus(String userId);
}
