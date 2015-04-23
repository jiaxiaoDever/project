package com.yuhui.core.utils;

public class Constants {

	public static final String SYSTEM_NAME = "昱辉基础平台";

	/** 默认的每页记录数 */
	public final static int DEFAULT_PAGESIZE = 10;

	/** 包括所有状态 */
	public final static Integer STATE_ALL = 0;

	/** 状态有效标识 */
	public final static Integer STATE_VALID = 1;

	/** 状态无效标识 */
	public final static Integer STATE_INVALID = -1;

	/** 日期模式 */
	public final static String DATE_PATTERN_DASH_YEAR_MONTH_DAY = "yyyy-MM-dd";

	/** 日期模式 */
	public final static String DATE_PATTERN_DASH_YEAR_MONTH_DAY_HOUR_MIN_SEC = "yyyy-MM-dd HH:mm:ss";
	/** 主数据库* */
	public final static String MASTER_SCHEMA = "pts";
	/** 从数据库* */
	public final static String SLAVE_SCHEMA = "data_man";

	/** 树拖拽动作 成为子节点 */
	public final static String TREE_DROP_ACTION_INNER = "inner";
	/** 树拖拽动作 成为前一个节点 */
	public final static String TREE_DROP_ACTION_PREV = "prev";
	/** 树拖拽动作 成为后一个节点 */
	public final static String TREE_DROP_ACTION_NEXT = "next";

	/** 缓存 所有菜单数据 */
	public static final Object CACHE_ALL_MENU_TREE = "allMenuTree";
	/** 缓存 所有菜单数据Map */
	public static final Object CACHE_ALL_MENU_MAP = "allMenuMap";
	/** 缓存 只有菜单，无按钮数据 */
	public final static String CACHE_MENU_TREE = "menuTree";
	/** 缓存 只有菜单，无按钮数据Map */
	public final static String CACHE_MENU_MAP = "menuTreeMap";
	/** 缓存 所有资源数据 */
	public final static String CACHE_RESOURCE_TREE = "resourceTree";
	/** 缓存 所有资源数据Map */
	public final static String CACHE_RESOURCE_MAP = "resourceTreeMap";
	/** 缓存 所有机构数据 */
	public final static String CACHE_ORG_TREE = "orgTree";
	/** 缓存 所有机构数据Map */
	public final static String CACHE_ORG_MAP = "orgTreeMap";
	/** 缓存所有角色对应的portlet数据map */
	public final static String CACHE_ROLE_PORTLET_MAP = "rolePortletMap";
	/** 缓存所有角色对应的portlet对象list */
	public final static String CACHE_ROLE_PORTLET = "rolePortlet";
	/** 缓存 所有资源数据 */
	public final static String CACHE_CONTENT_TYPE_TREE = "contentTypeTree";
	/** 缓存 所有资源数据Map */
	public final static String CACHE_CONTENT_TYPE_MAP = "contentTypeTreeMap";
	
	/**
	 * 缓存所有的报表目录树，只有目录
	 */
	public final static String CACHE_REPORT_TREE = "reportDirTree";
	
	/**
	 * 附件类型 内容表的附件
	 */
	public final static String ATTACH_TYPE_CONTENT = "tb_content";
	/**
	 * 附件类型 内容分类表的附件
	 */
	public final static String ATTACH_TYPE_CONTENT_TYPE = "tb_content_type";
}
