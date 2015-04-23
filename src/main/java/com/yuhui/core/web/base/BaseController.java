package com.yuhui.core.web.base;

import java.util.List;

import com.yuhui.core.entity.base.IdEntity;
import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.utils.page.Page;

/**
 * 基础Controller
 * 
 * @author zhangy
 * 
 * @param <T>
 */
public interface BaseController<T extends IdEntity> {
	/**
	 * 在子类实现的回调函数,为Controller提供默认CRUD操作所需的service.
	 * 
	 * @return 返回service
	 */
	public BaseService<T> getService();

	/**
	 * 保存实体，若id为空则赋值UUID
	 * 
	 * @param entity
	 * @return
	 */
	public AjaxResult save(T entity);

	/**
	 * 删除PO
	 * 
	 * @param id
	 *            需要删除的PO的ID
	 * @return 返回影响的行数
	 */
	public AjaxResult delete(final String id);

	/**
	 * 批量删除PO
	 * 
	 * @param ids
	 *            需要批量删除的PO的ID字符串
	 * @param clz
	 *            PO对应的类
	 * @return 返回影响的行数
	 */
	public AjaxResult deleteIn(final String ids);

	/**
	 * 通过ID获取PO
	 * 
	 * @param id
	 *            PO对应的ID
	 * @return 返回ID为id的PO对象
	 */
	public T get(final String id);

	/**
	 * 获取所有PO的集合
	 * 
	 * @return 返回所有T类对象的集合
	 */
	public List<T> findAll();

	/**
	 * 通过PO对象 查询PO的集合
	 * 
	 * @param queryObj
	 *            参数对象
	 * @return 返回按参数对象查询T类对象的集合
	 */
	public List<T> query(T queryObj);

	/**
	 * 通过PO对象 查询对象分页数据
	 * 
	 * @param queryObj
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Page<T> queryByPage(T queryObj, int pageNumber, int pageSize);

	/**
	 * 更新所有PO
	 * 
	 * @param ls
	 */
	public AjaxResult updateAll(List<T> ls);

	/**
	 * 更新对象的非空字段
	 * 
	 * @param entity
	 * @return
	 */
	public AjaxResult update(T entity);
}
