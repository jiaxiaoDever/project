package com.yuhui.core.web.system;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.service.system.RoleService;
import com.yuhui.core.service.system.UserService;
import com.yuhui.core.utils.CacheUtils;
import com.yuhui.core.utils.Constants;
import com.yuhui.core.utils.LocaleUtils;
import com.yuhui.core.utils.page.Page;
import com.yuhui.core.web.base.BaseControllerImpl;

/**
 * 用户管理
 * 
 * @author 肖长江
 * 
 */
@Controller
@RequestMapping(value = "/system/user")
public class UserController extends BaseControllerImpl<UserBase> {

	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;

	/**
	 * 评论选择用户,要过滤掉当前用户 author chend date 2014-03-11
	 * 
	 * @param queryObj
	 *            查询对象
	 * @param page
	 *            分页
	 * @param rows
	 * @return page
	 */
	@RequestMapping("queryUsersByPageN")
	@ResponseBody
	public Page<UserBase> queryUsersByPageN(UserBase queryObj, int page, int rows) {
		Page<UserBase> tempPage = userService.queryByPage(queryObj, page, rows);
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		UserBase userBase = userService.findUserByUserName(user.getUsername());
		if (tempPage.getResult() != null && tempPage.getResult().size() > 0) {
			List<UserBase> list = tempPage.getResult();
			for (UserBase base : list) {
				if (base.getId().equals(userBase.getId())) {
					list.remove(base);
					break;
				}
			}
			tempPage.setResult(list);
		}
		return tempPage;
	}

	/**
	 * 添加或编辑用户信息，用户参数中ID有值认为是编辑事件，否则认为是添加事件
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param userBase
	 *            用户信息数据 必须传递
	 * @param roleids
	 *            用户角色ids,多个ID间以","隔开 必须传递
	 * @return
	 */
	@RequestMapping("saveUser")
	@ResponseBody
	public AjaxResult save(HttpSession session, UserBase userBase, String roleids) {
		userBase.setStateDate(new Date());
		userService.save(userBase, roleids);
		// 如果是用户自己修改的个人信息，则更新session中的该用户信息
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (userBase != null && userBase.getId().equals(user.getId())) {
			userBase = userService.findUserByUserName(user.getUsername());
			session.setAttribute("user", userBase);
		}
		return AjaxResult.success(LocaleUtils.get("ajaxResult.saveOk"), userBase);
	}

	@Override
	public AjaxResult save(UserBase entity) {
		entity.setStateDate(new Date());
		return super.save(entity);
	}

	/**
	 * 查找所有机构，并封装成带树结构的机构列表返回
	 * 
	 * @author 肖长江
	 * @date 2013-10-9
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("getOrgTree")
	@ResponseBody
	public List<Organization> getOrgTree() {
		return (List<Organization>) CacheUtils.get(Constants.CACHE_ORG_TREE);
	}

	/**
	 * 查找所有角色
	 * 
	 * @author 肖长江
	 * @date 2013-10-9
	 * @return
	 */
	@RequestMapping("findAllRole")
	@ResponseBody
	public List<RoleBase> findAllRole() {
		return roleService.findAll();
	}

	/**
	 * 通过校验是否已经存在某个用户账号,决定能否新增该账户名的用户
	 * 
	 * @author 肖长江
	 * @date 2013-10-14
	 * @param username
	 *            用户账号 必须传递
	 * @return 已经存在返回false,不存在返回true
	 */
	@RequestMapping("checkUsername")
	@ResponseBody
	public Boolean checkUsername(String username) {
		Boolean flag = true;
		if (username != null && !"".equals(username)) {
			UserBase userBase = userService.findUserByUserName(username);
			if (userBase != null && username.equals(userBase.getUsername()))
				flag = false;
		}
		return flag;
	}

	@Override
	public BaseService<UserBase> getService() {
		return userService;
	}
}
