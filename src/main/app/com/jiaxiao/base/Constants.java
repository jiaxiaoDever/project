package com.jiaxiao.base;

public class Constants {

	public static final int SALT_SIZE = 8;
	public static final int HASH_INTERATIONS = 1024;
	/** 初始化N天内的课程*/
	public static int INIT_ROAST_DAY = 7;
	/** 默认上午课时数*/
	public static final int COURSE_NUM_AM_DEF = 4;
	/** 默认下午课时数*/
	public static final int COURSE_NUM_PM_DEF = 4;
	/** 默认上午开始上课时间*/
	public static final int COURSE_START_H_AM_DEF = 8;
	/** 默认下午开始上课时间*/
	public static final int COURSE_START_H_PM_DEF = 14;
	/** 默认线下预约人数为0*/
	public static final int COURSE_OFFLINE_NUM_DEF = 0;
	/** 默认课时数*/
	public static final int COURSE_HOUR_DEF = 1;
	/** 每节课能接收人数*/
	public static final int NUM_PER_COURSE_DEF = 3;
	/** 默认剩余可报名人数=每节课能接收人数*/
	public static final int COURSE_CAN_SAIN_NUM_DEF = NUM_PER_COURSE_DEF;
	/** 最近课程默认提前4小时通知教练*/
	public static final int COURSE_NOTIC_B_HOUR_DEF = 4;
	/** 排班后默认延后24小时通知教练*/
	public static final int ROAST_NOTIC_A_HOUR_DEF = 24;
	/** 教练默认课程状态编码：PBZ*/
	public static final String ROAST_STAT_CODE_DEF = "PBZ";
	/** 教练默认课程状态：排班中*/
	public static final String ROAST_STAT_DEF = "排班中";
	/** 上午编码*/
	public static final String SW_CODE = "SW";
	/** 下午编码*/
	public static final String XW_CODE = "XW";
	/** 上午*/
	public static final String SW = "上午";
	/** 下午*/
	public static final String XW = "下午";
	
	/** 顺序*/
	public static final String ORDER_ASC="asc";
	/** 倒序*/
	public static final String ORDER_DESC="desc";
	/** 科目二编号*/
	public static final String subject2Id = "de9581d9-d016-470b-9126-ae297b673e57";
	/** 科目三编号*/
	public static final String subject3Id = "351742ee-ebcc-40cc-b5fc-fb3a39131e14";
	
	/** 默认驾校编号*/
	public static final String defaultJx = "9f4d700e-54c4-4843-8ff0-3fcff6661682";
	
	/** 教练审核通过状态编码*/
	public static final String TEACHE_CHECK_OK_CODE = "SHTG";
	/** 教练审核通过状态*/
	public static final String TEACHE_CHECK_OK = "审核通过";
	/** 教练审核默认状态编码*/
	public static final String TEACHE_CHECK_DEF_CODE = "DSH";
	/** 教练审核默认状态*/
	public static final String TEACHE_CHECK_DEF = "待审核";
	/** 教练在职默认状态编码*/
	public static final String TEACHE_DUTESTAT_DEF_CODE = "ZB";
	/** 教练在职默认状态*/
	public static final String TEACHE_DUTESTAT_DEF = "值班";
	
	/** 一般情况下默认状态值(是)*/
	public static final Integer STAT_DEF = 1;
	
	/** 微信用户教练角色编码*/
	public static final String WXUSER_ROLE_TEA_CODE = "JXJL";
	/** 微信用户教练角色*/
	public static final String WXUSER_ROLE_TEA = "驾校教练";
	
	/** 字典数据集合缓存*/
	public static final String CACHE_SYS_DATA = "sys_data";
	/** 字典数据MAP缓存*/
	public static final String CACHE_SYS_DATA_MAP = "sys_data_map";
	
	/** 字典根编号*/
	public static final String SYS_DATA_ROOT = "100000";
	/** 用户角色*/
	public static final String ROLE_DATA_ID = "101000";
	/** 公众号类型*/
	public static final String PUBLIC_TYPE_DATA_ID = "103000";
	/** 公众号状态*/
	public static final String PUBLIC_STAT_DATA_ID = "104000";
	/** 消息模板类型*/
	public static final String TM_TYPE_DATA_ID = "105000";
	/** 公众号消息发送状态*/
	public static final String SEND_STAT_DATA_ID = "106000";
	/** 学员状态*/
	public static final String STUDENT_STAT_DATA_ID = "107000";
	/** 驾照类型*/
	public static final String LICENSE_TYPE_DATA_ID = "108000";
	/** 记录操作类型*/
	public static final String OPT_TYPE_DATA_ID = "109000";
	/** 记录操作所属功能*/
	public static final String OPT_MODUL_DATA_ID = "110000";
	/** 驾校状态*/
	public static final String JX_STAT_DATA_ID = "111000";
	/** 网点状态*/
	public static final String BRANCH_STAT_DATA_ID = "112000";
	/** 教练职称*/
	public static final String DUTE_LEVEL_DATA_ID = "113000";
	/** 教练在职状态*/
	public static final String DUTE_STAT_DATA_ID = "114000";
	/** 教练课程状态*/
	public static final String COURSE_STAT_DATA_ID = "115000";
	/** 课程所属时间段*/
	public static final String COURSE_TIMEAREA_DATA_ID = "116000";
	/** 学员履约状态*/
	public static final String IMPL_COURSE_STAT = "117000";
	/** 学员课程状态*/
	public static final String ST_COURSE_STAT_DATA_ID = "118000";
	/** 准教车型*/
	public static final String TEA_CAR_TYPE_DATA_ID = "119000";
	/** 训练车型*/
	public static final String CAR_TYPE_DATA_ID = "120000";
}
