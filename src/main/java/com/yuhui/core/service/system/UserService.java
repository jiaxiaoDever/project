package com.yuhui.core.service.system;

import java.util.List;

import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.service.base.BaseService;
import com.yuhui.core.utils.page.Page;

/**
 * 用户管理service
 */
public interface UserService extends BaseService<UserBase> {

	public static final String HASH_ALGORITHM = "SHA-1";

	public static final int HASH_INTERATIONS = 1024;

	public static final int SALT_SIZE = 8;

	/**
	 * 根据用户ID查询出该用户信息
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param id
	 *            用户ID
	 * @return 返回拥有ID为id的用户信息
	 */
	public UserBase getUser(String id);

	/**
	 * 根据用户账号查询用户信息
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param username
	 *            用户的账号
	 * @return 返回拥有用户账号为username的用户信息
	 */
	public UserBase findUserByUserName(String userName);

	/**
	 * 添加或编辑用户信息，用户参数中ID有值认为是编辑事件，否则认为是添加事件
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param user
	 *            用户信息数据 必须传递
	 * @param roleids
	 *            用户角色ids,多个ID间以","隔开 必须传递
	 * @return 返回数据库所更新的行数
	 */
	public int save(UserBase user, String roleids);

	/**
	 * 按用户id批量删除用户 根据 多个id，逗号分隔的字符串删除菜单
	 * 
	 * @param ids
	 *            需要删除的用户的ids,多个ID间以","隔开 必须传递
	 * @return 返回数据库所更新的行数
	 */
	public int deleteIn(String ids);

	/**
	 * 查询所有用户数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @return 返回所有用户数据
	 */
	List<UserBase> getAll();

	/**
	 * 查询用户分页数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param queryObj
	 *            用户参数
	 * @param pageNumber
	 *            当前页数
	 * @param pageSize
	 *            每页显示行数
	 * @return 返回用户信息的分页数据
	 */
	Page<UserBase> queryByPage(UserBase queryObj, int pageNumber, int pageSize);

	// 下面这两个方法为测试分页使用
	public List<UserBase> getUsersByPage(int pageNumber, int pageSize);

	public Page<UserBase> getPageUsers(String username, int pageNumber, int pageSize);

	/**
	 * 查询，列出所有结果
	 * 
	 * @param queryObj
	 * @return
	 */
	List<UserBase> query(UserBase queryObj);

}
