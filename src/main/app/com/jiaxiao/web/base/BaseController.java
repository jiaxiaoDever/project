package com.jiaxiao.web.base;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jiaxiao.service.BaseService;
import com.yuhui.core.entity.common.AjaxResult;


/**
 * @author 肖长江
 * 驾校平台基础资源控制，主要操作如下：
 */
@Controller
@RequestMapping(value = "/base")
public class BaseController {

	@Autowired
	private BaseService baseService;
	
	public BaseController() {
		super();
	}
	
	
	/**
	 * @author 肖长江
	 * @date 2015-5-20
	 * @todo TODO 解绑微信用户登录
	 * @param openId 微信openId
	 * @param request
	 * @return
	 */
	@RequestMapping("unBand/{openId}")
	@ResponseBody
	public AjaxResult unBand(@PathVariable String openId,HttpServletRequest request){
		try {
			int rs = baseService.unbandUser(openId);
			return rs > 0?AjaxResult.success():AjaxResult.failure("解绑失败");
		} catch (Exception e) {
			e.printStackTrace();
			return AjaxResult.failure("后台程序异常");
		}
	}
	
}
