package com.yuhui.core.web.system;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuhui.core.entity.system.UserBase;
import com.yuhui.core.exception.BusinessException;
import com.yuhui.core.exception.SystemException;
import com.yuhui.core.log.CallPerformanceLog;
import com.yuhui.core.service.system.UserService;
import com.yuhui.core.utils.json.JsonResult;
import com.yuhui.core.utils.page.Page;



@Controller
@RequestMapping(value = "/system/test")
public class TestController {

	@SuppressWarnings("unused")
	private static Logger log = LoggerFactory.getLogger(TestController.class);
	@Autowired
	private UserService userService;
	
	@RequestMapping("getUserByPage")
	@ResponseBody
	public JsonResult getUserPage(){
		
		List<UserBase> list =userService.getUsersByPage(1, 20);
		
		return JsonResult.create().msg("成功！").success(true).put("userlist", list);
	
	}
	
	
	@RequestMapping("getUsersPageStr")
	@ResponseBody
	@CallPerformanceLog(desc="测试分页")
	public Page<UserBase> getUsersPage(){
		
		Page<UserBase> rs =userService.getPageUsers("admin",1, 20);
		
		
		return rs;
	
	}
	
	@RequestMapping("TestBusinessException")
	@ResponseBody
	public void TestBusinessException() throws BusinessException {
		throw new BusinessException("this is Business error ");
	}
	
	@RequestMapping("TestSystemException")
	@ResponseBody
	public void TestSystemException() throws SystemException {
		throw new SystemException("this is System error ");
	}
	@SuppressWarnings("null")
	@RequestMapping("TestNullPointException")
	@ResponseBody
	public void TestNullPointException() {
		Date date = null ;
		
		date.getTime();
	}
}
