package com.jiaxiao.repository;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbStudentJx;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("studentJxDAO")
@MyBatisRepository()
public interface StudentJxDAO extends BaseRepository<TbStudentJx> {
	
	/**
	 * @author 肖长江
	 * @date 2015-4-17
	 * @todo TODO 根据学员姓名、学员卡号、学员手机号查找某个学员
	 * @param studentName 学员姓名
	 * @param studentCardId 学员卡号
	 * @param studentPhone 学员手机号
	 * @return 返回符合条件的学员信息
	 */
	public TbStudentJx getStudentJx(@Param(value="studentName")String studentName,@Param(value="studentCardId")String studentCardId,@Param(value="studentPhone")String studentPhone);
	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 根据微信openId获取绑定的学员对象
	 * @param openId 微信openId
	 * @return
	 */
	public TbStudentJx getBandedStudentJx(String openId);
}
