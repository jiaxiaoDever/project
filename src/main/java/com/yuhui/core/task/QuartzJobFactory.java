package com.yuhui.core.task;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.yuhui.core.entity.base.ScheduleJob;


/**
 * @author 肖长江
 * 计划任务执行处 无状态
 */
public class QuartzJobFactory implements Job {
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		ScheduleJob scheduleJob = (ScheduleJob) context.getMergedJobDataMap().get("scheduleJob");
		TaskUtils.invokMethod(scheduleJob);
	}
}