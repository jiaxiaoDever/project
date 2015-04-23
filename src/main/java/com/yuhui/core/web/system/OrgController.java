package com.yuhui.core.web.system;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.base.InitLoader;
import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.service.system.OrgService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.web.base.BaseControllerImpl;

/**
 * @author 肖长江 机构管理
 */
@Controller
@RequestMapping(value = "/system/org")
public class OrgController extends BaseControllerImpl<Organization> {

	@Autowired
	private OrgService orgService;
	@Autowired
	InitLoader initLoader;

	/**
	 * 查询父机构下的子机构
	 * 
	 * @param id
	 *            父机构id 必须传递
	 * @return
	 */
	@RequestMapping("getOrgByParentId")
	@ResponseBody
	public List<Organization> getOrgByParentId(String id) {
		return orgService.findByParentId(id);
	}

	/**
	 * 查询机构树
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getTree")
	@ResponseBody
	public List<Organization> getTree() {
		return (List<Organization>) CacheUtils.get(Constants.CACHE_ORG_TREE);
	}

	@Override
	public BaseService<Organization> getService() {
		return orgService;
	}
	
	@Override
	public void finallyCall(String modthodName) {
		initLoader.initOrgTree();
	}
}
