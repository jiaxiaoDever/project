package com.jiaxiao.repository;

import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbBaseJx;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("jxDAO")
@MyBatisRepository()
public interface JxDAO extends BaseRepository<TbBaseJx> {

}
