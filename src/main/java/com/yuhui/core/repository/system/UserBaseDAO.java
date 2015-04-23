package com.yuhui.core.repository.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.entity.system.UserRole;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;
import com.yuhui.core.utils.page.PageParameter;

/**
 * 用户对象数据访问及持久接口
 * 
 * @author 肖长江
 */
@Repository("userBaseDAO")
@MyBatisRepository()
public interface UserBaseDAO extends BaseRepository<UserBase> {

	/**
	 * 根据用户账号名称查找用户对象
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param username
	 *            用户账号 必须传递
	 * @return 返回用户账号为username的用户对象
	 */
	public UserBase findByUserName(String userName);

	/**
	 * 根据参数查找用户分页数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param map
	 *            参数
	 * @param page
	 *            分页对象
	 * @return 返回用户分页数据
	 */
	public List<UserBase> getUsersByPage(@SuppressWarnings("rawtypes") HashMap map, PageParameter page);

	/**
	 * 查询一定参数条件下用户总数
	 * 
	 * @author 肖长江
	 * @date 2013-11-25
	 * @param parameters
	 *            参数
	 * @return 返回一定参数条件下用户总数
	 */
	public int queryUsersCount(@Param(value = "parameters") Map<String, Object> parameters);

	/**
	 * 插入用户角色中间表数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * @param userRole
	 *            用户对应的角色
	 * @return 返回影响的行数
	 */
	public int insertUserRole(UserRole userRole);

	/**
	 * 根据用户ID删除用户角色中间表数据
	 * 
	 * @author 肖长江
	 * @date 2013-10-17
	 * 
	 * @param userId
	 *            用户ID
	 * @return 返回影响的行数
	 */
	public int deleteUserRole(String userId);
}
