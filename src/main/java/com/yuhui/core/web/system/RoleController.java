package com.yuhui.core.web.system;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.entity.system.RoleBase;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.service.system.RoleService;
import com.yuhui.core.web.base.BaseControllerImpl;

/**
 * 角色管理
 * 
 * @author 肖长江
 */
@Controller
@RequestMapping(value = "/system/role")
public class RoleController extends BaseControllerImpl<RoleBase> {

	@Autowired
	private RoleService roleService;

	/**
	 * 编辑或添加一个角色，角色参数中ID有值认为是编辑事件，否则认为是添加事件
	 * 
	 * @author 肖长江
	 * @date 2013-9-27
	 * @param roleBase
	 *            角色数据 必须传递
	 * @return
	 */
	@Override
	public AjaxResult save(RoleBase entity) {
		entity.setStateDate(new Date());
		return super.save(entity);
	}

	/**
	 * 保存角色拥有的菜单权限
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param roleBase
	 *            角色对象 必须传递
	 * @param ids
	 *            菜单ids，多个ID间以","隔开 必须传递
	 * @return
	 */
	@RequestMapping("saveRoleMenu")
	@ResponseBody
	public AjaxResult saveRoleMenu(RoleBase roleBase, String ids) {
		roleService.editRoleMenu(roleBase, ids);
		return AjaxResult.success();
	}

	/**
	 * 通过校验是否已经存在某个角色,决定能否新增该角色
	 * 
	 * @author 肖长江
	 * @date 2013-10-14
	 * @param name
	 *            角色名称 必须传递
	 * @return 已经存在返回false,不存在返回true
	 */
	@RequestMapping("checkRoleName")
	@ResponseBody
	public Boolean checkRoleName(String name) {
		Boolean flag = true;
		if (name != null && !"".equals(name)) {
			RoleBase rbs = roleService.findByRoleName(name);
			if (rbs != null)
				flag = false;
		}
		return flag;
	}

	@Override
	public BaseService<RoleBase> getService() {
		return roleService;
	}
}
