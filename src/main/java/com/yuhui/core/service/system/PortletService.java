package com.yuhui.core.service.system;

import java.util.List;

import com.yuhui.core.entity.system.PortPageLayout;
import com.yuhui.core.entity.system.Portlet;
import com.yuhui.core.entity.system.RolePortlet;
import com.yuhui.core.entity.system.UserBase;

/**
 * @author 肖长江
 * portlet业务处理接口
 */
public interface PortletService {

	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 获取用户拥有的系统portlet和自定义portlet的集合，系统portlet在集合中靠前
	 * @param user 指定用户
	 * @return 返回用户拥有的系统portlet和自定义portlet的集合
	 */
	public List<Portlet> findUserPortlets(UserBase user);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-5
	 * @todo TODO 获取用户的portlet页面布局，没有则取其角色对应的默认布局
	 * @param user 指定用户
	 * @return 返回用户的portlet页面布局，没有则取其角色对应的默认布局，都没有则返回null
	 */
	public PortPageLayout findUserPortPageLayout(UserBase user);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查找角色默认的布局
	 * @param roleId
	 * @return
	 */
	public PortPageLayout findRolePortPageLayout(String roleId);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-7
	 * @todo TODO 保存用户的portlet布局信息
	 * @param layout portlet布局对象
	 * @return 
	 */
	public int saveLayout(PortPageLayout layout);

	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查询所有的系统portlet
	 * @return
	 */
	public List<Portlet> findSysPortlets();
	
	/**
	 * @author 肖长江
	 * @date 2013-11-12
	 * @todo TODO 查询角色对应的portlet
	 * @return
	 */
	public List<RolePortlet> findRolePortlets();
	
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 添加系统portlet
	 * @param portlet
	 * @return
	 */
	public int addSysPortlet(Portlet portlet);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 添加自定义portlet
	 * @param portlet
	 * @return
	 */
	public int addUserPortlet(Portlet portlet);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 移除某个portlet
	 * @param portlet
	 * @return
	 */
	public int removePortlet(Portlet portlet);
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 移除某个portlet与所有角色的绑定
	 * @param portlet
	 * @return
	 */
	public int removePortletOfRoles(Portlet portlet);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 移除某个角色上绑定的某个Portlet
	 * @param roleId
	 * @param portletId
	 * @return
	 */
	public int removeRolePortlet(String roleId,String portletId);
	
	/**
	 * @author 肖长江
	 * @date 2013-11-11
	 * @todo TODO 移除某个角色上绑定的所有的portlet
	 * @param roleId
	 * @return
	 */
	public int removeRoleAllPortlet(String roleId);
	/**
	 * @author 肖长江
	 * @date 2013-11-8
	 * @todo TODO 添加角色对应的portlet
	 * @param roleIds
	 * @param portletId
	 * @return
	 */
	public int addRolePortlet(String roleIds,String portletId);
	
}
