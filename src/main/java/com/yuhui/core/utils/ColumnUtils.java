package com.yuhui.core.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yuhui.core.entity.common.SqlColumn;
/**
 * 
* @ClassName: ColumnUtils 
* @Description:  处理mybatis与表字段的映射关系
* @author zhangy ,xiexiaozhi 
* @date 2013-10-25 下午3:00:31 
*
 */
public class ColumnUtils {
	private Map<String, SqlColumn> columnMap;
	private Map<String, List<SqlColumn>> tableColumnsMap;
	private static ColumnUtils INSTANCE;

	public static ColumnUtils getInstance() {
		if (null == INSTANCE) {
			INSTANCE = new ColumnUtils();
		}
		return INSTANCE;
	}

	private ColumnUtils() {

	}

	public Map<String, SqlColumn> getColumnMap() {
		if (columnMap != null && !columnMap.isEmpty()) {
			return columnMap;
		}
		columnMap = new HashMap<String, SqlColumn>();
		List<SqlColumn> lsAllColumn = null;
		
		String schema =SqlUtils.getSchema();
		String dialect =SqlUtils.getDialect();
		
		TableMetaUtils tbmeta = new TableMetaUtils();
		lsAllColumn = tbmeta.getAllColumnsMeta(dialect,schema);
		
		
		String mapKey = null;

		for (SqlColumn sqlColumn : lsAllColumn) {
			String taleName =sqlColumn.getTableName().toUpperCase();
			if(!SqlUtils.isExitsSchema(taleName)){
				taleName =schema+"."+taleName;
			}
			mapKey = (taleName + "$" + sqlColumn.getColumnName()).toUpperCase();
			//System.out.println("=========================MapKey:"+mapKey);
			columnMap.put(mapKey, sqlColumn);
			sqlColumn.setDataType(filter(sqlColumn.getDataType()));
		}
		if(lsAllColumn!=null){
			lsAllColumn.clear();
			lsAllColumn = null ;
		}
		return columnMap;
	}

	private String filter(String type) {
		String toType = type;
		if ("NUMBER".equals(type)) {
			toType = "NUMERIC";
		}
		if (type != null && (type.toUpperCase().indexOf("TEXT") > -1)) {
			toType = "LONGVARCHAR";
		}
		toType = toType.replace("2", "");
		return toType;
	}

	public Map<String, List<SqlColumn>> getTableColumnsMap() {
		if (tableColumnsMap != null && !tableColumnsMap.isEmpty()) {
			return tableColumnsMap;
		}
		tableColumnsMap = new HashMap<String, List<SqlColumn>>();
		List<SqlColumn> lsAllColumn = (List<SqlColumn>) getColumnMap().values();
		List<SqlColumn> lsColumn = null;

		for (SqlColumn sqlColumn : lsAllColumn) {
			if (tableColumnsMap.containsKey(sqlColumn.getTableName())) {
				lsColumn = tableColumnsMap.get(sqlColumn.getTableName());
			} else {
				lsColumn = new ArrayList<SqlColumn>();
				tableColumnsMap.put(sqlColumn.getTableName(), lsColumn);
			}
			lsColumn.add(sqlColumn);
		}
		return tableColumnsMap;
	}

	public static List<SqlColumn> getColumnList(String tableName) {
		String tname = tableName.toUpperCase();
		return getInstance().getTableColumnsMap().get(tname);
	}

	public static SqlColumn getColumn(String tableName, String columnName) {
		String tname = tableName.toUpperCase();
		String cname = columnName.toUpperCase();
		//System.out.println("FIND=======================:"+tname + "$" + cname);
		return getInstance().getColumnMap().get(tname + "$" + cname);
	}
}
