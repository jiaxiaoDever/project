
package com.jiaxiao.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.jiaxiao.entity.TbSysData;
import com.jiaxiao.repository.SysdataDAO;
import com.yuhui.core.base.InitLoader;
import com.yuhui.core.utils.CacheUtils;

public class JxLoader extends InitLoader{
	
	@Autowired
	private SysdataDAO sysdataDAO;
	
	public void init() {
		/*initResourceTree();
		initMenuTree();
		initOrgTree();
		initRolePortlets();
		initContentTypeTree();*/
		initSysData();
	}


	/**
	 * 释放初始化
	 */
	public void destoryContent() {

	}

	/**
	 * 初始化数据字典
	 */
	public void initSysData() {
		List<TbSysData> datas = sysdataDAO.findAll(TbSysData.class);
		Map<String, List<TbSysData>> dataMap = null;
		if(datas != null){
			dataMap = new HashMap<String, List<TbSysData>>();
			for(TbSysData data:datas){
				String key = data.getDataPid();
				if(key != null && !"".equals(key)){
					if(!dataMap.containsKey(key)){
						dataMap.put(key, new ArrayList<TbSysData>());
					}
					dataMap.get(key).add(data);
				}
			}
			CacheUtils.set(Constants.CACHE_SYS_DATA,datas);
			CacheUtils.set(Constants.CACHE_SYS_DATA_MAP,dataMap);
		}
	}
}

