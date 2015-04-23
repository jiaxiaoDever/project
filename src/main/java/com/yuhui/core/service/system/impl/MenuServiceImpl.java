package com.yuhui.core.service.system.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.entity.system.MenuBase;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.system.MenuBaseDAO;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.service.system.MenuService;

/**
 * 菜单管理service实现类
 * 
 * @author zhangy
 */
// Spring Bean的标识.
@Service(value = "menuService")
@Transactional(readOnly = true)
public class MenuServiceImpl extends BaseServiceImpl<MenuBase> implements MenuService {

	@Autowired
	private MenuBaseDAO menuBaseDAO;

	@Override
	public BaseRepository<MenuBase> getMybatisDAO() {
		return menuBaseDAO;
	}

	@Override
	public List<MenuBase> getButtonsByParentCode(String code, String userId) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("code", code);
		params.put("userId", userId);
		List<MenuBase> list = menuBaseDAO.getButtonsByParentCode(params);
		return list;
	}

	@Override
	public List<MenuBase> findByParentId(MenuBase menu) {
		List<MenuBase> list = menuBaseDAO.findByParentId(menu);
		return list;
	}

	@Override
	public List<String> getMenuIdByRoleId(String id) {
		if (StringUtils.isBlank(id)) {
			return null;
		}
		List<String> ls = menuBaseDAO.getMenuIdByRoleId(id);
		return ls;
	}

	@Override
	public List<MenuBase> getUserMenus(UserBase user) {
		if (user == null || user.getId() == null || "".equals(user.getId()))
			return new ArrayList<MenuBase>();
		return menuBaseDAO.getUserMenus(user.getId());
	}

}
