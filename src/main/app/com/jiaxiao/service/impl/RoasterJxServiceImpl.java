package com.jiaxiao.service.impl;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.base.Constants;
import com.jiaxiao.entity.TbRoasterJx;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.repository.RoasterJxDAO;
import com.jiaxiao.service.RoasterJxService;
import com.jiaxiao.service.impl.system.ImportServiceImpl;
import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.repository.mybatis.BaseRepository;

@Service(value = "roasterJxService")
@Transactional(readOnly = true)
public class RoasterJxServiceImpl extends ImportServiceImpl<TbRoasterJx> implements
		RoasterJxService,ImportService<TbRoasterJx> {

	@Autowired
	private RoasterJxDAO roasterJxDAO;
	@Override
	public BaseRepository<TbRoasterJx> getMybatisDAO() {
		return roasterJxDAO;
	}
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int addTeacherDayRoast(TbTeacherJx teacherJx, Date day) {
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		int count = roasterJxDAO.countTeacherDayRoast(teacherJx.getTeacherId(), sdFormat.format(day));
		int rs = 0;
		if(count < 1){
			try {
				for(int j=0; j<Constants.COURSE_NUM_AM_DEF; j++){
					Date startDate = new Date(sdFormat.parse(sdFormat.format(day)).getTime() + (j+Constants.COURSE_START_H_AM_DEF)*60*60*1000);
					Date endDate = new Date(startDate.getTime() + 60*60*1000);
					TbRoasterJx tr = new TbRoasterJx(null, teacherJx.getBranchId(),
							teacherJx.getBranchName(), Constants.COURSE_CAN_SAIN_NUM_DEF, null, Constants.COURSE_HOUR_DEF, Constants.NUM_PER_COURSE_DEF, null, teacherJx.getJxName()+"-"+teacherJx.getBranchName()+"-"+teacherJx.getTeacherName()+"教练"+"-"+teacherJx.getSubjectName(),
							Constants.COURSE_NOTIC_B_HOUR_DEF, Constants.ROAST_STAT_BMZ, Constants.ROAST_STAT_CODE_BMZ, Constants.SW, Constants.SW_CODE, new Date(), new Date(), startDate, endDate, Constants.STAT_DEF, Constants.STAT_DEF, teacherJx.getJxId(), teacherJx.getJxName(), Constants.COURSE_OFFLINE_NUM_DEF, Constants.ROAST_NOTIC_A_HOUR_DEF,
							startDate, startDate, teacherJx.getSubjectId(), teacherJx.getSubjectName(), teacherJx.getTeacherId(), teacherJx.getTeacherName());
					rs += save(tr);
				}
				for(int j=0; j<Constants.COURSE_NUM_PM_DEF; j++){
					Date startDate = new Date(sdFormat.parse(sdFormat.format(day)).getTime() + (j+Constants.COURSE_START_H_PM_DEF)*60*60*1000);
					Date endDate = new Date(startDate.getTime() + 60*60*1000);
					TbRoasterJx tr = new TbRoasterJx(null, teacherJx.getBranchId(),
							teacherJx.getBranchName(), Constants.COURSE_CAN_SAIN_NUM_DEF, null, Constants.COURSE_HOUR_DEF, Constants.NUM_PER_COURSE_DEF, null, teacherJx.getJxName()+"-"+teacherJx.getBranchName()+"-"+teacherJx.getTeacherName()+"教练"+"-"+teacherJx.getSubjectName(),
							Constants.COURSE_NOTIC_B_HOUR_DEF, Constants.ROAST_STAT_BMZ, Constants.ROAST_STAT_CODE_BMZ, Constants.XW, Constants.XW_CODE, new Date(), new Date(), startDate, endDate, Constants.STAT_DEF, Constants.STAT_DEF, teacherJx.getJxId(), teacherJx.getJxName(), Constants.COURSE_OFFLINE_NUM_DEF, Constants.ROAST_NOTIC_A_HOUR_DEF,
							startDate, startDate, teacherJx.getSubjectId(), teacherJx.getSubjectName(), teacherJx.getTeacherId(), teacherJx.getTeacherName());
					rs += save(tr);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return rs;
	}

}
