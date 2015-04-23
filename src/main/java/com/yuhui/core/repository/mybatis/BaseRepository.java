package com.yuhui.core.repository.mybatis;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.UpdateProvider;

import com.yuhui.core.repository.mybatis.template.BaseCRUDTemplate;
import com.yuhui.core.utils.page.PageParameter;
/**
 * 基础逻辑接口
 * @author zhangy
 *
 * @param <T>
 */
public interface BaseRepository<T extends Serializable> {

	/**
	 * 保存实体 （保存后可以通过entity.getId获得ID）
	 * 
	 * @param entity
	 *            实体对象
	 * @return entity 实体对象
	 */
	@InsertProvider(type = BaseCRUDTemplate.class, method = "insert")
	public int insert(T entity);

	/**
	 * 更新实体
	 * 
	 * @param entity
	 *            实体对象
	 * @return 影响行数
	 */
	@UpdateProvider(type = BaseCRUDTemplate.class, method = "update")
	public int update(T entity);

	/**
	 * 更新实体
	 * 
	 * @param entity
	 *            实体对象
	 * @return 影响行数
	 */
	@UpdateProvider(type = BaseCRUDTemplate.class, method = "updateNotNullField")
	public int updateNotNullField(T entity);

	/**
	 * 根据ID进行删除
	 * 
	 * @param id
	 *            实体ID
	 * @return 影响行数
	 */
	public int delete(@Param(value = "clz") final Class<T> clz,@Param(value = "id") final String id);

	/**
	 * 根据ID批量删除
	 * 
	 * @param ids
	 *            ID逗号分开的字符串
	 * @return 影响行数
	 */
	@UpdateProvider(type = BaseCRUDTemplate.class, method = "deleteIn")
	public int deleteIn(@Param(value = "ids") final String ids, @Param(value = "clz") final Class<T> clz);

	/**
	 * 根据ID查询实体
	 * 
	 * @param id
	 * @return 实体对象
	 */
	@SelectProvider(type = BaseCRUDTemplate.class, method = "get")
	@ResultMap(value = "defaulfResultMap")
	public T get(@Param(value = "clz")final Class<T> clz,@Param(value = "id")final String id);

	/**
	 * 查询所有记录
	 * 
	 * @return 实体对象集合
	 */
	@SelectProvider(type = BaseCRUDTemplate.class, method = "findAll")
	@ResultMap(value = "defaulfResultMap")
	public List<T> findAll(Class<T> clz);

	/**
	 * 动态条件查询
	 * 
	 * @param parameters
	 *            属性名-值的Map
	 * @return 实体对象集合
	 */
	@SelectProvider(type = BaseCRUDTemplate.class, method = "query")
	@ResultMap(value = "defaulfResultMap")
	public List<T> query(@Param(value = "queryObj")T queryObj);

	/**
	 * 查询分页
	 * @param page
	 * @param queryObj
	 * @return
	 */
	@SelectProvider(type = BaseCRUDTemplate.class, method = "queryObjectByPage")
	@ResultMap(value = "defaulfResultMap")
	public List<T> queryObjectByPage(@Param(value = "page")PageParameter page,@Param(value = "queryObj")T queryObj);
	/**
	 * 查询分页统计
	 * @param Obj
	 * @return
	 */
	@SelectProvider(type = BaseCRUDTemplate.class, method = "queryObjectTotalRow")
	@ResultType(value=Integer.class)
	public Integer queryObjectTotalRow(@Param(value="queryObj") T queryObj);
	/**
	 * @author 肖长江
	 * @date 2013-9-24
	 * 按条件查询分页数据
	 * @param page 分页条件
	 * @param parameters 查询条件
	 * @return 分页对象集合
	 */
	public List<Map<String, Object>> queryByPage(PageParameter page,@Param(value="parameters") Map<String, Object> parameters);
//	public List<T> queryObjectByPage(PageParameter page,@Param(value="parameters") T Obj);
	
	public int queryTotalRow(@Param(value="parameters") Map<String, Object> parameters);
	public List<T> queryByMap(@Param(value="parameters") Map<String, Object> parameters);
}
