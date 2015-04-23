package com.yuhui.core.service.system.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.system.OrganizationDAO;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.service.system.OrgService;

/**
 * 机构管理service实现类
 * 
 * @author zhangy
 * 
 */
@Service(value = "orgService")
@Transactional(readOnly = true)
public class OrgServiceImpl extends BaseServiceImpl<Organization> implements OrgService {

	@Autowired
	private OrganizationDAO organizationDAO;

	@Override
	public BaseRepository<Organization> getMybatisDAO() {
		return organizationDAO;
	}

	@Override
	public List<Organization> findByParentId(String id) {
		return organizationDAO.findByParentId(id);
	}

}
