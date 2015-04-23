package com.yuhui.core.repository.content;


import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.content.ContentTypeBase;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

/**
 * 内容DAO
 * @author zhangy
 *
 */
@Repository("contentTypeBaseDAO")
@MyBatisRepository()
public interface ContentTypeBaseDAO extends BaseRepository<ContentTypeBase>{

	
	
}
