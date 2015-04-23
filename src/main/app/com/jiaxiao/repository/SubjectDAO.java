package com.jiaxiao.repository;

import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbSubject;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("subjectDAO")
@MyBatisRepository()
public interface SubjectDAO extends BaseRepository<TbSubject> {

}
