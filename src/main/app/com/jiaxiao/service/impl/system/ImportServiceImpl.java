package com.jiaxiao.service.impl.system;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jiaxiao.service.system.ImportService;
import com.yuhui.core.repository.mybatis.template.BaseCRUDTemplate;
import com.yuhui.core.service.base.BaseServiceImpl;
import com.yuhui.core.utils.BeanUtils;
import com.yuhui.core.utils.ExcelUtils;

public abstract class ImportServiceImpl<T extends Serializable> extends BaseServiceImpl<T> implements
		ImportService<T> {

	@Transactional(propagation = Propagation.REQUIRED)
	public void importEntity(File excelFile, List<T> successes, List<T> failes,
			List<Map<String, Object>> checkFailes)
			throws FileNotFoundException, IOException {
		List<Map<String,Object>> maps = ExcelUtils.readExcel(excelFile, 2);
		List<T> executeDatas = checkDatas(maps, checkFailes,failes);
		if(executeDatas != null){
			if(successes == null) successes = new ArrayList<T>();
			if(failes == null) failes = new ArrayList<T>();
			for(T entity:executeDatas){
				String idname = BaseCRUDTemplate.getEntityId(entity.getClass());
				int rs = 0;
				try {
					Object id = org.apache.commons.beanutils.BeanUtils.getProperty(entity, idname);
					if(id != null && !"".equals(id.toString())){
						rs = update(entity);
					}else{	
						rs = save(entity);
					}
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				}
				if(rs > 0){
					successes.add(entity);
				}else{
					failes.add(entity);
				}
			}
		}
	}

	public List<T> checkDatas(List<Map<String, Object>> maps,
			List<Map<String, Object>> checkFails, List<T> failes) {
		List<T> checkedDatas = null;
		if(maps != null && maps.size() > 0){
			checkedDatas = new ArrayList<T>();
			if(checkFails == null) checkFails = new ArrayList<Map<String,Object>>();
			for(Map<String, Object> map : maps){
				T entity = null;
				try {
					entity = (T)BeanUtils.mapToBean(getTClass(), map);
				} catch (Exception e) {
					checkFails.add(map);
				}
				if(entity != null && setEntityField(entity)){
					checkedDatas.add(entity);
				}else{					
					failes.add(entity);
				} 
			}
		}
		return checkedDatas;
	}

	public boolean setEntityField(T entity) {
		return true;
	}

	public Class<?> getTClass() throws InstantiationException, IllegalAccessException {
		Type sType = getClass().getGenericSuperclass();
		Type[] generics = ((ParameterizedType) sType).getActualTypeArguments();
		Class<T> mTClass = (Class<T>) (generics[0]);
		return mTClass;
	}
}
