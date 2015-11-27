package com.yuhui.core.service.base;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.utils.JQGridResponse;
import com.yuhui.core.utils.page.Page;

/**
 * @author 肖长江 所有实体基本业务查询及事件
 * @param <T>
 *            实体类泛型
 */
public interface BaseService<T extends Serializable> {

	public static final int MIN_PAGE_SIZE = 1;
	public static final int DEF_PAGE_SIZE = 10;
	public static final int MAX_PAGE_SIZE = 100;

	/**
	 * 在子类实现的回调函数,为service提供默认CRUD操作所需的DAO.
	 * 
	 * @author 肖长江
	 * @date 2013-9-24
	 * @return 返回BaseRepository
	 */
	public BaseRepository<T> getMybatisDAO();

	/**
	 * 保存实体，若id为空则赋值UUID
	 * 
	 * @param entity
	 * @return
	 */
	public int save(T entity);

	/**
	 * 删除PO
	 * 
	 * @author 肖长江
	 * @date 2013-9-24
	 * @param id
	 *            需要删除的PO的ID
	 * @return 返回影响的行数
	 */
	public int delete(String id);

	/**
	 * 批量删除PO
	 * 
	 * @author 肖长江
	 * @date 2013-9-24
	 * @param ids
	 *            需要批量删除的PO的ID字符串
	 * @param clz
	 *            PO对应的类
	 * @return 返回影响的行数
	 */
	public int deleteIn(@Param(value = "ids") final String ids);

	/**
	 * 通过ID获取PO
	 * 
	 * @author 肖长江
	 * @date 2013-9-24
	 * @param id
	 *            PO对应的ID
	 * @return 返回ID为id的PO对象
	 */
	public T get(String id);

	/**
	 * 获取所有PO的集合
	 * 
	 * @author 肖长江
	 * @date 2013-9-24
	 * @return 返回所有T类对象的集合
	 */
	public List<T> findAll();

	/**
	 * 通过PO对象获取PO的集合
	 * 
	 * @author 肖长江
	 * @date 2013-9-24
	 * @param queryObj
	 *            参数对象
	 * @return 返回按参数对象查询T类对象的集合
	 */
	public List<T> query(T queryObj);

	/**
	 * 查询分页数据
	 * 
	 * @author 肖长江
	 * @date 2013-9-24
	 * @param pageNumber
	 *            当前页
	 * @param pageSize
	 *            每页数据条数
	 * @param parameters
	 *            查询参数
	 * @return 返回当前条件下的分页数据
	 */
	public JQGridResponse getPage(Map<String, Object> parameters, int pageNumber, int pageSize);

	/**
	 * 查询对象分页数据
	 * 
	 * @param queryObj
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Page<T> queryByPage(T queryObj, int pageNumber, int pageSize);

	/**
	 * 更新所有
	 * 
	 * @param ls
	 */
	public int updateAll(List<T> ls);
	
	/**
	 * 更新一个对象的非空字段
	 * @param entity
	 */
	public int update(T entity);
}
