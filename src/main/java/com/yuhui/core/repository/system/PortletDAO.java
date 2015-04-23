package com.yuhui.core.repository.system;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.system.PortPageLayout;
import com.yuhui.core.entity.system.Portlet;
import com.yuhui.core.entity.system.RolePortlet;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("portletDAO")
@MyBatisRepository()
public interface PortletDAO extends BaseRepository<PortPageLayout> {

	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查找所有系统portlet
	 * @return
	 */
	public List<Portlet> querySysPortlet();
	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 查询用户自定义portlet实体集合
	 * @param user 指定用户
	 * @return 返回指定用户自定义portlet实体集合
	 */
	public List<Portlet> querySelfPortlet(UserBase user);
	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 查询所有角色对应的portlet实体集合
	 * @return 返回所有角色对应的portlet实体集合
	 */
	public List<RolePortlet> queryRolePortlets();
	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 查询指定用户的portlet页面布局实体
	 * @param user 指定用户
	 * @return 返回指定用户的portlet页面布局实体
	 */
	public PortPageLayout queryUserPortPageLayout(UserBase user);
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查询指定角色默认的portlet页面布局
	 * @param roleId
	 * @return
	 */
	public List<PortPageLayout> queryRolePortPageLayout(String roleId);
	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 查询指定用户对应角色的portlet页面默认布局实体
	 * @param user 指定用户
	 * @return 返回指定用户对应角色的portlet页面默认布局实体
	 */
	public List<PortPageLayout> queryUserRolePortPageLayout(UserBase user);
	
	
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 往数据库中新增一条portlet数据
	 * @param portlet
	 * @return
	 */
	public int insertPortlet(Portlet portlet);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 从数据库中删除某条Portlet数据
	 * @param portlet
	 * @return
	 */
	public int deletePortlet(Portlet portlet);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 插入角色对应的portlet
	 * @param params
	 * @return
	 */
	public int insertRolePortlets(@Param(value="parameters") Map<String, String> params);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 删除某个角色对应的portlet
	 * @param portletId
	 * @return
	 */
	public int deleteRolePortlets(@Param(value="parameters") Map<String, String> params);
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 删除所有的角色对应的Portlet
	 * @param portletId
	 * @return
	 */
	public int deleteAllRolePortlets(String portletId);
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 删除某个角色上绑定的所有portlet
	 * @param roleId
	 * @return
	 */
	public int deleteAllPortletsOfRole(String roleId);
}
