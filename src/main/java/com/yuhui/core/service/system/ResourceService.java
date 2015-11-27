package com.yuhui.core.service.system;

import java.util.List;

import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.service.base.BaseService;

/**
 * 资源管理service
 * @author zhangy
 *
 */
public interface ResourceService extends BaseService<ResourceBase>  {

	/**
	 * 根据资源id获取资源
	 * 
	 * @param id
	 * @return
	 */
	public ResourceBase get(String id);

	/**
	 * 保存资源
	 * 
	 * @param resource
	 * @return
	 */
	public int save(ResourceBase resource);

	/**
	 * 根据 多个id，逗号分隔的字符串删除资源
	 * 
	 * @param ids
	 * @return
	 */
	public int deleteIn(String ids);

	/**
	 * 更新所有
	 * 
	 * @param ls
	 */
	int updateAll(List<ResourceBase> ls);

	/**
	 * 获取不继承属性的树
	 * @return
	 */
	public List<ResourceBase> getTreeByNoExtend();
}
