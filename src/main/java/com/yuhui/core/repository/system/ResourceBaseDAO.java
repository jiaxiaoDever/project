package com.yuhui.core.repository.system;

import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.system.ResourceBase;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;

/**
 * 资源DAO
 * @author zhangy
 *
 */
@Repository("resourceBaseDAO")
@MyBatisRepository()
public interface ResourceBaseDAO extends BaseRepository<ResourceBase> {
	
}
