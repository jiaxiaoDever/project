package com.yuhui.core.repository.common;

import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.common.SysEnum;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("sysEnumDAO")
@MyBatisRepository()
public interface SysEnumDAO extends BaseRepository<SysEnum> {
	public void test();
}
