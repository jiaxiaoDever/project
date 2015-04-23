package com.yuhui.core.service.system.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.entity.system.RoleMenu;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.system.PortletDAO;
import com.yuhui.core.repository.system.RoleBaseDAO;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.service.system.RoleService;

/**
 * 角色管理service实现类
 * 
 * @author zhangy
 * 
 */
@Service(value = "roleService")
@Transactional(readOnly = true)
public class RoleServiceImpl extends BaseServiceImpl<RoleBase> implements RoleService {

	@Autowired
	private RoleBaseDAO roleBaseDAO;
	@Autowired
	private PortletDAO portletDAO;

	@Override
	public BaseRepository<RoleBase> getMybatisDAO() {
		return roleBaseDAO;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean editRoleMenu(RoleBase roleBase, String ids) {
		if (roleBase != null && !"".equals(roleBase.getId())) {
			roleBaseDAO.deleteRoleMenu(roleBase.getId());
			List<RoleMenu> roleMenus = null;
			if (ids != null && !"".equals(ids)) {
				roleMenus = new ArrayList<RoleMenu>();
				String[] idses = ids.split(",");
				for (String id : idses) {
					if (id != null && !"".equals(id)) {
						roleMenus.add(new RoleMenu(roleBase.getId(), id));
					}
				}
			}
			if (roleMenus != null && roleMenus.size() > 0) {
				for (RoleMenu roleMenu : roleMenus) {
					roleBaseDAO.updateRoleMenu(roleMenu);
				}
			}
		}
		return false;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean deleteRoles(String ids) {
		if (ids != null && !"".equals(ids)) {
			String[] idses = ids.split(",");
			for (String id : idses) {
				roleBaseDAO.deleteRoleMenu(id);
				roleBaseDAO.deleteRoleUser(id);
				portletDAO.deleteAllPortletsOfRole(id);
				roleBaseDAO.deleteIn(id, RoleBase.class);
			}
		}
		return false;
	}

	@Override
	public RoleBase findByRoleName(String name) {
		return roleBaseDAO.findByRoleName(name);
	}

}
