package com.yuhui.core.utils;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.beanutils.PropertyUtils;

import com.yuhui.core.entity.common.SqlFieldValueBean;
import com.yuhui.core.repository.mybatis.OrderBy;
import com.yuhui.core.utils.page.Dialect;
import com.yuhui.core.utils.page.Dialect.Type;

public class SqlUtils {

	/**
	 * 获取字段和值的List
	 * 
	 * @param obj
	 * @param isContainNullValue
	 * @return
	 */
	public static <T> List<SqlFieldValueBean> getFieldValues(T obj, boolean isContainNullValue) {

		Class<?> clz = obj.getClass();
		List<SqlFieldValueBean> lsResult = new ArrayList<SqlFieldValueBean>();
		setClassFieldValue(obj, getTableName(clz), clz, lsResult, isContainNullValue, null);
		return lsResult;
	}

	/**
	 * 获取字段和值的List
	 * 
	 * @param obj
	 * @param isContainNullValue
	 * @return
	 */
	public static <T> List<SqlFieldValueBean> getFieldValues(T obj, boolean isContainNullValue, String tag) {

		Class<?> clz = obj.getClass();
		List<SqlFieldValueBean> lsResult = new ArrayList<SqlFieldValueBean>();
		setClassFieldValue(obj, getTableName(clz), clz, lsResult, isContainNullValue, tag);
		return lsResult;
	}

	/**
	 * 获取字段和值的List
	 * 
	 * @param clz
	 * @param isContainNullValue
	 * @return
	 */
	public static <T> List<SqlFieldValueBean> getFieldValues(Class<?> clz, boolean isContainNullValue) {

		List<SqlFieldValueBean> lsResult = new ArrayList<SqlFieldValueBean>();
		setClassFieldValue(null, getTableName(clz), clz, lsResult, isContainNullValue, null);
		return lsResult;
	}

	/**
	 * 获取所有字段和mybatis参数，递归获取
	 * 
	 * @param obj
	 * @param clz
	 * @param lsResult
	 * @param isContainNullValue
	 */
	private static <T> void setClassFieldValue(T obj, String tableName, Class<?> clz, List<SqlFieldValueBean> lsResult, boolean isContainNullValue, String tag) {
		if (clz.getSuperclass() != Object.class) {
			setClassFieldValue(obj, tableName, clz.getSuperclass(), lsResult, isContainNullValue, tag);
		}
		try {
			Field[] fields = clz.getDeclaredFields();
			for (int i = 0; i < fields.length; i++) {
				if (fields[i].isAnnotationPresent(Transient.class)) {// 注解了忽略的,跳过
					continue;
				}
				String fieldName = fields[i].getName();
				if ("serialVersionUID".equals(fieldName)) {
					continue;
				}
				Object value = null;
				if (obj != null) {
					value = PropertyUtils.getProperty(obj, fieldName);
				}
				if (!isContainNullValue && value == null) {
					continue;
				}
				if (fields[i].isAnnotationPresent(Column.class)) {// 注解了Column,使用Column的值
					fieldName = fields[i].getAnnotation(Column.class).name();
				} else {
					fieldName = StringUtils.unCamelCase(fieldName);
				}
				if (ColumnUtils.getColumn(tableName, fieldName) == null) {
					continue;
				}
				String jdbcType = ColumnUtils.getColumn(tableName, fieldName).getDataType();
				String myBatisParm = String.format("#{%s%s,jdbcType=%s}", tag == null ? "" : (tag + "."), fields[i].getName(), jdbcType);
				lsResult.add(new SqlFieldValueBean(fieldName, value, myBatisParm));
			}
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 获取更新的内容
	 * 
	 * @param ls
	 * @return
	 */
	public static String getUpdateSetCondition(List<SqlFieldValueBean> ls) {
		StringBuilder sb = new StringBuilder();
		int i = 0;
		for (SqlFieldValueBean v : ls) {
			if (i++ != 0)
				sb.append(',');
			String columnName = v.getFields();
			if (v.getValue() == null) {
				sb.append(columnName).append("=null");
			} else {
				sb.append(columnName).append("=" + v.getMybatisField());
			}

		}
		return sb.toString();
	}

	/**
	 * 获取查询条件sql部分
	 * 
	 * @param ls
	 * @param hasNull
	 * @return
	 */
	public static String getSelectCondition(List<SqlFieldValueBean> ls, boolean hasNull) {
		StringBuilder sb = new StringBuilder();
		int i = 0;
		String dialect = SqlUtils.getDialect();
		Type DIALECT = Dialect.Type.valueOf(dialect.toUpperCase());
		for (SqlFieldValueBean v : ls) {
			if (!hasNull && v.getValue() == null || "".equals(v.getValue())) {
				continue;
			}
			if (i++ != 0)
				sb.append(" and ");
			String columnName = v.getFields();
			if (v.getValue() == null) {
				sb.append(columnName).append(" is null");
			} else {
				String opt = "=" + v.getMybatisField();
				sb.append(columnName);
				if ("id".equalsIgnoreCase(columnName)) {
					opt = " = " + v.getMybatisField();
				} else if (v.getValue().getClass() == String.class) {

					switch (DIALECT) {
					case ORACLE:
						opt = " like '%'||" + v.getMybatisField() + "||'%'  ";
						break;
					case MYSQL:
						opt = " like CONCAT('%',CONCAT(" + v.getMybatisField() + ",'%'))  ";
						break;
					case POSTGRESQL:
						break;
					case DB2:
						break;

					}
				}
				sb.append(opt);
			}

		}
		return sb.length() == 0 ? null : sb.toString();
	}

	/**
	 * 获取查询的字段
	 * 
	 * @param ls
	 * @return
	 */
	public static String getSelectfields(List<SqlFieldValueBean> ls) {
		StringBuilder sb = new StringBuilder();
		int i = 0;
		for (SqlFieldValueBean v : ls) {
			if (i++ != 0)
				sb.append(" , ");
			sb.append(v.getFields());
		}
		return sb.length() == 0 ? "*" : sb.toString();
	}

	/**
	 * 获取类映射的表名
	 * 
	 * @param obj
	 * @return
	 */
	public static <T> String getTableName(T obj) {
		return getTableName(obj.getClass());
	}

	/**
	 * 获取类映射的表名,同时给表名加上模式名称
	 * 
	 * @author xiexiaozhi
	 * @since 2013-10-24
	 * @param clz
	 * @return
	 */
	public static String getTableName(Class<?> clz) {
		Table table = clz.getAnnotation(Table.class);
		String schema = getSchema();
		String tableName = "";
		if (table != null) {
			tableName = table.name();
			if (isExitsSchema(tableName))
				return tableName;
			else
				return schema + "." + tableName;
		} else
			throw new RuntimeException("undefine POJO @Table, need Tablename(@Table(name))");
	}

	/**
	 * 获取类映射的表名
	 * 
	 * @param clz
	 * @return
	 */
	public static String getOrderBy(Class<?> clz) {
		OrderBy orderBy = clz.getAnnotation(OrderBy.class);
		if (orderBy != null)
			return orderBy.value();
		return null;
	}

	/**
	 * 获取注解ID的字段名
	 * 
	 * @param obj
	 * @return
	 */
	public static <T> String getIdFieldName(T obj) {
		return getIdFieldName(obj.getClass());
	}

	/**
	 * 获取注解ID的字段名
	 * 
	 * @param clz
	 * @return
	 */
	public static String getIdFieldName(Class<?> clz) {
		for (Field field : clz.getDeclaredFields()) {
			if (field.isAnnotationPresent(Id.class))
				return field.getName();
		}
		if (clz.getSuperclass() != null) {
			return getIdFieldName(clz.getSuperclass());
		} else {
			throw new RuntimeException("undefine POJO @Id");
		}
	}

	/**
	 * 判断ID字段值是否为空
	 * 
	 * @param obj
	 * @return
	 */
	public static <T> boolean isNullId(T obj) {
		try {
			Object result = PropertyUtils.getProperty(obj, getIdFieldName(obj));
			if (result == null || "".equals(result)) {
				return true;
			}
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 获取数据库前缀
	 * 
	 * @return
	 */
	public static String getSchema() {

		SystemInfo si = (SystemInfo) SpringContextUtils.getBean("sysinfo");
		return si.getSchema();
	}

	/**
	 * 获取数据库类型
	 * 
	 * @return
	 */
	public static String getDialect() {

		SystemInfo si = (SystemInfo) SpringContextUtils.getBean("sysinfo");
		return si.getDialect();
	}

	/**
	 * 是否存在数据库前缀
	 * 
	 * @param s
	 * @return
	 */
	public static boolean isExitsSchema(String s) {
		Pattern pattern = Pattern.compile("(.+)\\.(.+)");
		Matcher matcher = pattern.matcher(s);
		if (matcher.find()) {
			return true;
		}
		return false;
	}

	/**
	 * 按数据库类型获取字段大小写
	 * 
	 * @param key
	 * @return
	 */
	public static String getResultKey(String key) {
		String dialect = getDialect();
		if (dialect.equalsIgnoreCase("oracle") || dialect.equalsIgnoreCase("db2")) {
			key = key.toUpperCase();
			return key;
		} else if (dialect.equalsIgnoreCase("mysql") || dialect.equalsIgnoreCase("h2")) {
			key = key.toLowerCase();
			return key;
		}
		return key;
	}

	/**
	 * 格式化查询对象
	 * 
	 * @param obj
	 */
	public static <T> void formatQueryObject(T obj) {
		formatQueryObject(obj, obj.getClass());
	}

	/**
	 * 格式化查询对象
	 * 
	 * @param obj
	 * @param clz
	 */
	private static <T> void formatQueryObject(T obj, Class<?> clz) {
		if (clz.getSuperclass() != Object.class) {
			formatQueryObject(obj, clz.getSuperclass());
		}
		try {
			Field[] fields = clz.getDeclaredFields();
			for (int i = 0; i < fields.length; i++) {
				if (fields[i].isAnnotationPresent(Transient.class)) {// 注解了忽略的,跳过
					continue;
				}
				String fieldName = fields[i].getName();
				if ("serialVersionUID".equals(fieldName)) {
					continue;
				}
				Object value = null;
				if (obj != null) {
					value = PropertyUtils.getProperty(obj, fieldName);
				}
				if (value == null || "".equals(value)) {
					continue;
				}
				if (value.getClass().equals(String.class)) {
					PropertyUtils.setProperty(obj, fieldName, "%" + value + "%");
				}

			}
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
