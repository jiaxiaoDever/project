package com.yuhui.core.service.system.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.crypto.hash.Sha1Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.entity.system.UserRole;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.system.UserBaseDAO;
import com.yuhui.core.security.utils.Digests;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.service.system.UserService;
import com.yuhui.core.utils.Encodes;
import com.yuhui.core.utils.page.Page;
import com.yuhui.core.utils.page.PageParameter;

/**
 * 用户管理service实现类
 * 
 * @author zhangtq
 * @since 2013/06/26
 */
// Spring Bean的标识.
@Service(value = "userService")
@Transactional(readOnly = true)
public class UserServiceImpl extends BaseServiceImpl<UserBase> implements UserService {

	@Autowired
	private UserBaseDAO userBaseDAO;

	@Override
	public UserBase getUser(String id) {
		return userBaseDAO.get(UserBase.class, id);
	}

	@Override
	public List<UserBase> getAll() {
		return userBaseDAO.findAll(UserBase.class);
	}

	@Override
	public UserBase findUserByUserName(String userName) {
		return userBaseDAO.findByUserName(userName);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int save(UserBase user, String roleids) {
		user.setStateDate(new Date());
		String userId = user.getId();
		if (user.getId() == null || "".equals(user.getId()))
			userId = UUID.randomUUID().toString();
		List<UserRole> userRoles = null;
		if (roleids != null && !"".equals(roleids)) {
			userRoles = new ArrayList<UserRole>();
			String[] idses = roleids.split(",");
			for (String id : idses) {
				if (id != null && !"".equals(id)) {
					userRoles.add(new UserRole(userId, id));
				}
			}
		}
		if (user.getId() != null && !"".equals(user.getId())) {
			String password = user.getPassword();
			if (password != null && !"".equals(password) && password.length() < 20) {
				entryptPassword(user);
			}
			int rs = userBaseDAO.updateNotNullField(user);
			userBaseDAO.deleteUserRole(user.getId());
			if (userRoles != null && userRoles.size() > 0) {
				for (UserRole userRole : userRoles) {
					userBaseDAO.insertUserRole(userRole);
				}
			}
			return rs;
		} else {
			// 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
			if (StringUtils.isNotBlank(user.getPassword())) {
				entryptPassword(user);
			}
			user.setId(userId);
			int rs = userBaseDAO.insert(user);
			if (userRoles != null && userRoles.size() > 0 && rs > 0) {
				for (UserRole userRole : userRoles) {
					userBaseDAO.insertUserRole(userRole);
				}
			}
			return rs;
		}
	}

	/**
	 * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
	 */
	private void entryptPassword(UserBase user) {
		byte[] salt = Digests.generateSalt(SALT_SIZE);
		String saltStr = Encodes.encodeHex(salt);
		user.setSalt(saltStr);

		// 采用shiro自身的加密算法。
		Sha1Hash sha1Hash = new Sha1Hash(user.getPassword().getBytes(), salt, HASH_INTERATIONS);
		String passwordEncoder = sha1Hash.toString();
		user.setPassword(passwordEncoder);

		/*
		 * byte[] hashPassword = Digests.sha1(user.getPassword().getBytes(),
		 * salt, HASH_INTERATIONS);
		 * user.setPassword(Encodes.encodeHex(hashPassword));
		 */
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int deleteIn(String ids) {
		int i = 0;
		if (ids != null && !"".equals(ids)) {
			String[] idses = ids.split(",");
			for (String id : idses) {
				userBaseDAO.deleteUserRole(id);
				userBaseDAO.deleteIn(id, UserBase.class);
				i++;
			}
		}
		return i;
	}

	public void tt() {

	}

	// 以下这个两个方法为测试分页
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<UserBase> getUsersByPage(int pageNumber, int pageSize) {
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);
		HashMap map = new HashMap();
		map.put("username", "admin");
		List<UserBase> lst = userBaseDAO.getUsersByPage(map, page);
		// Page<UserBase> result = new Page(page,lst);
		return lst;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Page<UserBase> getPageUsers(int pageNumber, int pageSize) {
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);
		HashMap map = new HashMap();
		map.put("username", "admin");
		List<UserBase> lst = userBaseDAO.getUsersByPage(map, page);
		Page<UserBase> result = new Page<UserBase>(page, lst);
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Page<UserBase> getPageUsers(String username, int pageNumber, int pageSize) {
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);
		HashMap map = new HashMap();
		map.put("username", username);
		List<UserBase> lst = userBaseDAO.getUsersByPage(map, page);
		Page<UserBase> result = new Page<UserBase>(page, lst);
		return result;
	}

	@Override
	public List<UserBase> query(UserBase queryObj) {
		List<UserBase> ls = userBaseDAO.query(queryObj);
		return ls;
	}

	@Override
	public BaseRepository<UserBase> getMybatisDAO() {
		return userBaseDAO;
	}

}
