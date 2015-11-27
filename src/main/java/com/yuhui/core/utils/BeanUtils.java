package com.yuhui.core.utils;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.persistence.Column;


/**
 * <title>对bean对象的操作的封装</title>
 */
public class BeanUtils {

	public static final String getStart = "get";
	public static final String setStart = "set";
	public BeanUtils() 
	{
	}

	/**
	 * <p>在某个类中加载系统文件</p>
	 * @param clazz 指定类
	 * @param filePath 指定系统文件路径
	 * @return
	 *        
	 */
	@SuppressWarnings("rawtypes")
	public static Properties getProperties(Class clazz , String filePath)
	{
		InputStream inputStream = clazz.getResourceAsStream(filePath);
		Properties properties = new Properties();
		try {
			properties.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties;
	}
	
	/**
	 * <p>将结果集转换为Map</p>
	 * @param resultSet
	 * @return
	 * @throws SQLException
	 *        
	 * @author xiao jiang   @date Aug 3, 2010
	 */
	public static List<Map<String, Object>> resultSetToList(ResultSet resultSet) throws SQLException
	{
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		ResultSetMetaData metaData;
		int count;
		try {
			metaData = resultSet.getMetaData();
		    count = metaData.getColumnCount();
		while(resultSet.next())
		{
			Map<String, Object> map = new HashMap<String, Object>();
			for(int i =0 ; i < count ; i++)
			{
				String key = metaData.getColumnLabel(++i).toLowerCase();
				Object value = resultSet.getObject(key);
				map.put(key, value);
			}
			list.add(map);
		}
		} catch (SQLException e) {
			throw new SQLException("resultSetToList() ===> 结果集转换为List<Map>失败！" + e.getMessage());
		}
		return list;
	}
	
	/**
	 * 通过反射给某个对象的某个属性赋值
	 * @param object 指定对象
	 * @param fieldName 指定属性名称
	 * @param value 所需赋的值
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void executeSetMethod(Object object , String fieldName , Object value) throws Exception
	{
		try {
		//String name = "set" + fieldName.substring(0,1).toUpperCase() + fieldName.substring(1);
		org.apache.commons.beanutils.BeanUtils.setProperty(object, fieldName, value);
		/*Class clazz = object.getClass();
		Field field;
		field = clazz.getField(fieldName);
		Type type = field.getType();
		Method method = clazz.getDeclaredMethod(name, new Class[]{type.getClass()});
		Object obj = toOtherType(type.getClass(), value);
		method.invoke(object, new Object[]{obj});*/
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("executeSetMethod() ===> 反射执行出错！fieldName:"+fieldName + "   " + e.getMessage());
		}
	}
	
	/**
	 * <p>将Map对象转换为bean对象</p>
	 * @param object
	 * @param map
	 * @return
	 *        
	 */
	@SuppressWarnings("rawtypes")
	public static Object mapToBean(Class clazz , Map<String, Object> map)
	{
		Object object =  null;
		try {
			/*Set<String> keySet = map.keySet();
			for (String string : keySet) {
				String value = map.get(string).toString();
				executeSetMethod(object, string, value);
			}*/
			//org.apache.commons.beanutils.BeanUtils.populate(object, map);
			if(map == null || map.size() < 1) return null;
			Map<String, Object> oMap = new HashMap<String, Object>();
			object = clazz.newInstance();
			for(Method method : clazz.getDeclaredMethods()){
				String cn = "";
				String fieldName = "";
				if(method.isAnnotationPresent(Column.class)){
					Column col = method.getAnnotation(Column.class);
					cn = col.name();
					String methodName = method.getName();
					fieldName = getFieldByMethod(methodName);
				}
				if(!"".equals(cn) && map.containsKey(cn)){
					oMap.put(fieldName, map.get(cn));
					//executeSetMethod(object, fieldName, map.get(cn));
				}
			}
			for(Field field : clazz.getDeclaredFields()){
				String fieldName = field.getName();
				String cn = fieldName;
				if(field.isAnnotationPresent(Column.class)){
					Column col = field.getAnnotation(Column.class);
					cn = col.name();
				}
				if(map.containsKey(cn)){
					oMap.put(fieldName, map.get(cn));
					//executeSetMethod(object, fieldName, map.get(cn));
				}
			}
			org.apache.commons.beanutils.BeanUtils.populate(object, oMap);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return object;
	}
	/**
	 * 将一个字符串转换为指定的类型
	 * @param clazz 指定类型
	 * @param value 字符串值
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static Object toOtherType(Class clazz,Object value)
	{
		Object object = null;
		String string = "to" + clazz.getSimpleName();
		try {
			Method method = Type.class.getDeclaredMethod(string, String.class);
		    object = method.invoke(Type.class.newInstance(), value);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return object;
	}

	/**
	 * <p>判断某个对象中是否有某个属性</p>
	 * @param object
	 * @param field
	 * @return
	 *        
	 */
	@SuppressWarnings("rawtypes")
	public static Boolean ishasProperty(Object object ,String field)
	{
		Class clazz = object.getClass();
		try {
			@SuppressWarnings("unused")
			Field f = clazz.getDeclaredField(field);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * <p>将结果集转换为bean对象</p>
	 * @param resultSet
	 * @param clazz
	 * @return
	 * @throws Exception
	 *        
	 */
	@SuppressWarnings("rawtypes")
	public static List<Object> resultSetToObjects(ResultSet resultSet , Class clazz) throws Exception
	{
		List<Map<String, Object>> maps = resultSetToList(resultSet);
		List<Object> objs = new ArrayList<Object>();
		for(Map<String, Object> map:maps)
		{
			Object object  = mapToBean(clazz, map);
			objs.add(object);
		}
		return objs;
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-6-12
	 * @todo TODO 通过属性的get或set方法获取属性名称
	 * @param methodName get或set方法
	 * @return
	 */
	public static String getFieldByMethod(String methodName){
		String name = null;
		if(methodName != null && !"".equals(methodName)){
			if(methodName.startsWith(getStart)){
				name = methodName.replace(getStart, "");
			}
			if(methodName.startsWith(setStart)){
				name = methodName.replace(setStart, "");
			}
			name = name.substring(0,1).toLowerCase() + name.substring(1);
		}
		return name;
	}
	
	/**
	 * <p>将多个对象的属性的值赋给某个对象的相同属性</p>
	 * @param objs
	 * @param voClass
	 * @return
	 *        
	 */
	@SuppressWarnings("rawtypes")
	public static List<Object> copyProperties(List<Object[]> objs , Class voClass)
	{
		List<Object> list = new ArrayList<Object>();
		try {
			for (Object[] objects : objs) {
				Object object = voClass.newInstance();
				for (Object obj : objects) {
					if(obj == null)
					{
						continue;
					}
					org.apache.commons.beanutils.BeanUtils.copyProperties(object, obj);
				}
				list.add(object);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/****************************************
	 	************  校验  ***************
	 ****************************************/
	/**
	 * <p>数组中是否有重复值</p>
	 * @param obj
	 * @return
	 *        
	 * @author xiao jiang   @date Aug 3, 2010
	 */
	public static boolean isRepeat(Object obj[]) { 
		boolean ret = false; 
		for(int i = 0; i < obj.length - 1; i++) { 
			Object tmp = obj[i]; 
			for(int j = i + 1; 
			j < obj.length; j++) { 
				if(tmp.equals(obj[j])) { 
					//有重复 
					return true; 
					} 
				} 
			} 
		return ret; 
		}


}

