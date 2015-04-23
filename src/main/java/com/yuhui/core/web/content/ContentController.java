package com.yuhui.core.web.content;

import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.content.ContentBase;
import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.service.content.ContentService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.web.base.BaseControllerImpl;

/**
 * 内容管理
 * 
 * @author zhangy
 * 
 */
@Controller
@RequestMapping(value = "/content/content")
public class ContentController extends BaseControllerImpl<ContentBase>  {
	@Autowired
	private ContentService contentService;

	/**
	 * 内容信息
	 * 
	 * @param ContentBase
	 * 
	 * @param roleids
	 *            内容角色ids,多个ID间以","隔开 必须传递
	 * @return
	 */
	@Override
	public AjaxResult save(ContentBase entity) {
		entity.setStateDate(new Date());
		entity.setCreateDate(new Date());
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		entity.setUserId(user.getId());
		entity.setUserName(user.getName());
		return super.save(entity);
	}

	/**
	 * 查找所有机构，并封装成带树结构的机构列表返回
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getOrgTree")
	@ResponseBody
	public List<Organization> getOrgTree() {
		return (List<Organization>) CacheUtils.get(Constants.CACHE_ORG_TREE);
	}

	@Override
	public BaseService<ContentBase> getService() {
		return contentService;
	}

}
