package com.jiaxiao.web.teacher;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLDecoder;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jiaxiao.base.Constants;
import com.jiaxiao.entity.TbBaseJx;
import com.jiaxiao.entity.TbBranchesJx;
import com.jiaxiao.entity.TbSysData;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.ro.TeacherRegInfo;
import com.jiaxiao.ro.TeacherRoasters;
import com.jiaxiao.service.BaseService;
import com.jiaxiao.service.BranchesJxService;
import com.jiaxiao.service.JxService;
import com.jiaxiao.service.TeacherJxService;
import com.yuhui.core.entity.common.AjaxResult;
import com.yuhui.core.utils.CacheUtils;

/**
 * @author 肖长江
 * 教练资源控制，提供操作如下：
 * 0.判断微信用户是否已经绑定到教练
 * 1.填写教练信息之前返回相关数据
 * 2.教练注册
 * 3.教练登录
 * 4.请求教练自己当前的课程信息
 * 5.请求教练自己历史的课程信息
 */
@Controller
@RequestMapping(value = "/teacher")
public class TeacherManagerController {

	static int ti=1;

	@Autowired
	private BaseService baseService;
	
	@Autowired
	private JxService jxService;
	
	@Autowired
	private BranchesJxService branchesJxService;
	
	@Autowired
	private TeacherJxService teacherJxService;
	/**
	 * @author 肖长江
	 * @date 2015-4-29
	 * @todo TODO 判断微信用户是否已经绑定学员
	 * @param openId 微信openId
	 * @param request
	 * @return
	 */
	@RequestMapping("isBandedToTeacher/{openId}")
	@ResponseBody
	public AjaxResult isBandedToTeacher(@PathVariable String openId,HttpServletRequest request){
		try {
			String teacherId = baseService.isUserBandedTeacher(openId);
			TbTeacherJx teacherJx = null;
			if(teacherId != null){
				teacherJx = teacherJxService.get(teacherId);
			}
			if(isTest(request)){
				return ti%2 != 0 ?new AjaxResult(true, "", "", "{teacherId:\""+teacherId+"\",isbanded:true,checkstat:\"DSH\"}"):new AjaxResult(true, "", "", "{teacherId:null,isbanded:false,checkstat:null}");
			}
			return teacherId != null ?new AjaxResult(true, "", "", "{teacherId:\""+teacherId+"\",isbanded:true,checkstat:\""+teacherJx.getCheckStatCode()+"\"}") :new AjaxResult(true, "", "", "{teacherId:null,isbanded:false,checkstat:null}");
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-5-14
	 * @todo TODO 填写教练信息之前返回相关数据
	 * @param jxId 驾校编号
	 * @param request
	 * @return
	 */
	@RequestMapping("preRegTeacher/{jxId}")
	@ResponseBody
	public AjaxResult preRegTeacher(@PathVariable String jxId,HttpServletRequest request){
		try {
			if(jxId == null || "".equals(jxId)) jxId = Constants.defaultJx;
			TbBaseJx jx = jxService.get(jxId);
			TeacherRegInfo tr = new TeacherRegInfo();
			if(jx != null){
				String jxName = jx.getJxName();
				TbBranchesJx tbBranchesJx = new TbBranchesJx();
				tbBranchesJx.setJxId(jxId);
				List<TbBranchesJx> branches = branchesJxService.query(tbBranchesJx);
				@SuppressWarnings("unchecked")
				Map<String, List<TbSysData>> dataMap = (Map<String, List<TbSysData>>) CacheUtils.get(Constants.CACHE_SYS_DATA_MAP);
				List<TbSysData> teaCarTypes = (List<TbSysData>) dataMap.get(Constants.TEA_CAR_TYPE_DATA_ID);
				List<TbSysData> carTypes = (List<TbSysData>) dataMap.get(Constants.CAR_TYPE_DATA_ID);
				tr = new TeacherRegInfo(jxId, jxName, branches, teaCarTypes, carTypes);
			}
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.success(tr):AjaxResult.success(new TeacherRegInfo());
			}
			return AjaxResult.success(tr);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-5-14
	 * @todo TODO 提交教练信息注册教练
	 * @param openId 微信openId(在URL中传递)
	 * @param request
	 * @param jxId 驾校编号
	 * @param jxName 驾校名称
	 * @param branchId 网点编号
	 * @param branchName 网点名称
	 * @param subjectId 科目编号
	 * @param subjectName 科目名称
	 * @param teacherName 教练姓名
	 * @param sex 性别(女为0，男为1)
	 * @param duteAge 教龄(月数)
	 * @param cardId 身份证号
	 * @param phoneNo 手机号
	 * @param address 住址
	 * @param logostr 头像base64字符串
	 * @param carLicenseNo 驾驶证编号 
	 * @param carLicenseAge 驾龄(月数)
	 * @param password 密码
	 * @param teaCarTypeCode 准教车型编码
	 * @param teaCarType 准教车型
	 * @param carTypeCode 训练车型编码
	 * @param carType 训练车型
	 * @param carNo 训练车车牌号
	 * @param placeAddress 训练场地址
	 * @param duteDate 入职时间
	 * @param duteLevelNo 教练证编号
	 * @return
	 */
	@RequestMapping("regTeacher/{openId}")
	@ResponseBody
	public AjaxResult regTeacher(HttpServletRequest request,@PathVariable String openId,@RequestParam String jxId,@RequestParam String jxName,@RequestParam String branchId,@RequestParam String branchName,
			@RequestParam String subjectId,@RequestParam String subjectName,@RequestParam String teacherName,@RequestParam Integer sex,@RequestParam Integer duteAge,
			@RequestParam String cardId,@RequestParam String phoneNo,@RequestParam String address,@RequestParam String logostr,@RequestParam String carLicenseNo,
			@RequestParam String carLicenseAge,@RequestParam String password,@RequestParam String teaCarTypeCode,@RequestParam String teaCarType,@RequestParam String carTypeCode,
			@RequestParam String carType,@RequestParam String carNo,@RequestParam String placeAddress,@RequestParam String duteDate,@RequestParam String duteLevelNo){
		try {
			jxName = URLDecoder.decode(jxName, "UTF-8");
			branchName = URLDecoder.decode(branchName, "UTF-8");
			subjectName = URLDecoder.decode(subjectName, "UTF-8");
			teacherName = URLDecoder.decode(teacherName, "UTF-8");
			address = URLDecoder.decode(address, "UTF-8");
			teaCarType = URLDecoder.decode(teaCarType, "UTF-8");
			carType = URLDecoder.decode(carType, "UTF-8");
			placeAddress = URLDecoder.decode(placeAddress, "UTF-8");
			password = entryptPassword(password);
			String teaLogo = savePic(logostr);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			TbTeacherJx tbTeacherJx = new TbTeacherJx(UUID.randomUUID().toString(), null, branchId, branchName, null, null, null, new Date(), duteAge, df.parse(duteDate), null, null, duteLevelNo, null, Constants.TEACHE_DUTESTAT_DEF, Constants.TEACHE_DUTESTAT_DEF_CODE, new Date(),null
					, null, null, null, null, jxId, jxName, null, null, cardId, null, null, null, sex, null, subjectId, subjectName, address, null, teaLogo, null, phoneNo, null, null, null, teacherName, Constants.TEACHE_CHECK_DEF_CODE, Constants.TEACHE_CHECK_DEF, carLicenseNo, 
					carLicenseAge, null, password, teaCarTypeCode, teaCarType, carTypeCode, carType, carNo, placeAddress, null, null);
			int rs = teacherJxService.regTeacher(tbTeacherJx, openId);
			if(rs > 0){
				return AjaxResult.success();
			}else{
				return AjaxResult.failure("操作失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 绑定微信用户到教练
	 * @param openId 微信openId
	 * @param teacherName 教练姓名
	 * @param password 密码
	 * @param teacherPhone 手机号
	 * @param request
	 * @return
	 */
	@RequestMapping("bandToTeacher/{openId}")
	@ResponseBody
	public AjaxResult bandToTeacher(@PathVariable String openId,@RequestParam String teacherName,@RequestParam String password,
			@RequestParam String teacherPhone,HttpServletRequest request){
		try {
			if(isTest(request)){
				return ti%2 != 0 ?AjaxResult.failure("找不到对应教练"):new AjaxResult(true, "", "", "{teacherId:\"6fdea2dd-a28d-429d-934b-658b900e900e\"}");
			}
			boolean isbanded = false;
			if(openId != null && password != null && teacherName != null && teacherPhone != null 
					&& !"".equals(openId) && !"".equals(password) && !"".equals(teacherName) 
					&& !"".equals(teacherPhone)){
				teacherName = URLDecoder.decode(teacherName, "UTF-8");
				password = entryptPassword(password);
				int rs = teacherJxService.bandToTeacher(openId, teacherName, password, teacherPhone);
				if(rs == 2) return AjaxResult.failure("找不到对应教练");
				if(rs == 3) return AjaxResult.failure("更新数据库失败");
				isbanded = true;
			}else{
				return AjaxResult.failure("提交的参数不符合要求");
			}
			return isbanded?isBandedToTeacher(openId, request):AjaxResult.failure("绑定失败");
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 请求教练以前的课程信息
	 * @param teacherId 教练编号
	 * @param endDate 截止日期
	 * @param request
	 * @return
	 */
	@RequestMapping("findCourseDetailBefore/{endDate}/{teacherId}")
	@ResponseBody
	public AjaxResult findCourseDetailBefore(@PathVariable String endDate,@PathVariable String teacherId,HttpServletRequest request){
		try {
			TeacherRoasters tr = teacherJxService.getTeacherRoastBefore(teacherId,endDate);
			return AjaxResult.success(tr);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序发生异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 请求教练以后的课程信息
	 * @param teacherId 教练编号
	 * @param request
	 * @return
	 */
	@RequestMapping("findCourseDetailAfter/{teacherId}")
	@ResponseBody
	public AjaxResult findCourseDetailAfter(@PathVariable String teacherId,HttpServletRequest request){
		try {
			TeacherRoasters tr = teacherJxService.getTeacherRoastAfter(teacherId);
			return AjaxResult.success(tr);
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序发生异常");
		}
	}
	
	/**
	 * @author 肖长江
	 * @date 2015-5-15
	 * @todo TODO 将64位图片字符串保存为图片
	 * @param picStrBase64 64位图片字符串
	 * @return
	 */
	private String savePic(String picStrBase64){
		FileOutputStream fos = null;
		try{ 
			String fileDir = "file"+File.separator+"img"+File.separator;
			String realPath=TeacherManagerController.class.getResource("/").toURI().getPath();
			String path = realPath.substring(0,realPath.indexOf("WEB-INF"))+fileDir;//
			String filename=RandomUtils.nextInt()+".png";
			File dir = new File(path);
			if(!dir.exists()){
				dir.mkdirs();
			}
			@SuppressWarnings("restriction")
			byte[] result = new sun.misc.BASE64Decoder().decodeBuffer(picStrBase64.trim()); 
			File file = new File(path+filename);
			file.createNewFile();
			fos = new FileOutputStream(file);
			fos.write(result); 
			fos.flush();
			return fileDir + filename;
		}catch(Exception e){ 
			e.printStackTrace(); 
		}finally{
			try {
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}
		return null;
	}

	/**
	 * @author 肖长江
	 * @date 2015-5-18
	 * @todo TODO 采用md5方式加密密码
	 * @param password
	 * @return
	 */
	private static String entryptPassword(String password) {
		char hexDigits[] = {
		         '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
		     try {
		         byte[] strTemp = password.getBytes();
		         MessageDigest mdTemp = MessageDigest.getInstance("MD5");
		         mdTemp.update(strTemp);
		         byte[] md = mdTemp.digest();
		         int j = md.length;
		         char str[] = new char[j * 2];
		         int k = 0;
		         for (int i = 0; i < j; i++) {
		             byte byte0 = md[i];
		             str[k++] = hexDigits[byte0 >>> 4 & 0xf];
		             str[k++] = hexDigits[byte0 & 0xf];
		         }
		         return new String(str);
		     } catch (Exception e) {
		         return null;
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
	
	public static void main(String[] args) {
		try {
			System.out.println(entryptPassword("123456"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
