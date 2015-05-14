package com.jiaxiao.service.impl;


import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.base.Constants;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.entity.TbWxUser;
import com.jiaxiao.repository.TeacherJxDAO;
import com.jiaxiao.repository.WxUserDAO;
import com.jiaxiao.service.TeacherJxService;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;

@Service(value = "teacherJxService")
@Transactional(readOnly = true)
public class TeacherJxServiceImpl extends BaseServiceImpl<TbTeacherJx> implements
		TeacherJxService {

	@Autowired
	private TeacherJxDAO teacherJxDAO;
	@Autowired
	private WxUserDAO wxUserDAO;
	
	@Override
	public BaseRepository<TbTeacherJx> getMybatisDAO() {
		return teacherJxDAO;
	}
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int regTeacher(TbTeacherJx teacherJx, String openId)
			throws RuntimeException {
		int rs = teacherJxDAO.insert(teacherJx);
		if(rs > 0){
			TbWxUser user = wxUserDAO.getUserByOpenId(openId);
			if(user != null){
				user.setTeacherId(teacherJx.getTeacherId());
				user.setRoleCode(Constants.WXUSER_ROLE_TEA_CODE);
				user.setRoleName(Constants.WXUSER_ROLE_TEA);
				user.setIsBinded(1);
				rs = wxUserDAO.updateNotNullField(user);
			}else{
				user = new TbWxUser();
				user.setUserId(UUID.randomUUID().toString());
				user.setTeacherId(teacherJx.getTeacherId());
				user.setOpenId(openId);
				user.setRoleCode(Constants.WXUSER_ROLE_TEA_CODE);
				user.setRoleName(Constants.WXUSER_ROLE_TEA);
				user.setIsBinded(1);
				user.setContactDate(new Date());
				rs = wxUserDAO.insert(user);
			}
		}
		return rs;
	}


}
