package com.yuhui.core.repository.common;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.common.SqlColumn;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

@Repository("sqlColumnDAO")
@MyBatisRepository()
public interface SqlColumnDAO {
	public List<SqlColumn> findAllColumns();
}
