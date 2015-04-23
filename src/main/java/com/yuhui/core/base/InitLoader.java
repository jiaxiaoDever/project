
package com.yuhui.core.base;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.yuhui.core.entity.content.ContentTypeBase;
import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.entity.system.Portlet;
import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.entity.system.RolePortlet;
import com.yuhui.core.repository.content.ContentTypeBaseDAO;
import com.yuhui.core.repository.system.MenuBaseDAO;
import com.yuhui.core.repository.system.OrganizationDAO;
import com.yuhui.core.repository.system.PortletDAO;
import com.yuhui.core.repository.system.ResourceBaseDAO;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.utils.ContentTypeTreeIniter;
import com.yuhui.core.utils.MenuTreeIniter;
import com.yuhui.core.utils.OrgTreeIniter;
import com.yuhui.core.utils.ResourceTreeIniter;
import com.yuhui.core.utils.TreeUtils;
import com.yuhui.core.utils.TreeUtils.TreeBuilder;

public class InitLoader {
	@Autowired
	private MenuBaseDAO menuBaseDAO;
	@Autowired
	private ResourceBaseDAO resourceBaseDAO;
	@Autowired
	private OrganizationDAO organizationDAO;
	@Autowired
	private PortletDAO portletDAO;
	@Autowired
	private ContentTypeBaseDAO contentTypeBaseDAO;
	
	public void init() {
		/*initResourceTree();
		initMenuTree();
		initOrgTree();
		initRolePortlets();
		initContentTypeTree();*/
	}

	public void reset() {
		CacheUtils.clear();
		init();
	}

	/**
	 * 释放初始化
	 */
	public void destoryContent() {

	}

	public void destory() {
		destoryContent();
	}

	/**
	 * 初始化资源
	 */
	public void initResourceTree() {
		TreeBuilder<ResourceBase> treeBuilder = TreeUtils.getTreeBuilder(resourceBaseDAO.findAll(ResourceBase.class), new ResourceTreeIniter());
		CacheUtils.set(Constants.CACHE_RESOURCE_TREE, treeBuilder.getRootList());
		CacheUtils.set(Constants.CACHE_RESOURCE_MAP, treeBuilder.getMapTree());
	}

	/**
	 * 初始化内容分类
	 */
	public void initContentTypeTree() {
		TreeBuilder<ContentTypeBase> treeBuilder = TreeUtils.getTreeBuilder(contentTypeBaseDAO.findAll(ContentTypeBase.class),new ContentTypeTreeIniter());
		CacheUtils.set(Constants.CACHE_CONTENT_TYPE_TREE, treeBuilder.getRootList());
		CacheUtils.set(Constants.CACHE_CONTENT_TYPE_MAP, treeBuilder.getMapTree());
	}
	/**
	 * 初始化菜单
	 */
	@SuppressWarnings("unchecked")
	public void initMenuTree() {
		//缓存所有菜单和Map
		MenuTreeIniter menuIniter = new MenuTreeIniter((Map<String, ResourceBase>) CacheUtils.get(Constants.CACHE_RESOURCE_MAP));
		TreeBuilder<MenuBase> treeBuilder = TreeUtils.getTreeBuilder(menuBaseDAO.findAll(MenuBase.class), menuIniter);
		CacheUtils.set(Constants.CACHE_ALL_MENU_TREE, treeBuilder.getRootList());
		CacheUtils.set(Constants.CACHE_ALL_MENU_MAP, treeBuilder.getMapTree());

		//缓存所有菜单(无按钮)和Map
		MenuBase menuQuery = new MenuBase();
		menuQuery.setType(1);
		menuIniter = new MenuTreeIniter((Map<String, ResourceBase>) CacheUtils.get(Constants.CACHE_RESOURCE_MAP));
		treeBuilder = TreeUtils.getTreeBuilder(menuBaseDAO.query(menuQuery), menuIniter);
		CacheUtils.set(Constants.CACHE_MENU_TREE, treeBuilder.getRootList());
		CacheUtils.set(Constants.CACHE_MENU_MAP, treeBuilder.getMapTree());
	}
	
	@SuppressWarnings("unchecked")
	public void initOrgTree(){
		OrgTreeIniter orgTreeIniter = new OrgTreeIniter((Map<String, Organization>)CacheUtils.get(Constants.CACHE_ORG_MAP));
		TreeBuilder<Organization> treeBuilder = TreeUtils.getTreeBuilder(organizationDAO.findAll(Organization.class), orgTreeIniter);
		CacheUtils.set(Constants.CACHE_ORG_TREE, treeBuilder.getRootList());
		CacheUtils.set(Constants.CACHE_ORG_MAP, treeBuilder.getMapTree());
	}
	
	public void initRolePortlets(){
		List<RolePortlet> rps = portletDAO.queryRolePortlets();
		Map<String, List<Portlet>> rpsMap = null;
		if(rps != null && rps.size() > 0){
			rpsMap = new HashMap<String, List<Portlet>>();
			for(RolePortlet rp:rps){
				String key = rp.getRid();
				List<Portlet> ps = rp.getPortlets();
				if(key != null && ps !=null) rpsMap.put(key, ps);
			}
		}
		CacheUtils.set(Constants.CACHE_ROLE_PORTLET, rps);		
		CacheUtils.set(Constants.CACHE_ROLE_PORTLET_MAP, rpsMap);		
	}
}

