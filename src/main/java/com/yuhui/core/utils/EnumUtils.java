package com.yuhui.core.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yuhui.core.entity.common.SysEnum;
import com.yuhui.core.entity.common.TextIdBean;
import com.yuhui.core.entity.common.TextValueBean;
import com.yuhui.core.service.common.CommonService;

public class EnumUtils {
	private static EnumUtils _instance;
	/**
	 * Map<tableName$fieldName,List<Map<value,description>>>
	 */
	private Map<String, List<TextValueBean>> mapEnum;

	private EnumUtils() {
		init();
	}

	public static EnumUtils getInstance() {
		if (_instance == null) {
			_instance = new EnumUtils();
		}
		return _instance;
	}

	/**
	 * 根据tablename与fieldname,返回 List<TextIdBean>
	 * 
	 * @param languageCode
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static List<TextIdBean> getIDStatus(String tablename, String fieldname) {
		List<TextIdBean> list = new ArrayList<TextIdBean>();
		TextIdBean textIdBean = null;
		for (TextValueBean o : getStatus(tablename, fieldname)) {
			textIdBean = new TextIdBean();
			textIdBean.setName(o.getText());
			textIdBean.setId(Long.valueOf(o.getId()));
			list.add(textIdBean);
		}
		return list;
	}

	/**
	 * 根据tablename与fieldname,返回 List<TextValueBean>
	 * 
	 * @param languageCode
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public static List<TextValueBean> getStatus(String tablename, String fieldname) {
		Map<String, List<TextValueBean>> statusMap = getInstance().getMapEnum();
		String key = tablename.toUpperCase() + "$" + fieldname.toUpperCase();
		if (statusMap == null) {
			return null;
		}
		if (statusMap.get(key) == null) {
			return null;
		}

		List<TextValueBean> list = statusMap.get(key);
		return list;
	}

	public void init() {
		mapEnum = new HashMap<String, List<TextValueBean>>();
		CommonService commonService = SpringContextUtils.getBean("commonService");
		List<SysEnum> lsEnum = commonService.findAllEnum();
		List<TextValueBean> lsEnumGroup = null;
		String tableFieldKey = null;
		for (SysEnum e : lsEnum) {
			tableFieldKey = e.getTableName().toUpperCase() + "$" + e.getFieldName().toUpperCase();
			if (mapEnum.containsKey(tableFieldKey)) {
				lsEnumGroup = mapEnum.get(tableFieldKey);
			} else {
				lsEnumGroup = new ArrayList<TextValueBean>();
				mapEnum.put(tableFieldKey, lsEnumGroup);
			}
			lsEnumGroup.add(new TextValueBean(e.getDescription(), e.getValue()));
		}
	}

	public Map<String, List<TextValueBean>> getMapEnum() {
		return mapEnum;
	}

}
