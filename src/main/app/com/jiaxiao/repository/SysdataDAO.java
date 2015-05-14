package com.jiaxiao.repository;

import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbSysData;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("sysdataDAO")
@MyBatisRepository()
public interface SysdataDAO extends BaseRepository<TbSysData> {

}
