package com.yuhui.core.service.system.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.system.ResourceBaseDAO;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.service.system.ResourceService;
import com.yuhui.core.utils.TreeUtils;

/**
 * 资源管理service实现类
 * 
 * @author zhangtq
 * @since 2013/06/26
 */
@Service(value = "resourceService")
@Transactional(readOnly = true)
public class ResourceServiceImpl extends BaseServiceImpl<ResourceBase> implements ResourceService {

	@Autowired
	private ResourceBaseDAO resourceBaseDAO;

	@Override
	public BaseRepository<ResourceBase> getMybatisDAO() {
		return resourceBaseDAO;
	}

	@Override
	public List<ResourceBase> getTreeByNoExtend() {
		return TreeUtils.formatTree(resourceBaseDAO.findAll(ResourceBase.class));
	}

}
