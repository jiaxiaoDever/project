package com.yuhui.core.repository.system;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.yuhui.core.entity.system.Organization;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.repository.mybatis.MyBatisRepository;
/**
 * 组织DAO
 * @author zhangy
 *
 */
@Repository("organizationDAO")
@MyBatisRepository()
public interface OrganizationDAO extends BaseRepository<Organization> {
	/**
	 * @author 肖长江
	 * @date 2013-10-17
	 * @todo TODO 根据父机构ID查找子机构对象的集合
	 * @param id 父机构ID
	 * @return 返回父机构ID为id的子机构的集合
	 */
	public List<Organization> findByParentId(String id);
}
