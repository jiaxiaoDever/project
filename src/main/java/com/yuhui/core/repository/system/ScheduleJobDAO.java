package com.yuhui.core.repository.system;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.base.ScheduleJob;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("scheduleJobDAO")
@MyBatisRepository()
public interface ScheduleJobDAO {
	int deleteByPrimaryKey(Long jobId);

	int insert(ScheduleJob record);

	int insertSelective(ScheduleJob record);

	ScheduleJob selectByPrimaryKey(Long jobId);

	int updateByPrimaryKeySelective(ScheduleJob record);

	int updateByPrimaryKey(ScheduleJob record);

	List<ScheduleJob> getAll();
}