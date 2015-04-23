package com.yuhui.core.web.system;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
* @ClassName: KeepSessionController 
* @Description:  保持会话控制器
* @author xiexiaozhi 
* @date 2014-1-13 上午10:35:21 
*
 */
@Controller
@RequestMapping(value = "/system/session")
public class KeepSessionController {

	@RequestMapping("keepSession")
	@ResponseBody
	public String keepSession(String id){
		return id;
	}
}
