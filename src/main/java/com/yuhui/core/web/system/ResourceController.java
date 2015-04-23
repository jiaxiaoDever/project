package com.yuhui.core.web.system;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.base.InitLoader;
import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.service.system.ResourceService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.web.base.BaseControllerImpl;

/**
 * @author 肖长江 资源管理
 */
@Controller
@RequestMapping(value = "/system/resource")
public class ResourceController extends BaseControllerImpl<ResourceBase> {

	@Autowired
	private ResourceService resourceService;
	@Autowired
	InitLoader initLoader;

	/**
	 * 查询菜单树 从缓存中拿数据
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getTree")
	@ResponseBody
	public List<ResourceBase> getTree() {
		return (List<ResourceBase>) CacheUtils.get(Constants.CACHE_RESOURCE_TREE);
	}

	/**
	 * 新增或编辑某个资源数据，参数对象中ID有传值认为是编辑事件，否则认为是添加事件
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param resourceBase
	 *            资源数据 必须传递
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	public AjaxResult save(ResourceBase entity) {
		entity.setState(0);
		entity.setStateDate(new Date());
		return super.save(entity);
	}


	@Override
	public BaseService<ResourceBase> getService() {
		return resourceService;
	}

	@Override
	public void finallyCall(String modthodName) {
		initLoader.initResourceTree();
		initLoader.initMenuTree();
	}
}
