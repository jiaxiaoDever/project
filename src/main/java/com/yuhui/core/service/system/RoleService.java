package com.yuhui.core.service.system;

import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.service.base.BaseService;

/**
 * 角色管理service
 */
public interface RoleService extends BaseService<RoleBase> {
	/**
	 * 删除角色
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param ids
	 *            需要删除角色的ids 必须传递
	 * @return 返回执行结果
	 */
	public boolean deleteRoles(String ids);

	/**
	 * 编辑角色菜单信息
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * 
	 * @param roleBase
	 *            角色 必须传递
	 * @param ids
	 *            菜单ids 必须传递
	 * @return 返回执行结果
	 */
	public boolean editRoleMenu(RoleBase roleBase, String ids);

	/**
	 * 根据角色名称，等值查询
	 * 
	 * @author 肖长江
	 * @date 2014-1-21
	 * 
	 * @param name
	 *            角色名称
	 * @return 返回角色名称对应的角色对象
	 */
	public RoleBase findByRoleName(String name);
}
