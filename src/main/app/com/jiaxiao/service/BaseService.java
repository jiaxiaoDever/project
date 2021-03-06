package com.jiaxiao.service;


public interface BaseService {

	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 绑定微信用户到对应学员
	 * @param openId 微信ID
	 * @param studentName 学员姓名
	 * @param studentCardId 学员卡号
	 * @param studentPhone 学员手机号
	 * @return 绑定成功返回1，找不到学员返回2，更新数据库失败返回3
	 */
	public int bandToStudent(String openId,String studentName,String studentCardId,String studentPhone);
	
	/**
	 * @author 肖长江
	 * @date 2015-4-17
	 * @todo TODO 判断微信用户是否已经绑定到学员
	 * @param openId 
	 * @return 绑定了返回学员编号，否则返回null
	 */
	public String isUserBandedStudent(String openId);
	
	/**
	 * @author 肖长江
	 * @date 2015-5-11
	 * @todo TODO 判断微信用户是否已经绑定到教练
	 * @param openId 微信openId
	 * @return 绑定了返回教练编号，否则返回null
	 */
	public String isUserBandedTeacher(String openId);
	
	/**
	 * @author 肖长江
	 * @date 2015-5-20
	 * @todo TODO 解除微信用户的绑定
	 * @param openId 微信openId
	 * @return
	 */
	public int unbandUser(String openId);
}
