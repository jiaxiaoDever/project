package com.yuhui.core.repository.mybatis.template;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Id;

import org.apache.ibatis.jdbc.SQL;

import com.yuhui.core.entity.common.SqlFieldValueBean;
import com.yuhui.core.utils.SqlUtils;

/**
 * 基础逻辑代理
 * @author zhangy
 *
 */
public class BaseCRUDTemplate {

	public static Map<String, String> entityIdMap = new HashMap<String, String>();
	public static Map<String, String> entityIdNameMap = new HashMap<String, String>();
	private static String defaultIdColumn = "id";
	private static String defaultIdName = "id";
	public static String getEntityIdColumn(Class<?> clz){
		initEntiryIdColumn(clz);
		return entityIdMap.get(clz.getName());
	}
	
	public static String getEntityId(Class<?> clz){
		initEntiryIdColumn(clz);
		return entityIdNameMap.get(clz.getName());
	}
	
	private static void initEntiryIdColumn(Class<?> clz){
		if(!entityIdNameMap.containsKey(clz.getName())){
			String cn = defaultIdColumn;
			String in = defaultIdName;
			for(Field field : clz.getDeclaredFields()){
				if(field.isAnnotationPresent(Id.class)){
					in = field.getName();
					if(field.isAnnotationPresent(Column.class)){
						Column col = field.getAnnotation(Column.class);
						cn = col.name();
					}
					break;
				}
			}
			entityIdNameMap.put(clz.getName(), in);
			entityIdMap.put(clz.getName(), cn);
		}
	}
	public <T> String insert(final T entity) {
		String sql = new SQL() {
			{
				Class<?> clz = entity.getClass();
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(entity, false);
				INSERT_INTO(SqlUtils.getTableName(clz));
				for (SqlFieldValueBean v : ls) {
					VALUES(v.getFields(), v.getMybatisField());
				}
			}
		}.toString();
		return sql;
	}

	public <T> String update(final T entity) {
		return new SQL() {
			{
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(entity, true);
				UPDATE(SqlUtils.getTableName(entity.getClass()));
				SET(SqlUtils.getUpdateSetCondition(ls));
				String id = getEntityId(entity.getClass());
				String idc = getEntityIdColumn(entity.getClass());
				WHERE(idc + " = #{"+id+"}");
			}
		}.toString();
	}

	public <T> String updateNotNullField(final T entity) {
		return new SQL() {
			{
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(entity, false);
				UPDATE(SqlUtils.getTableName(entity.getClass()));
				SET(SqlUtils.getUpdateSetCondition(ls));
				String id = getEntityId(entity.getClass());
				String idc = getEntityIdColumn(entity.getClass());
				WHERE(idc + " = #{"+id+"}");
			}
		}.toString();
	}

	public <T> String delete(final Class<T> clz,final String id) {
		return new SQL() {
			{
				DELETE_FROM(SqlUtils.getTableName(clz));
				String id = getEntityIdColumn(clz);
				WHERE(id + " = #{id}");
			}
		}.toString();
	}

	public <T> String deleteIn(final Map<String, Object> para) {
		return new SQL() {
			{
				DELETE_FROM(SqlUtils.getTableName((Class<?>) para.get("clz")));
				String id = getEntityIdColumn((Class<?>) para.get("clz"));
				WHERE(id + " in (" + para.get("ids") + ")");
			}
		}.toString();
	}

	public <T> String get(final Map<String, Object> para) {
		return new SQL() {
			{
				Class<?> clz = (Class<?>) para.get("clz");
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(clz, true);
				SELECT(SqlUtils.getSelectfields(ls));
				FROM(SqlUtils.getTableName(clz));
				String orderby = SqlUtils.getOrderBy(clz);
				if (orderby != null) {
					ORDER_BY(orderby);
				}
				String id = getEntityIdColumn(clz);
				WHERE(id + " = #{id}");
			}
		}.toString();
	}

	public <T> String findAll(final Class<T> clz) {
		return new SQL() {
			{
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(clz, true);
				SELECT(SqlUtils.getSelectfields(ls));
				FROM(SqlUtils.getTableName(clz));
				String orderby = SqlUtils.getOrderBy(clz);
				if (orderby != null) {
					ORDER_BY(orderby);
				}
			}
		}.toString();
	}

	public <T> String query(final Map<String, Object> params) {
		@SuppressWarnings("unchecked")
		final T queryObj = (T) params.get("queryObj");
		String sql = new SQL() {
			{
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(queryObj, true,"queryObj");
				SELECT(SqlUtils.getSelectfields(ls));
				FROM(SqlUtils.getTableName(queryObj.getClass()));
				String where = SqlUtils.getSelectCondition(ls, false);
				if (where != null) {
					WHERE(where);
				}
				String orderby = SqlUtils.getOrderBy(queryObj.getClass());
				if (orderby != null) {
					ORDER_BY(orderby);
				}

			}
		}.toString();
		return sql;
	}

	public <T> String queryObjectByPage(final Map<String, Object> params) {
		@SuppressWarnings("unchecked")
		final T queryObj = (T) params.get("queryObj");
		String sql = new SQL() {
			{
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(queryObj, true, "queryObj");
				SELECT(SqlUtils.getSelectfields(ls));
				FROM(SqlUtils.getTableName(queryObj.getClass()));
				String where = SqlUtils.getSelectCondition(ls, false);
				if (where != null) {
					WHERE(where);
				}
				String orderby = SqlUtils.getOrderBy(queryObj.getClass());
				if (orderby != null) {
					ORDER_BY(orderby);
				}
			}
		}.toString();
		return sql;

	}
	public <T> String queryObjectTotalRow(final Map<String, Object> params) {
		@SuppressWarnings("unchecked")
		final T queryObj = (T) params.get("queryObj");
		String sql = new SQL() {
			{
				List<SqlFieldValueBean> ls = SqlUtils.getFieldValues(queryObj, true, "queryObj");
				SELECT("count(1)");
				FROM(SqlUtils.getTableName(queryObj.getClass()));
				String where = SqlUtils.getSelectCondition(ls, false);
				if (where != null) {
					WHERE(where);
				}
				String orderby = SqlUtils.getOrderBy(queryObj.getClass());
				if (orderby != null) {
					ORDER_BY(orderby);
				}
			}
		}.toString();
		return sql;
		
	}
}
