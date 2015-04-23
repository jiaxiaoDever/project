package com.yuhui.core.service.system;

import java.util.List;

import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.service.base.BaseService;

/**
 * 机构管理service
 * @author zhangy
 *
 */
public interface OrgService extends BaseService<Organization> {

	/**
	 * 根据父机构ID获取子机构
	 * 
	 * @author 肖长江
	 * @date 2013-9-30
	 * @param id
	 *            父机构ID
	 * @return 返回父机构ID为id下面所有的子机构列表
	 */
	List<Organization> findByParentId(String id);

}
