package com.yuhui.core.web.base;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.base.IdEntity;
import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.utils.LocaleUtils;
import com.yuhui.core.utils.page.Page;

/**
 * 基础Controller实现类
 * 
 * @author zhangy
 * 
 * @param <T>
 */
public abstract class BaseControllerImpl<T extends IdEntity> implements BaseController<T> {

	@RequestMapping("save")
	@ResponseBody
	@Override
	public AjaxResult save(T entity) {
		getService().save(entity);
		finallyCall("save");
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), entity);
	}

	@RequestMapping("delete")
	@ResponseBody
	@Override
	public AjaxResult delete(String id) {
		getService().delete(id);
		finallyCall("delete");
		return AjaxResult.success();
	}

	@RequestMapping("deleteIn")
	@ResponseBody
	@Override
	public AjaxResult deleteIn(String ids) {
		getService().deleteIn(ids);
		finallyCall("deleteIn");
		return AjaxResult.success();
	}

	@RequestMapping("get")
	@ResponseBody
	@Override
	public T get(String id) {
		return getService().get(id);
	}

	@RequestMapping("findAll")
	@ResponseBody
	@Override
	public List<T> findAll() {
		return getService().findAll();
	}

	@RequestMapping("query")
	@ResponseBody
	@Override
	public List<T> query(T queryObj) {
		return getService().query(queryObj);
	}

	@RequestMapping("queryByPage")
	@ResponseBody
	@Override
	public Page<T> queryByPage(T queryObj, int page, int rows) {
		return getService().queryByPage(queryObj, page, rows);
	}

	@RequestMapping("updateAll")
	@ResponseBody
	@Override
	public AjaxResult updateAll(@RequestBody List<T> ls) {
		getService().updateAll(ls);
		finallyCall("deleteIn");
		return AjaxResult.success();
	}

	@RequestMapping("update")
	@ResponseBody
	@Override
	public AjaxResult update(T entity) {
		getService().update(entity);
		finallyCall("update");
		return AjaxResult.success();
	}

	/**
	 * 执行增删改后固定执行的方法，与子类继承
	 */
	public void finallyCall(String modthodName) {
	};

}
