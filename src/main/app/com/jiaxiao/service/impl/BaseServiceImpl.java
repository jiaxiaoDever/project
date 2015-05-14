package com.jiaxiao.service.impl;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbStudentJx;
import com.jiaxiao.entity.TbWxUser;
import com.jiaxiao.repository.StudentJxDAO;
import com.jiaxiao.repository.WxUserDAO;
import com.jiaxiao.service.BaseService;

@Service(value = "baseService")
@Transactional(readOnly = true)
public class BaseServiceImpl implements BaseService {

	@Autowired
	private StudentJxDAO studentJxDAO;
	
	@Autowired
	private WxUserDAO wxUserDAO;
	
	
	
	@Override
	public String isUserBandedTeacher(String openId) {
		TbWxUser user = wxUserDAO.getUserByOpenId(openId);
		if(user != null && user.getIsBinded() != null && user.getIsBinded() == 1 && user.getTeacherId() != null) return user.getTeacherId();
		return null;
	}

	@Override
	public String isUserBandedStudent(String openId) {
		TbWxUser user = wxUserDAO.getUserByOpenId(openId);
		if(user != null && user.getIsBinded() != null && user.getIsBinded() == 1 && user.getStudentId() != null) return user.getStudentId();
		return null;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int bandToStudent(String openId, String studentName,
			String studentCardId, String studentPhone) {
		//1.判断是否有该学员
		TbStudentJx studentJx = studentJxDAO.getStudentJx(studentName, studentCardId, studentPhone);
		if(studentJx == null) return 2;
		//2.绑定学员到微信用户,如果已经有微信用户则修改，否则插入
		TbWxUser user = wxUserDAO.getUserByOpenId(openId);
		int u = 0;
		if(user != null){
			u = wxUserDAO.updateWxUserStudentInfo(openId, studentJx.getStudentId());
		}else{
			user = new TbWxUser();
			user.setUserId(UUID.randomUUID().toString());
			user.setStudentId(studentJx.getStudentId());
			user.setOpenId(openId);
			u = wxUserDAO.insertBandingUser(user);
		}
		if(u < 1) return 3;
		return 1;
	}

	public BaseServiceImpl() {
		super();
	}

}
