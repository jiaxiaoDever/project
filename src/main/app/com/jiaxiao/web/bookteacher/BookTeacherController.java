package com.jiaxiao.web.bookteacher;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jiaxiao.base.Constants;
import com.jiaxiao.entity.StudentCourse;
import com.jiaxiao.ro.BookTeachers;
import com.jiaxiao.ro.Course;
import com.jiaxiao.ro.CourseDay;
import com.jiaxiao.ro.Teacher;
import com.jiaxiao.service.BaseService;
import com.jiaxiao.service.BookTeacherService;
import com.yuhui.core.entity.common.AjaxResult;

/**
 * @author 肖长江
 * 预约教练资源控制对象，提供操作如下：
 * 0.判断微信用户是否已经绑定学员
 * 1.绑定微信用户到对应学员
 * 2.请求微信用户对应驾校网点的教练信息
 * 3.请求某教练某天的课程详细信息
 * 4.微信用户预订了课程
 * 5.查看用户自己已经预约的教练
 * 6.用户取消已经预约的教练课程
 * 7.学员练车后对课程进行评价
 */
@Controller
@RequestMapping(value = "/bookTeacher")
public class BookTeacherController {

	static int ti=1;
	@Autowired
	private BaseService baseService;
	
	@Autowired
	private BookTeacherService bookTeacherService;
	
	/**
	 * @author 肖长江
	 * @date 2015-4-29
	 * @todo TODO 判断微信用户是否已经绑定学员
	 * @param openId 微信openId
	 * @param request
	 * @return
	 */
	@RequestMapping("isBandedToStudent/{openId}")
	@ResponseBody
	public AjaxResult isBandedToStudent(@PathVariable String openId,HttpServletRequest request){
		try {
			String studentId = baseService.isUserBandedStudent(openId);
			if(isTest(request)){
				return ti%2 != 0 ?new AjaxResult(true, "", "", "{studentId:"+studentId+",isbanded:true}"):new AjaxResult(true, "", "", "{studentId:null,isbanded:false}");
			}
			return studentId != null ?new AjaxResult(true, "", "", "{studentId:"+studentId+",isbanded:true}"):new AjaxResult(true, "", "", "{studentId:null,isbanded:false}");
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 绑定微信用户到对应学员
	 * @param openId 微信ID
	 * @param studentName 学员姓名
	 * @param studentCardId 学员卡号
	 * @param studentPhone 学员手机号
	 * @return 
	 */
	@RequestMapping("bandingToStudent/{openId}")
	@ResponseBody
	public AjaxResult bandingToStudent(@PathVariable String openId,@RequestParam String studentName,@RequestParam String studentCardId,
			@RequestParam String studentPhone,HttpServletRequest request){
		try {
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.failure("找不到对应学员"):new AjaxResult(true, "", "", "{studentId:asdfewfasdfawe}");
			}
			boolean isbanded = false;
			if(openId != null && studentCardId != null && studentName != null && studentPhone != null 
					&& !"".equals(openId) && !"".equals(studentCardId) && !"".equals(studentName) 
					&& !"".equals(studentPhone)){
				studentName = URLDecoder.decode(studentName, "UTF-8");
				int rs = baseService.bandToStudent(openId, studentName, studentCardId, studentPhone);
				if(rs == 2) return AjaxResult.failure("找不到对应学员");
				if(rs == 3) return AjaxResult.failure("更新数据库失败");
				isbanded = true;
			}else{
				return AjaxResult.failure("提交的参数不符合要求");
			}
			String studentId = baseService.isUserBandedStudent(openId);
			return isbanded?new AjaxResult(true, "", "", "{studentId:"+studentId+"}"):AjaxResult.failure("绑定失败");
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	
	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 绑定微信用户到对应学员，并返回可约教练信息
	 * @param openId 微信ID
	 * @param studentName 学员姓名
	 * @param studentCardId 学员卡号
	 * @param studentPhone 学员手机号
	 * @return 
	 */
	@RequestMapping("bandToStudent/{openId}")
	@ResponseBody
	public AjaxResult bandToStudent(@PathVariable String openId,@RequestParam String studentName,@RequestParam String studentCardId,
			@RequestParam String studentPhone,HttpServletRequest request){
		try {
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.failure("帐号不存在"):AjaxResult.success(testBookTeacherBanded());
			}
			boolean isbanded = false;
			if(openId != null && studentCardId != null && studentName != null && studentPhone != null 
					&& !"".equals(openId) && !"".equals(studentCardId) && !"".equals(studentName) 
					&& !"".equals(studentPhone)){
				studentName = URLDecoder.decode(studentName, "UTF-8");
				int rs = baseService.bandToStudent(openId, studentName, studentCardId, studentPhone);
				if(rs == 2) return AjaxResult.failure("找不到对应学员");
				if(rs == 3) return AjaxResult.failure("更新数据库失败");
				isbanded = true;
			}else{
				return AjaxResult.failure("提交的参数不符合要求");
			}
			return isbanded?findBookTeachers(openId, request):AjaxResult.failure("绑定失败");
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}

	/**
	 * @author 肖长江
	 * @date 2015-4-14
	 * @todo TODO 请求微信用户对应驾校网点的教练信息
	 * @param openId 用户的微信ID
	 * @return 返回 BookTeachers 对象
	 */
	@RequestMapping("findBookTeachers/{openId}")
	@ResponseBody
	public AjaxResult findBookTeachers(@PathVariable String openId,HttpServletRequest request){
		try {
			if(isTest(request)){
				return AjaxResult.success(ti%2 != 0 ?testBookTeacherUnbanded():testBookTeacherBanded());
			}
			BookTeachers bt = bookTeacherService.bookTeacher(openId);
			if(bt != null){
				if(bt.getSubjectTeachers() != null && !bt.getSubjectTeachers().containsKey(Constants.subject2Id))
					bt.getSubjectTeachers().put(Constants.subject2Id, new ArrayList<Teacher>());
				if(bt.getSubjectTeachers() != null && !bt.getSubjectTeachers().containsKey(Constants.subject3Id))
					bt.getSubjectTeachers().put(Constants.subject3Id, new ArrayList<Teacher>());
			}
			return AjaxResult.success(bt);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序发生异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 请求某教练某天的课程详细信息
	 * @param teacherId 教练编号
	 * @param bookingDate 查看日期
	 * @param request
	 * @return 返回教练那天的课程详细信息
	 */
	@RequestMapping("findTeacherCourseDetail/{bookingDate}/{teacherId}")
	@ResponseBody
	public AjaxResult findTeacherCourseDetail(@PathVariable String teacherId,@PathVariable String bookingDate,HttpServletRequest request){
		try {
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.success(testFindCourseDay()):AjaxResult.failure("后台异常");
			}
			CourseDay cd = bookTeacherService.FindTeacherCourseDetail(teacherId, bookingDate);
			return AjaxResult.success(cd);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序发生异常");
		}
	}

	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 微信用户预订了课程
	 * @param courseId 课程编号
	 * @param openId 微信用户openId
	 * @param request
	 * @return 返回预订结果
	 */
	@RequestMapping("bookCourse/{courseId}/{openId}")
	@ResponseBody
	public AjaxResult bookCourse(@PathVariable String courseId,@PathVariable String openId,HttpServletRequest request){
		try {
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.success():AjaxResult.failure("该节课程已经没有空位");
			}
			int rs = bookTeacherService.bookCourse(openId, courseId);
			if(rs == 0){
				return AjaxResult.failure("找不到微信用户对应学员");
			}else if(rs == 1){
				return AjaxResult.success();
			}else if(rs == 2){				
				return AjaxResult.failure("该节课程已经没有空位");
			}else if(rs == 3){				
				return AjaxResult.failure("预约失败");
			}else if(rs == 4){				
				return AjaxResult.failure("学员已无剩余课时");
			}else if(rs == 5){				
				return AjaxResult.failure("学员当日可预约课时已满");
			}else{				
				return AjaxResult.failure("学员当前课程已经预约过");
			}
		} catch (Exception e) {
			if("3".equals(e.getMessage())){
				return AjaxResult.failure("预约失败");
			}
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-27
	 * @todo TODO 查看用户自己已经预约的教练
	 * @param openId 用户微信openId
	 * @param request
	 * @return 返回用户已经预约的教练
	 */
	@RequestMapping("bookedCourses/{openId}")
	@ResponseBody
	public AjaxResult bookedCourses(@PathVariable String openId,HttpServletRequest request){
		try {
			List<StudentCourse> scs = bookTeacherService.bookedCourses(openId);
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.success(scs):AjaxResult.success("unbanded");
			}
			return scs == null ? AjaxResult.success("微信用户还未绑定学员","unbanded"):AjaxResult.success(scs);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-29
	 * @todo TODO 用户取消已经预约的教练课程
	 * @param openId 微信用户openId
	 * @param stCourseId 学员课程编号
	 * @param request
	 * @return
	 */
	@RequestMapping("cancelCourse/{openId}/{stCourseId}")
	@ResponseBody
	public AjaxResult cancelCourse(@PathVariable String openId,@PathVariable String stCourseId,HttpServletRequest request){
		try {
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.success():AjaxResult.failure("取消失败");
			}
			int rs = bookTeacherService.cancelCourse(openId, stCourseId);
			if(rs == 0){
				return AjaxResult.failure("取消失败");
			}else if(rs == 1){
				return AjaxResult.success();
			}else if(rs == 2){				
				return AjaxResult.failure("找不到微信用户对应学员");
			}else if(rs == 3){				
				return AjaxResult.failure("超出变更时间");
			}else if(rs == 4){				
				return AjaxResult.failure("找不到对应的教练课程");
			}else{				
				return AjaxResult.failure("取消失败");
			}
		} catch (Exception e) {
			if("0".equals(e.getMessage())){
				return AjaxResult.failure("取消失败");
			}
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-30
	 * @todo TODO 学员练车后对课程进行评价
	 * @param stCourseId 学员约课编号
	 * @param teacherScore 教练评分
	 * @param carScore 练车环境评分
	 * @param serviceScore 整体服务评分
	 * @param scoreInfo 评论内容
	 * @return
	 */
	@RequestMapping("scoreCourse/{stCourseId}")
	@ResponseBody
	public AjaxResult scoreCourse(@PathVariable String stCourseId,@RequestParam Integer teacherScore,@RequestParam Integer carScore,@RequestParam Integer serviceScore,@RequestParam String scoreInfo,HttpServletRequest request){
		try {
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.success():AjaxResult.failure("评论失败");
			}
			scoreInfo = URLDecoder.decode(scoreInfo, "UTF-8");
			int rs = bookTeacherService.scoreCourse(stCourseId, carScore, teacherScore, serviceScore, scoreInfo);
			if(rs == 1){
				return AjaxResult.success();
			}else{
				return AjaxResult.failure("评论失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 是否为测试接口
	 * @param request
	 * @return
	 */
	private boolean isTest(HttpServletRequest request){
		String istest = request.getParameter("istest");
		if(istest != null && !"".equals(istest)){
			ti++;
			return true;
		}
		return false;
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 课程详细信息  模拟数据接口
	 * @return
	 */
	private CourseDay testFindCourseDay(){
		CourseDay cDay = new CourseDay();
		cDay.setCanBookNum("12");
		cDay.setCanBookNumOfAftern("10");
		cDay.setCanBookNumOfMorn("2");
		cDay.setDay("2015-04-18");
		cDay.setSubjectId("xxxxxx");
		cDay.setSubjectName("xxxxxxx");
		cDay.setTotalNum("24");
		cDay.setTotalNumOfAftern("15");
		cDay.setTotalNumOfMorn("9");
		cDay.setTeacherId("xxxxxx");
		cDay.setTeacherName("张三");
		/*Course course = new Course();
		course.setCanSignNum("剩余可约车人数");
		course.setCourseId("课程编号");
		course.setCourseInNum("可约车人数");
		course.setCourseName("课程名称");
		course.setCourseTimearea("课程所属时间段");
		course.setEndTime("结束时间");
		course.setStartTime("开始时间");*/
		Course course1 = new Course();
		course1.setCanSignNum("1");
		course1.setCourseId("xxxxxxxxxxxx");
		course1.setCourseInNum("3");
		course1.setCourseName("xxxxxxxxxxx");
		course1.setCourseTimearea("上午");
		course1.setStartTime("09:00:00");
		course1.setEndTime("10:00:00");
		Course course2 = new Course();
		course2.setCanSignNum("0");
		course2.setCourseId("xxxxxxx");
		course2.setCourseInNum("3");
		course2.setCourseName("xxxxxx");
		course2.setCourseTimearea("上午");
		course2.setEndTime("11:00:00");
		course2.setStartTime("10:00:00");
		Course course3 = new Course();
		course3.setCanSignNum("1");
		course3.setCourseId("xxxxxxx");
		course3.setCourseInNum("3");
		course3.setCourseName("xxxxxx");
		course3.setCourseTimearea("上午");
		course3.setEndTime("12:00:00");
		course3.setStartTime("11:00:00");
		
		//cDay.getCoursesOfMorn().add(course);
		cDay.getCoursesOfMorn().add(course1);
		cDay.getCoursesOfMorn().add(course2);
		cDay.getCoursesOfMorn().add(course3);
		
		
		Course course4 = new Course();
		course4.setCanSignNum("2");
		course4.setCourseId("xxxxxxx");
		course4.setCourseInNum("3");
		course4.setCourseName("xxxxxx");
		course4.setCourseTimearea("下午");
		course4.setEndTime("14:00:00");
		course4.setStartTime("13:00:00");
		Course course5 = new Course();
		course5.setCanSignNum("3");
		course5.setCourseId("xxxxxxx");
		course5.setCourseInNum("3");
		course5.setCourseName("xxxxxx");
		course5.setCourseTimearea("下午");
		course5.setEndTime("15:00:00");
		course5.setStartTime("14:00:00");
		Course course6 = new Course();
		course6.setCanSignNum("2");
		course6.setCourseId("xxxxxxx");
		course6.setCourseInNum("3");
		course6.setCourseName("xxxxxx");
		course6.setCourseTimearea("下午");
		course6.setEndTime("16:00:00");
		course6.setStartTime("15:00:00");
		Course course7 = new Course();
		course7.setCanSignNum("1");
		course7.setCourseId("xxxxxxx");
		course7.setCourseInNum("3");
		course7.setCourseName("xxxxxx");
		course7.setCourseTimearea("下午");
		course7.setEndTime("17:00:00");
		course7.setStartTime("16:00:00");
		Course course8 = new Course();
		course8.setCanSignNum("0");
		course8.setCourseId("xxxxxxx");
		course8.setCourseInNum("3");
		course8.setCourseName("xxxxxx");
		course8.setCourseTimearea("下午");
		course8.setEndTime("18:00:00");
		course8.setStartTime("17:00:00");
		
		cDay.getCoursesOfAftern().add(course4);
		cDay.getCoursesOfAftern().add(course5);
		cDay.getCoursesOfAftern().add(course6);
		cDay.getCoursesOfAftern().add(course7);
		cDay.getCoursesOfAftern().add(course8);
		return cDay;
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 未绑定学员的情况下，预约教练模拟数据接口
	 * @return
	 */
	private BookTeachers testBookTeacherUnbanded(){
		BookTeachers bt = new BookTeachers();
		bt.setOpenId("xxxxx");
		bt.setBanded(false);
		return bt;
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-4-16
	 * @todo TODO 已经绑定学员的情况下，预约教练模拟数据接口
	 * @return
	 */
	private BookTeachers testBookTeacherBanded(){
		BookTeachers bt = new BookTeachers();
		bt.setBanded(true);
		bt.setBranchId("xxxxxxxx");
		bt.setBranchName("城通驾校员村四横路点");
		bt.setOpenId("xxxxx");
		bt.setSubjectId("de9581d9-d016-470b-9126-ae297b673e57");
		bt.setSubjectName("科目二");
		bt.setStudentId("xxxxxxx");
		Teacher t1 = new Teacher();
		t1.setBranchId("xxxxxxx");
		t1.setBranchName("城通驾校员村四横路点");
		t1.setCheckNum("1111");
		t1.setDuteAge("20");
		t1.setHot(false);
		t1.setJxId("xxxxxx");
		t1.setJxName("城通驾校");
		t1.setLikeNum("44");
		t1.setScroe("78");
		t1.setScroeNum("30");
		t1.setSex("男");
		t1.setSubjectId("de9581d9-d016-470b-9126-ae297b673e57");
		t1.setSubjectName("科目二");
		t1.setTeacherId("xxxxxx");
		t1.setTeacherName("张三");
		t1.settLogo("http://t11.baidu.com/it/u=875722561,4142598890&fm=76");
		CourseDay cDay = new CourseDay();
		cDay.setCanBookNum("16");
		cDay.setCanBookNumOfAftern("10");
		cDay.setCanBookNumOfMorn("6");
		cDay.setDay("2015-04-17");
		cDay.setSubjectId("de9581d9-d016-470b-9126-ae297b673e57");
		cDay.setSubjectName("科目二");
		cDay.setTotalNum("24");
		cDay.setTotalNumOfAftern("15");
		cDay.setTotalNumOfMorn("9");
		cDay.setTeacherId("xxxxxxxxx");
		cDay.setTeacherName("李斯");
		CourseDay cDay2 = new CourseDay();
		cDay2.setCanBookNum("16");
		cDay2.setCanBookNumOfAftern("10");
		cDay2.setCanBookNumOfMorn("6");
		cDay2.setDay("2015-04-18");
		cDay2.setSubjectId("xxxxxx");
		cDay2.setSubjectName("xxxxxxx");
		cDay2.setTotalNum("24");
		cDay2.setTotalNumOfAftern("15");
		cDay2.setTotalNumOfMorn("9");
		cDay2.setTeacherId("xxxxxx");
		cDay2.setTeacherName("张三");
		t1.getCourseDays().add(cDay);
		t1.getCourseDays().add(cDay2);
		List<Teacher> t1s = new ArrayList<Teacher>();
		t1s.add(t1);
		List<Teacher> t2s = new ArrayList<Teacher>();
		bt.getSubjectTeachers().put("de9581d9-d016-470b-9126-ae297b673e57", t1s);
		bt.getSubjectTeachers().put("351742ee-ebcc-40cc-b5fc-fb3a39131e14", t2s);
		return bt;
	}

	
	public static void main(String[] args) {
		System.out.println(UUID.randomUUID());
	}
}
