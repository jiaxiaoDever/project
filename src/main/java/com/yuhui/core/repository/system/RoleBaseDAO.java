package com.yuhui.core.repository.system;

import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.entity.system.RoleMenu;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

/**
 * 角色DAO
 * @author zhangy
 *
 */
@Repository("roleBaseDAO")
@MyBatisRepository()
public interface RoleBaseDAO extends BaseRepository<RoleBase> {
	/**
	 * 更新角色菜单中间表数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * 
	 * @param roleMenu
	 *            角色菜单对象
	 * @return 返回影响的行数
	 */
	public int updateRoleMenu(RoleMenu roleMenu);

	/**
	 * 根据角色ID删除角色菜单中间表数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * 
	 * @param roleId
	 *            角色ID
	 * @return 返回影响的行数
	 */
	public int deleteRoleMenu(String roleId);

	/**
	 * 根据角色ID删除用户角色中间表数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * 
	 * @param roleId
	 *            角色ID
	 * @return 返回影响的行数
	 */
	public int deleteRoleUser(String roleId);

	/**
	 * 直接=的查询，原来改了基础DAO的query方法为=的查询，后来又被张原改为like的模糊查询，现在此特定此直接查询方法
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
