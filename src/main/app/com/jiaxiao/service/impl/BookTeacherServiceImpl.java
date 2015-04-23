package com.jiaxiao.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.entity.TbCourseSt;
import com.jiaxiao.entity.TbRoasterJx;
import com.jiaxiao.entity.TbStudentJx;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.entity.TeacherCourses;
import com.jiaxiao.repository.CourseStDAO;
import com.jiaxiao.repository.RoasterJxDAO;
import com.jiaxiao.repository.StudentJxDAO;
import com.jiaxiao.repository.TeacherJxDAO;
import com.jiaxiao.ro.BookTeachers;
import com.jiaxiao.ro.Course;
import com.jiaxiao.ro.CourseDay;
import com.jiaxiao.ro.Teacher;
import com.jiaxiao.service.BaseService;
import com.jiaxiao.service.BookTeacherService;

@Service(value = "bookTeacherService")
@Transactional(readOnly = true)
public class BookTeacherServiceImpl implements BookTeacherService {

	@Autowired
	public BaseService baseService;
	
	@Autowired
	public StudentJxDAO studentJxDAO;
	
	@Autowired
	public TeacherJxDAO teacherJxDAO;
	
	@Autowired
	public RoasterJxDAO roasterJxDAO;
	
	@Autowired
	public CourseStDAO courseStDAO;
	
	@Override
	public BookTeachers bookTeacher(String openId) throws Exception {
		//1.判断用户是否已经绑定学员
		String studentId = baseService.isUserBandedStudent(openId);
		BookTeachers bTeachers = new BookTeachers();
		bTeachers.setOpenId(openId);
		if(studentId != null){
			//2.已经绑定查找教练信息
			TbStudentJx studentJx = studentJxDAO.get(TbStudentJx.class, studentId);
			bTeachers.setBanded(true);
			bTeachers.setBranchId(studentJx.getBranchId());
			bTeachers.setBranchName(studentJx.getBranchName());
			bTeachers.setOpenId(openId);
			bTeachers.setSubjectId(studentJx.getSubjectId());
			bTeachers.setSubjectName(studentJx.getSubjectName());
			bTeachers.setStudentId(studentId);
			bTeachers.setSubjectTeachers(new HashMap<String, List<Teacher>>());
			List<TeacherCourses> tcs = teacherJxDAO.findTeacherCouresOnBranch(studentJx.getBranchId());
			List<Teacher> ts = convertToTeacher(tcs, false);
			for(Teacher t: ts){
				if(!bTeachers.getSubjectTeachers().containsKey(t.getSubjectId())){
					bTeachers.getSubjectTeachers().put(t.getSubjectId(), new ArrayList<Teacher>());
				}
				bTeachers.getSubjectTeachers().get(t.getSubjectId()).add(t);
			}
			return bTeachers;
		}else{
			bTeachers.setBanded(false);
			return bTeachers;
		}
	}

	@Override
	public CourseDay FindTeacherCourseDetail(String teacherId,
			String bookingDate) throws Exception {
		List<TeacherCourses> tcs = teacherJxDAO.findTeacherCouresDetail(teacherId, bookingDate);
		List<Teacher> ts = convertToTeacher(tcs, true);
		if(ts != null && ts.get(0) != null && ts.get(0).getCourseDays() != null && ts.get(0).getCourseDays().size() > 0 ) return ts.get(0).getCourseDays().get(0);
		return null;
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int bookCourse(String openId, String courseId) throws Exception {
		//1.找出openId对应的学员，判断是否存在和绑定
		TbStudentJx studentJx = studentJxDAO.getBandedStudentJx(openId);
		if(studentJx == null) return 0;
		//2.判断当前学员是否还有剩余课时
		if(studentJx.getCanSignCourseNum() < 1) return 4;
		//3.判断当前学员当前预约的课时是否达到上限
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<TbCourseSt> courseSts = courseStDAO.getDayBookNum(studentJx.getStudentId(), sdf.format(new Date()));
		if(courseSts != null && courseSts.size() >= studentJx.getMaxNumSign()) return 5;
		//4.判断当前课时，该学员是否已经预约
		boolean isBooked = false;
		for(TbCourseSt c:courseSts){
			if(c.getCourseId().equals(courseId)){
				isBooked = true;
				break;
			}
		}
		if(isBooked) return 6;
		//3.修改当前课程信息：可预约人数减一，
		//如果成功则新增学员课程信息以及学员剩余课时数减一，否则查看课程是否已无空位
		int rs = teacherJxDAO.bookingTeacherCourse(courseId);
		TbRoasterJx tr = roasterJxDAO.get(TbRoasterJx.class, courseId);
		if(rs > 0){
			TbCourseSt stc = new TbCourseSt();
			stc.setCourseId(courseId);
			stc.setCourseName(tr.getCourseName());
			stc.setStCourseId(UUID.randomUUID().toString());
			stc.setStudentId(studentJx.getStudentId());
			stc.setStudentName(studentJx.getStudentName());
			int i = teacherJxDAO.addStudentCourse(stc);
			if(i > 0){
				int j = teacherJxDAO.reduceStudentCanSianNum(studentJx.getStudentId());
				return j > 0 ? 1 : 3;
			}
			return 3;
		}else{
			if(tr != null){
				if(tr.getCanSignNum() < 1) return 2;
				if(tr.getStartTime().getTime() <= (new Date()).getTime()) return 2;
			}
			return 3;
		}
	}

	/**
	 * @author 肖长江
	 * @date 2015-4-18
	 * @todo TODO 将课程详细信息实体封装成课程总体信息和详细信息的视图实体
	 * @param tcs 课程详细信息实体集合
	 * @param convertDetail 是否封装详细信息到视图实体
	 * @return
	 * @throws Exception
	 */
	private List<Teacher> convertToTeacher(List<TeacherCourses> tcs, boolean convertDetail) throws Exception{
		List<Teacher> ts = new ArrayList<Teacher>();
		Map<String, List<TbRoasterJx>> tcmMap = new TreeMap<String, List<TbRoasterJx>>();
		Map<String, TbTeacherJx> tsMap = new TreeMap<String, TbTeacherJx>();
		for(TeacherCourses tc : tcs){
			if(!tcmMap.containsKey(tc.getTbTeacherJx().getTeacherId())){
				tcmMap.put(tc.getTbTeacherJx().getTeacherId(), new ArrayList<TbRoasterJx>());
				tsMap.put(tc.getTbTeacherJx().getTeacherId(), tc.getTbTeacherJx());
			}
			tcmMap.get(tc.getTbTeacherJx().getTeacherId()).addAll(tc.getTbRoasterJxs());
		}
		for(TbTeacherJx t:tsMap.values()){
			Teacher tr = new Teacher(t.getTeacherId(), t.getTeacherName(), t.getJxId(), t.getJxName(), t.getBranchId(), t.getBranchName(), 
					t.getSubjectId(), t.getSubjectName(), t.getTeaLogo(), t.getScore()+"", t.getScoreNum()+"", t.getCheckNum()+"",
					t.getLikeNum()+"", t.getDuteAge()+"", t.getSex() == 1 ? "男":"女", t.getIsHot() == 1 ? true : false, null);
			Map<Date, CourseDay> cds = new TreeMap<Date, CourseDay>();
			for(TbRoasterJx trc:tcmMap.get(t.getTeacherId())){
				SimpleDateFormat tFormat = new SimpleDateFormat("HH:mm");
				if(trc.getStartTime().getTime() <= (new Date()).getTime()) trc.setCanSignNum(0);
				Course course = new Course(trc.getCourseId(), trc.getCourseName(), tFormat.format(trc.getStartTime()), tFormat.format(trc.getEndTime()), trc.getCourseTimearea(), trc.getCourseInNum()+"", trc.getCanSignNum()+"");
				SimpleDateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date date = dFormat.parse(dFormat.format(trc.getStartTime()));
				if(!cds.containsKey(date)){
					cds.put(date, new CourseDay(dFormat.format(date), trc.getSubjectId(), trc.getSubjectName(), trc.getTeacherId(), trc.getTeacherName(), 
							"0", "0", "0", "0", "0", "0", new ArrayList<Course>(), new ArrayList<Course>()));
				}
				cds.get(date).setCanBookNum((Integer.valueOf(cds.get(date).getCanBookNum()) + trc.getCanSignNum())+"");
				cds.get(date).setTotalNum((Integer.valueOf(cds.get(date).getTotalNum()) + trc.getCourseInNum())+"");
				if("上午".equals(trc.getCourseTimearea())){
					cds.get(date).setCanBookNumOfMorn((Integer.valueOf(cds.get(date).getCanBookNumOfMorn()) + trc.getCanSignNum()) + "");
					cds.get(date).setTotalNumOfMorn((Integer.valueOf(cds.get(date).getTotalNumOfMorn()) + trc.getCourseInNum()) + "");
					if(convertDetail) cds.get(date).getCoursesOfMorn().add(course);
				}
				if("下午".equals(trc.getCourseTimearea())){
					cds.get(date).setCanBookNumOfAftern((Integer.valueOf(cds.get(date).getCanBookNumOfAftern()) + trc.getCanSignNum()) + "");
					cds.get(date).setTotalNumOfAftern((Integer.valueOf(cds.get(date).getTotalNumOfAftern()) + trc.getCourseInNum()) + "");
					if(convertDetail) cds.get(date).getCoursesOfAftern().add(course);
				}
			}
			List<CourseDay> lcds = new ArrayList<CourseDay>();
			lcds.addAll(cds.values());
			tr.setCourseDays(lcds);
			ts.add(tr);
		}
		return ts;
	}


}
