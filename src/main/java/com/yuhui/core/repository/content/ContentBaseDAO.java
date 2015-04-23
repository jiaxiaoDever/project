package com.yuhui.core.repository.content;


import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.content.ContentBase;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

/**
 * 内容DAO
 * @author zhangy
 *
 */
@Repository("contentBaseDAO")
@MyBatisRepository()
public interface ContentBaseDAO extends BaseRepository<ContentBase>{

	ContentBase prevRow(@Param(value="parameters")Map<String, Object> paraMap);

	ContentBase nextRow(@Param(value="parameters")Map<String, Object> paraMap);
}
