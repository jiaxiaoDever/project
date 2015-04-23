package com.yuhui.core.security;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cas.CasAuthenticationException;
import org.apache.shiro.cas.CasRealm;
import org.apache.shiro.cas.CasToken;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.StringUtils;
import org.jasig.cas.client.authentication.AttributePrincipal;
import org.jasig.cas.client.validation.Assertion;
import org.jasig.cas.client.validation.TicketValidationException;
import org.jasig.cas.client.validation.TicketValidator;
import org.springframework.beans.factory.annotation.Autowired;
import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.service.system.UserService;

public class ShiroDbCasRealm extends CasRealm {
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
	

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
		    throws AuthenticationException
		  {
		    CasToken casToken = (CasToken)token;
		    if (token == null) {
		      return null;
		    }

		    String ticket = (String)casToken.getCredentials();
		    if (!StringUtils.hasText(ticket)) {
		      return null;
		    }

		    TicketValidator ticketValidator = ensureTicketValidator();
		    try
		    {
		      Assertion casAssertion = ticketValidator.validate(ticket, getCasService());

		      AttributePrincipal casPrincipal = casAssertion.getPrincipal();
		      String userId = casPrincipal.getName();

		      UserBase user = userService.findUserByUserName(userId);
		      
		      Map<String,Object> attributes = casPrincipal.getAttributes();

		      casToken.setUserId(userId);
		      String rememberMeAttributeName = getRememberMeAttributeName();
		      String rememberMeStringValue = (String)attributes.get(rememberMeAttributeName);
		      boolean isRemembered = (rememberMeStringValue != null) && (Boolean.parseBoolean(rememberMeStringValue));
		      if (isRemembered) {
		        casToken.setRememberMe(true);
		      }

		      ShiroUser shiroUser =  new ShiroUser(user.getId(), user.getUsername(), user.getName());
		      List<ShiroUser> principals = new ArrayList<ShiroUser>();
		      principals.add(shiroUser);
		      PrincipalCollection principalCollection = new SimplePrincipalCollection(principals, getName());
		      return new SimpleAuthenticationInfo(principalCollection, ticket);
		    } catch (TicketValidationException e) {
		      throw new CasAuthenticationException("Unable to validate ticket [" + ticket + "]", e);
		    }
		  }

	

	/**
	 * 设定Password校验的Hash算法与迭代次数.(Bean初始化后调用)
	 */
	
	/**
	 * 
	 
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(UserService.HASH_ALGORITHM);
		matcher.setHashIterations(UserService.HASH_INTERATIONS);

		setCredentialsMatcher(matcher);
	}
*/
}
