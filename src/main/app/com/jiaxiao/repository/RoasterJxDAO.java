package com.jiaxiao.repository;

import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbRoasterJx;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("roasterJxDAO")
@MyBatisRepository()
public interface RoasterJxDAO extends BaseRepository<TbRoasterJx> {

}
