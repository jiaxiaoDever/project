package com.jiaxiao.repository;

import org.springframework.stereotype.Repository;

import com.jiaxiao.entity.TbBranchesJx;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("branchesJxDAO")
@MyBatisRepository()
public interface BranchesJxDAO extends BaseRepository<TbBranchesJx> {

}
