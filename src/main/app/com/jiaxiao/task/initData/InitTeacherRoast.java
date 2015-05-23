package com.jiaxiao.task.initData;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.jiaxiao.base.Constants;
import com.jiaxiao.entity.TbTeacherJx;
import com.jiaxiao.service.RoasterJxService;
import com.jiaxiao.service.TeacherJxService;

/**
 * @author 肖长江
 * 初始化教练课程信息
 */
@Component
public class InitTeacherRoast {
	private static Logger log = LoggerFactory.getLogger(InitTeacherRoast.class);
	
	@Autowired
	private RoasterJxService roastBaseService;
	@Autowired
	private TeacherJxService teaBaseService;
	
	/**
	 * @author 肖长江
	 * @date 2015-5-23
	 * @todo TODO 生成课程排班信息
	 */
	public void productCrouse() {
		TbTeacherJx t = new TbTeacherJx();
		t.setCheckStatCode(Constants.TEACHE_CHECK_OK_CODE);
		t.setIsFullTime(Constants.STAT_DEF);
		t.setIsOnDute(Constants.STAT_DEF);
		List<TbTeacherJx> ts = teaBaseService.query(t);
		int rs = 0;
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		for(TbTeacherJx tea : ts){
			Date tdn = new Date();
			for(int i=0; i<=Constants.INIT_ROAST_DAY; i++){
				Date td = new Date(tdn.getTime() + i*24*60*60*1000);
				rs = roastBaseService.addTeacherDayRoast(tea, td);
				log.info("初始化教练课程：教练（"+tea.getTeacherName() + "）日期("+sdFormat.format(td)+") 初始化课程数："+ rs);
			}
		}
	}
}
