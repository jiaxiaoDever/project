package com.jiaxiao.web.productdata;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jiaxiao.entity.TbBranchesJx;
import com.jiaxiao.entity.TbSubject;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.service.BranchesJxService;
import com.jiaxiao.service.CourseStService;
import com.jiaxiao.service.RoasterJxService;
import com.jiaxiao.service.SubjectService;
import com.jiaxiao.service.TeacherJxService;


@Controller
@RequestMapping(value = "/productData")
public class ProductDataController {

	private static Logger log = LoggerFactory.getLogger(ProductDataController.class);
	@Autowired
	private BranchesJxService baseService;
	
	@Autowired
	private TeacherJxService teaBaseService;
	
	@Autowired
	private SubjectService subBaseService;
	
	@Autowired
	private RoasterJxService roastBaseService;
	
	@Autowired
	private CourseStService courseBaseService;
	
	@RequestMapping("productBranch/{branchName}")
	@ResponseBody
	public String productBranch(@PathVariable String branchName) throws UnsupportedEncodingException{
		branchName = new String(branchName.getBytes("ISO-8859-1"),"UTF-8");
		TbBranchesJx branchesJx = new TbBranchesJx(UUID.randomUUID().toString(),"广州市海珠区新港东路","",
				"欢迎搭乘程通驾校班车，班车路线接送程通驾校学员，详细路线见下表，程通驾校电话：0791-87836206，地址：进贤县泉岭乡320国道旁。",
				"广州市",branchName,"广东省",branchName,"正常","ZC","",new Date(),null,new Date(),"9f4d700e-54c4-4843-8ff0-3fcff6661682",
				"广州程通驾校",null,null);
		int rs = baseService.save(branchesJx);
		if(rs > 0) return branchesJx.getBranchId();
		return "失败";
	}
	
	@RequestMapping("productTeacher/{branchId}/{subjectId}/{teacherName}")
	@ResponseBody
	public String productTeacher(@PathVariable String teacherName,@PathVariable String branchId,@PathVariable String subjectId) throws UnsupportedEncodingException{
		teacherName = new String(teacherName.getBytes("ISO-8859-1"),"UTF-8");
		TbBranchesJx bx = baseService.get(branchId);
		TbSubject subject = subBaseService.get(subjectId);
		TbTeacherJx t = new TbTeacherJx(UUID.randomUUID().toString(), null, branchId, bx.getBranchName(), 55, bx.getBranchCity(), "",new Date(), 38,
				new Date(), null, null, null, null, "值班", "ZB", new Date(), 1, 1, 1, 1, 1, bx.getJxId(), bx.getJxName(), 23, null, "", bx.getBranchProvice(), 68, 43, 1, 56, subjectId, subject.getSubjectName(), 
				bx.getBranchAddress(), null, null, null, null, null, null, null, teacherName);
		int rs = teaBaseService.save(t);
		if(rs > 0) return t.getTeacherId();
		return "失败";
	}
	
	@RequestMapping("productCrouse/{addDayNum}")
	@ResponseBody
	public String productCrouse(@PathVariable Integer addDayNum) throws ParseException{
		TbTeacherJx t = new TbTeacherJx();
		t.setCheckStatCode("SHTG");
		t.setIsFullTime(1);
		t.setIsOnDute(1);
		List<TbTeacherJx> ts = teaBaseService.query(t);
		int rs = 0 ,total = 0;
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		for(TbTeacherJx tea : ts){
			Date tdn = new Date();
			for(int i=0; i<=addDayNum; i++){
				Date td = new Date(tdn.getTime() + i*24*60*60*1000);
				rs = roastBaseService.addTeacherDayRoast(tea, td);
				total += rs;
				log.info("初始化教练课程：教练（"+tea.getTeacherName() + "）日期("+sdFormat.format(td)+") 初始化课程数："+ rs);
			}
		}
		return "插入教练课程数:" + total;
	}
	
}
