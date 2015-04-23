package com.jiaxiao.repository;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbWxUser;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("wxUserDAO")
@MyBatisRepository()
public interface WxUserDAO extends BaseRepository<TbWxUser> {

	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 根据微信openId获取微信用户对象
	 * @param openId 微信openId
	 * @return 返回微信用户对象
	 */
	public TbWxUser getUserByOpenId(String openId);
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 修改微信用户对象对应学员信息
	 * @param openId 微信openId
	 * @param studentId 学员编号
	 * @return
	 */
	public int updateWxUserStudentInfo(@Param(value="openId") String openId,@Param(value="studentId") String studentId); 
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 插入绑定学员的微信用户信息
	 * @param user 正在绑定的学员的微信用户对象
	 * @return
	 */
	public int insertBandingUser(TbWxUser user);
}
