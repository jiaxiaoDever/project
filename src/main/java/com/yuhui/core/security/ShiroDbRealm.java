package com.yuhui.core.security;

import javax.annotation.PostConstruct;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.service.system.UserService;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.utils.Encodes;

public class ShiroDbRealm extends AuthorizingRealm {
	@Autowired
	protected UserService userService;

	/**
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principal) {
		ShiroUser shiroUser = (ShiroUser) principal.getPrimaryPrincipal();
		UserBase user = userService.findUserByUserName(shiroUser.getUsername());
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		if (CollectionUtils.isNotEmpty(user.getRoles())) {
			for (RoleBase role : user.getRoles()) {
				// 基于Role的权限信息
				info.addRole(role.getName());
				// 基于Permission的权限信息
				// info.addStringPermissions(role.getPermissionList());
			}
		}
		return info;
	}

	/**
	 * 认证回调函数,登录时调用.
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authToken;
		UserBase user = userService.findUserByUserName(token.getUsername());
		if (user != null) {
			if (Constants.STATE_INVALID.equals(user.getState())) {
				throw new DisabledAccountException();
			}
			byte[] salt = Encodes.decodeHex(user.getSalt());
			SimpleAuthenticationInfo authentication = new SimpleAuthenticationInfo(new ShiroUser(user.getId(), user.getUsername(), user.getName()), user.getPassword(),
					ByteSource.Util.bytes(salt), getName());
			return authentication;
		} else {
			return null;
		}
	}

	/**
	 * 设定Password校验的Hash算法与迭代次数.(Bean初始化后调用)
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(UserService.HASH_ALGORITHM);
		matcher.setHashIterations(UserService.HASH_INTERATIONS);

		setCredentialsMatcher(matcher);
	}

}
