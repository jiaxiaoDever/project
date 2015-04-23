package com.yuhui.core.web.content;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.base.InitLoader;
import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.content.ContentTypeBase;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.service.content.ContentTypeService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.web.base.BaseControllerImpl;

/**
 * 内容分类
 * 
 * @author zhangy
 * 
 */
@Controller
@RequestMapping(value = "/content/contentType")
public class ContentTypeController extends BaseControllerImpl<ContentTypeBase> {
	@Autowired
	private ContentTypeService contentTypeService;
	@Autowired
	InitLoader initLoader;


	/**
	 * 返回内容分类树，从缓存中拿的数据
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getTree")
	@ResponseBody
	public List<ContentTypeBase> getTree() {
		return (List<ContentTypeBase>) CacheUtils.get(Constants.CACHE_CONTENT_TYPE_TREE);
	}

	/**
	 * @param ContentTypeBase
	 *            需要新增或修改的数据 必须传递
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	public AjaxResult save(ContentTypeBase entity) {
		entity.setStateDate(new Date());
		entity.setState(0);
		AjaxResult r = super.save(entity);
		initLoader.initContentTypeTree();
		return r;
	}

	/**
	 * 删除内容分类
	 * 
	 * @param ids
	 *            需要移除的数据的ids，多个ID间以","隔开 必须传递
	 * @return
	 */
	@RequestMapping("deleteIn")
	@ResponseBody
	public AjaxResult deleteIn(String ids) {
		AjaxResult r = super.deleteIn(ids);
		initLoader.initContentTypeTree();
		return r;
	}

	/**
	 * 更新内容分类
	 * 
	 * @param ls
	 * @return
	 */
	@RequestMapping("updateAll")
	@ResponseBody
	public AjaxResult updateAll(@RequestBody List<ContentTypeBase> ls) {
		AjaxResult r = super.updateAll(ls);
		initLoader.initContentTypeTree();
		return r;
	}

	@Override
	public BaseService<ContentTypeBase> getService() {
		return contentTypeService;
	}
}
