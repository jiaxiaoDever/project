package com.yuhui.core.service.content.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuhui.core.entity.content.ContentBase;
import com.yuhui.core.repository.content.ContentBaseDAO;
import com.yuhui.core.repository.mybatis.BaseRepository;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.service.content.ContentService;

/**
 * 内容管理service实现类
 * 
 * @author zhangy
 * 
 */
@Service(value = "contentService")
public class ContentServiceImpl extends BaseServiceImpl<ContentBase> implements ContentService {

	@Autowired
	private ContentBaseDAO contentBaseDAO;

	@Override
	public BaseRepository<ContentBase> getMybatisDAO() {
		return contentBaseDAO;
	}
}
