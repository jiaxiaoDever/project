package com.jiaxiao.service.impl;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.base.Constants;
import com.jiaxiao.entity.RoasterCourses;
import com.jiaxiao.entity.TbRoasterJx;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.entity.TbWxUser;
import com.jiaxiao.repository.RoasterJxDAO;
import com.jiaxiao.repository.TeacherJxDAO;
import com.jiaxiao.repository.WxUserDAO;
import com.jiaxiao.ro.Roaster;
import com.jiaxiao.ro.RoasterDay;
import com.jiaxiao.ro.TeacherRoasters;
import com.jiaxiao.service.TeacherJxService;
import com.jiaxiao.service.impl.system.ImportServiceImpl;
import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.repository.mybatis.BaseRepository;

@Service(value = "teacherJxService")
@Transactional(readOnly = true)
public class TeacherJxServiceImpl extends ImportServiceImpl<TbTeacherJx> implements
		TeacherJxService,ImportService<TbTeacherJx> {

	@Autowired
	private TeacherJxDAO teacherJxDAO;
	@Autowired
	private WxUserDAO wxUserDAO;
	
	@Autowired
	private RoasterJxDAO roasterJxDAO;
	
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

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int bandToTeacher(String openId, String teacherName,
			String password, String teacherPhone) {
		//1.判断是否有该教练
		TbTeacherJx tbTeacherJx = new TbTeacherJx();
		tbTeacherJx.setTeacherName(teacherName);
		tbTeacherJx.setPassword(password);
		tbTeacherJx.setTeaPhone(teacherPhone);
		List<TbTeacherJx> tbTeacherJxs = teacherJxDAO.query(tbTeacherJx);
		if(tbTeacherJxs == null || tbTeacherJxs.size() < 1) return 2;
		//2.绑定教练到微信用户,如果已经有微信用户则修改，否则插入
		TbWxUser user = wxUserDAO.getUserByOpenId(openId);
		int u = 0;
		//将教练已经绑定的微信号解除绑定
		wxUserDAO.unbandTeacherUser(tbTeacherJxs.get(0).getTeacherId());
		if(user != null){
			user.setTeacherId(tbTeacherJxs.get(0).getTeacherId());
			user.setRoleCode(Constants.WXUSER_ROLE_TEA_CODE);
			user.setRoleName(Constants.WXUSER_ROLE_TEA);
			user.setIsBinded(1);
			u = wxUserDAO.updateNotNullField(user);
		}else{
			user = new TbWxUser();
			user.setUserId(UUID.randomUUID().toString());
			user.setTeacherId(tbTeacherJxs.get(0).getTeacherId());
			user.setOpenId(openId);
			user.setRoleCode(Constants.WXUSER_ROLE_TEA_CODE);
			user.setRoleName(Constants.WXUSER_ROLE_TEA);
			user.setIsBinded(1);
			user.setContactDate(new Date());
			u = wxUserDAO.insert(user);
		}
		if(u < 1) return 3;
		return 1;
	}
	
	@Override
	public TeacherRoasters getTeacherRoastBefore(String teacherId,String endDate) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = sdf.format(new Date());
		try {
			if(endDate != null && !"".equals(endDate)) nowDate = sdf.format(sdf.parse(endDate));
		} catch (Exception e) {
		}
		List<RoasterCourses> tcs = roasterJxDAO.getTeacherRoastCoures(teacherId, nowDate, 3, 0,Constants.ORDER_DESC);
		Date startDay = new Date(sdf.parse(nowDate).getTime() - 3*24*60*60*1000);
		Date endDay = sdf.parse(nowDate);
		return conventRoasters(tcs, startDay, endDay,Constants.ORDER_DESC);
	}
	@Override
	public TeacherRoasters getTeacherRoastAfter(String teacherId) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate = sdf.format(new Date());
		List<RoasterCourses> tcs = roasterJxDAO.getTeacherRoastCoures(teacherId, nowDate, 0, 4,Constants.ORDER_ASC);
		Date startDay = sdf.parse(nowDate);
		Date endDay = new Date(sdf.parse(nowDate).getTime() + 4*24*60*60*1000);
		return conventRoasters(tcs, startDay, endDay,Constants.ORDER_ASC);
	}
	
	private TeacherRoasters conventRoasters(List<RoasterCourses> tcs,Date startDay,Date endDay,String order) throws ParseException{
		String teacherId = null,teacherName=null,jxId=null,jxName=null,branchId=null,branchName=null;
		int totolCoures=0,noCoures=0,duteCoures=0;
		int i=0;
		Map<String, RoasterDay> cds = new TreeMap<String, RoasterDay>();
		for(RoasterCourses rc : tcs){
			TbRoasterJx trc = rc.getTbRoasterJx();
			if(i == 0){
				teacherId = trc.getTeacherId();
				teacherName = trc.getTeacherName();
				jxId = trc.getJxId();
				jxName = trc.getJxName();
				branchId = trc.getBranchId();
				branchName = trc.getBranchName();
			}

			SimpleDateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd");
			String date = dFormat.format(trc.getStartTime());
			if(!cds.containsKey(date)){
				cds.put(date, new RoasterDay(date, trc.getSubjectId(), trc.getSubjectName(), trc.getTeacherId(), trc.getTeacherName(), 
						"0", "0", "0", "0", "0", "0", new ArrayList<Roaster>(), new ArrayList<Roaster>()));
			}
			Roaster roaster = new Roaster(trc.getCourseId(), trc.getCanSignNum(), trc.getCourseInNum(), trc.getCourseTimearea(), trc.getCourseTimeareaCode(), trc.getStartTime(), trc.getEndTime(), rc.getTbCourseSts());
			cds.get(date).setCanBookNum((Integer.valueOf(cds.get(date).getCanBookNum()) + trc.getCanSignNum())+"");
			cds.get(date).setTotalNum((Integer.valueOf(cds.get(date).getTotalNum()) + trc.getCourseInNum())+"");
			if("上午".equals(trc.getCourseTimearea())){
				cds.get(date).setCanBookNumOfMorn((Integer.valueOf(cds.get(date).getCanBookNumOfMorn()) + trc.getCanSignNum()) + "");
				cds.get(date).setTotalNumOfMorn((Integer.valueOf(cds.get(date).getTotalNumOfMorn()) + trc.getCourseInNum()) + "");
				
				cds.get(date).getCoursesOfMorn().add(roaster);
			}
			if("下午".equals(trc.getCourseTimearea())){
				cds.get(date).setCanBookNumOfAftern((Integer.valueOf(cds.get(date).getCanBookNumOfAftern()) + trc.getCanSignNum()) + "");
				cds.get(date).setTotalNumOfAftern((Integer.valueOf(cds.get(date).getTotalNumOfAftern()) + trc.getCourseInNum()) + "");
				cds.get(date).getCoursesOfAftern().add(roaster);
			}
			
			totolCoures += Integer.valueOf(trc.getCourseInNum());
			noCoures += Integer.valueOf(trc.getCanSignNum());
			i++;
		}
		
		duteCoures = totolCoures - noCoures;
		List<RoasterDay> rds = new ArrayList<RoasterDay>();
		rds.addAll(cds.values());
		if(order.equals(Constants.ORDER_DESC)){
			List<RoasterDay> temps = new ArrayList<RoasterDay>();
			for(int j= cds.size() -1; j>=0; j--){
				temps.add(rds.get(j));
			}
			rds = null;
			rds = temps;
			temps = null;
		}
		TeacherRoasters tr = new TeacherRoasters(teacherId, teacherName, jxId, jxName, branchId, branchName, startDay, endDay, totolCoures, noCoures, duteCoures, rds);
		return tr;
	}
	
	
	
}
