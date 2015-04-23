package com.yuhui.core.service.system.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.base.InitLoader;
import com.yuhui.core.entity.system.PortPageLayout;
import com.yuhui.core.entity.system.Portlet;
import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.entity.system.RolePortlet;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.repository.system.PortletDAO;
import com.yuhui.core.service.system.PortletService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;

@Service(value = "portletService")
@Transactional(readOnly = true)
public class PortletServiceImpl implements PortletService {

	@Autowired
	private PortletDAO portletDAO;
	@Autowired
	InitLoader initLoader;

	public PortletServiceImpl() {
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Portlet> findUserPortlets(UserBase user) {
		List<Portlet> pls = new ArrayList<Portlet>();
		Map<String, List<Portlet>> rpsMap = (Map<String, List<Portlet>>) CacheUtils.get(Constants.CACHE_ROLE_PORTLET_MAP);
		if (rpsMap != null && rpsMap.size() > 0 && user != null && user.getRoles() != null && user.getRoles().size() > 0) {
			List<String> op = new ArrayList<String>();
			for (RoleBase role : user.getRoles()) {
				if (rpsMap.containsKey(role.getId())) {
					for (Portlet p : rpsMap.get(role.getId())) {
						if (!op.contains(p.getId())) {
							pls.add(p);
							op.add(p.getId());
						}
					}
				}
			}
			op = null;
		}
		List<Portlet> tpls = portletDAO.querySelfPortlet(user);
		if (tpls != null && tpls.size() > 0)
			pls.addAll(tpls);
		return pls;
	}

	@Override
	public PortPageLayout findUserPortPageLayout(UserBase user) {
		PortPageLayout ppLayout = portletDAO.queryUserPortPageLayout(user);
		if (ppLayout == null) {
			List<PortPageLayout> ppLayouts = portletDAO.queryUserRolePortPageLayout(user);
			if (ppLayouts != null && ppLayouts.size() > 0)
				ppLayout = ppLayouts.get(0);
		}
		return ppLayout;
	}

	@Override
	public PortPageLayout findRolePortPageLayout(String roleId) {
		List<PortPageLayout> ppLayouts = portletDAO.queryRolePortPageLayout(roleId);
		if (ppLayouts != null && ppLayouts.size() > 0)
			return ppLayouts.get(0);
		return null;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int saveLayout(PortPageLayout layout) {
		if (layout != null) {
			int fortype = layout.getForType();
			if (fortype == 1) {
				return saveUserLayout(layout);
			} else {
				return saveRoleLayout(layout);
			}
		}
		return 0;
	}

	private int saveRoleLayout(PortPageLayout layout) {
		List<PortPageLayout> ppLayouts = portletDAO.queryRolePortPageLayout(layout.getForId());
		PortPageLayout ppLayout = null;
		if (ppLayouts != null && ppLayouts.size() > 0) {
			for (PortPageLayout pLayout : ppLayouts) {
				if (pLayout.getForId().equals(layout.getForId()))
					ppLayout = pLayout;
			}
		}
		if (ppLayout == null) {
			layout.setId(UUID.randomUUID().toString());
			return portletDAO.insert(layout);
		} else {
			layout.setId(ppLayout.getId());
			return portletDAO.updateNotNullField(layout);
		}
	}

	private int saveUserLayout(PortPageLayout layout) {
		UserBase user = new UserBase();
		user.setId(layout.getForId());
		PortPageLayout ppLayout = portletDAO.queryUserPortPageLayout(user);
		if (ppLayout == null) {
			layout.setId(UUID.randomUUID().toString());
			return portletDAO.insert(layout);
		} else {
			layout.setId(ppLayout.getId());
			return portletDAO.updateNotNullField(layout);
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int addSysPortlet(Portlet portlet) {
		portlet.setCategory(1);
		portlet.setId(UUID.randomUUID().toString());
		return portletDAO.insertPortlet(portlet);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int addUserPortlet(Portlet portlet) {
		portlet.setCategory(2);
		portlet.setId(UUID.randomUUID().toString());
		return portletDAO.insertPortlet(portlet);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int removePortlet(Portlet portlet) {
		int ri = portletDAO.deletePortlet(portlet);
		if (ri > 0) {
			portletDAO.deleteAllRolePortlets(portlet.getId());
			initLoader.initRolePortlets();
		}
		return ri;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int addRolePortlet(String roleIds, String portletId) {
		int rs = 0;
		if (roleIds != null && !"".equals(roleIds)) {
			String[] rids = roleIds.split(",");
			for (String rid : rids) {
				if (rid == null || "".equals(rid))
					continue;
				Map<String, String> params = new HashMap<String, String>();
				params.put("roleId", rid);
				params.put("portletId", portletId);
				int trs = portletDAO.deleteRolePortlets(params);
				int trs2 = portletDAO.insertRolePortlets(params);
				rs += trs + trs2;
			}
			initLoader.initRolePortlets();
		}
		return rs;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int removePortletOfRoles(Portlet portlet) {
		int rs = portletDAO.deleteAllRolePortlets(portlet.getId());
		initLoader.initRolePortlets();
		return rs;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int removeRolePortlet(String roleId, String portletId) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("roleId", roleId);
		params.put("portletId", portletId);
		int rs = portletDAO.deleteRolePortlets(params);
		initLoader.initRolePortlets();
		return rs;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int removeRoleAllPortlet(String roleId) {
		int rs = portletDAO.deleteAllPortletsOfRole(roleId);
		initLoader.initRolePortlets();
		return rs;
	}

	@Override
	public List<Portlet> findSysPortlets() {
		return portletDAO.querySysPortlet();
	}

	@Override
	public List<RolePortlet> findRolePortlets() {
		return portletDAO.queryRolePortlets();
	}

}
