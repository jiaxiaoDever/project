package com.jiaxiao.service.system;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Serializable;
import java.util.List;
import java.util.Map;



import com.yuhui.core.service.base.BaseService;

public interface ImportService<T extends Serializable> extends BaseService<T>{

	/**
	 * @author 肖长江
	 * @date 2015-6-18
	 * @todo TODO 批量导入实体到数据库
	 * @param excelFile 批量实体的excel文件
	 * @param successOrgs 成功更新的实体集合
	 * @param failOrgs 更新失败的实体集合
	 * @param checkFailOrgs 数据格式不对的实体集合
	 * @throws IOException 
	 * @throws FileNotFoundException 
	 */
	public void importEntity(File excelFile,List<T> successes,List<T> failes,List<Map<String,Object>> checkFailes) throws FileNotFoundException, IOException;
	
	/**
	 * @author 肖长江
	 * @date 2015-6-18
	 * @todo TODO 校验批量导入的组织机构的数据格式是否正确
	 * @param maps 批量导入的组织机构的数据
	 * @param checkFailOrgs 格式不正确的数据集合
	 * @return 返回格式正确的组织机构对象集合
	 */
	public List<T> checkDatas(List<Map<String,Object>> maps,List<Map<String,Object>> checkFails, List<T> failes);
	
	/**
	 * @author 肖长江
	 * @date 2015-11-27
	 * @todo TODO 根据对象值，查询相关属性值并赋予对象
	 * @param entity
	 * @return
	 */
	public boolean setEntityField(T entity);
}
