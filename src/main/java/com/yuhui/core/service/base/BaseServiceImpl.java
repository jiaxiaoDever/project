package com.yuhui.core.service.base;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
//import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.persistence.Id;
//import java.util.UUID;

//import javax.persistence.Id;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.yuhui.core.repository.mybatis.template.BaseCRUDTemplate;
import com.yuhui.core.utils.BeanUtils;
import com.yuhui.core.utils.JQGridResponse;
import com.yuhui.core.utils.SqlUtils;
import com.yuhui.core.utils.page.Page;
import com.yuhui.core.utils.page.PageParameter;

@Service(value = "service")
@Transactional(readOnly = true)
public abstract class BaseServiceImpl<T extends Serializable> implements BaseService<T> {

	protected Logger logger = LoggerFactory.getLogger(getClass());

	protected Class<T> entityClass;

	@SuppressWarnings("unchecked")
	public BaseServiceImpl() {
		entityClass = getSuperClassGenricType(getClass(), 0);
	}

	@SuppressWarnings("rawtypes")
	public Class getSuperClassGenricType(Class<?> clazz, int index) {

		Type genType = clazz.getGenericSuperclass();

		if (!(genType instanceof ParameterizedType)) {
			logger.warn(clazz.getSimpleName() + "'s superclass not ParameterizedType");
			return Object.class;
		}

		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();

		if (index >= params.length || index < 0) {
			logger.warn("Index: " + index + ", Size of " + clazz.getSimpleName() + "'s Parameterized Type: " + params.length);
			return Object.class;
		}
		if (!(params[index] instanceof Class)) {
			logger.warn(clazz.getSimpleName() + " not set the actual class on superclass generic parameter");
			return Object.class;
		}
		return (Class) params[index];
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public int save(T entity) {
		String idname = BaseCRUDTemplate.getEntityId(entity.getClass());
		int rs = 0;
		try {
			Object id = org.apache.commons.beanutils.BeanUtils.getProperty(entity, idname);
			try {
				if(id == null || "".equals(id)){					
					BeanUtils.executeSetMethod(entity, idname, UUID.randomUUID().toString());
					rs = getMybatisDAO().insert(entity);
				} else{
					rs = this.update(entity);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
		return rs;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public int delete(String id) {
		if (id != null && !"".equals(id))
			return getMybatisDAO().delete(entityClass, id);
		return 0;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public int deleteIn(String ids) {
		if (ids != null && !"".equals(ids))
			return getMybatisDAO().deleteIn(ids, entityClass);
		return 0;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public int updateAll(List<T> ls) {
		int rs = 0;
		for (T entity : ls) {
			int trs = getMybatisDAO().updateNotNullField(entity);
			if(trs > 0) rs ++;
		}
		return rs;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public int update(T entity) {
		 return getMybatisDAO().updateNotNullField(entity);
	}

	public T get(String id) {
		if (id != null && !"".equals(id))
			return getMybatisDAO().get(entityClass, id);
		return null;
	}

	public List<T> findAll() {
		return getMybatisDAO().findAll(entityClass);
	}

	public List<T> query(T queryObj) {
		if (queryObj != null)
			return getMybatisDAO().query(queryObj);
		return null;
	}

	public JQGridResponse getPage(Map<String, Object> parameters, int pageNumber, int pageSize) {
		if (pageNumber < 1)
			pageNumber = 1;
		if (pageSize < MIN_PAGE_SIZE || pageSize > MAX_PAGE_SIZE)
			pageSize = DEF_PAGE_SIZE;
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);
		List<Map<String, Object>> list = getMybatisDAO().queryByPage(page, parameters);
		JQGridResponse jqpage = new JQGridResponse();
		jqpage.setPage(pageNumber);
		jqpage.setRecords(page.getTotalCount());
		jqpage.setRows(list);
		jqpage.setTotal(page.getTotalPage());
		return jqpage;
	}

	public Page<T> queryByPage(T queryObj, int pageNumber, int pageSize) {
		PageParameter page = new PageParameter();
		page.setCurrentPage(pageNumber);
		page.setPageSize(pageSize);
		SqlUtils.formatQueryObject(queryObj);
		List<T> lst = getMybatisDAO().queryObjectByPage(page, queryObj);
		int countnum = getMybatisDAO().queryObjectTotalRow(queryObj);
		page.setTotalCount(countnum);
		int totalPage = countnum / page.getPageSize() + ((countnum % page.getPageSize() == 0) ? 0 : 1);
		page.setTotalPage(totalPage);
		Page<T> result = new Page<T>(page, lst);
		return result;
	}

}
