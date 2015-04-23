package com.yuhui.core.service.content.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuhui.core.entity.content.ContentTypeBase;
import com.yuhui.core.repository.content.ContentTypeBaseDAO;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.service.content.ContentTypeService;

/**
 * 内容分类管理service实现类
 * 
 * @author zhangy
 * 
 */
@Service(value = "contentTypeService")
public class ContentTypeServiceImpl extends BaseServiceImpl<ContentTypeBase> implements ContentTypeService {

	@Autowired
	private ContentTypeBaseDAO contentTypeBaseDAO;

	@Override
	public BaseRepository<ContentTypeBase> getMybatisDAO() {
		return contentTypeBaseDAO;
	}

}
