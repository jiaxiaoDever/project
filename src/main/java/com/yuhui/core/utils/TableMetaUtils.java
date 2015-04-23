package com.yuhui.core.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp.BasicDataSource;

import com.yuhui.core.entity.common.SqlColumn;
import com.yuhui.core.service.common.CommonService;
import com.yuhui.core.utils.page.Dialect;
import com.yuhui.core.utils.page.Dialect.Type;
/**
 * 
* @ClassName: TableMetaUtils 
* @Description:  获取某个schema下的表的元数据
* @author xiexiaozhi 
* @date 2013-10-28 上午10:27:04 
*
 */
public class TableMetaUtils {

	public List<SqlColumn> getAllColumnsMeta(String dialect,String schema){
		 
		Type DIALECT =Dialect.Type.valueOf(dialect.toUpperCase());
		List<SqlColumn> lsAllColumn = null;
		switch(DIALECT){
		 	case ORACLE: 
		 		CommonService commonService = SpringContextUtils.getBean("commonService");
				lsAllColumn = commonService.findAllColumns();
				break;
		 	case MYSQL:
		 		lsAllColumn = getMysqlTablesMeta(schema);
		 		break;
		 	case POSTGRESQL:
		 		lsAllColumn = getMysqlTablesMeta(schema);
		 		break;
		 	case DB2:
		 		lsAllColumn = getDb2TablesMeta(schema);
		 		break;
		 		
		 }
		return lsAllColumn;
		
	}
	
	private Connection getCon(){
		Connection con = null ;
		BasicDataSource bds = (BasicDataSource)SpringContextUtils.getBean("dataSource");
		try {
			 con= bds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con ;
		
	}
	private List<SqlColumn> getMysqlTablesMeta(String schema){
		Connection conn = getCon();
		String sql= "  select table_name,column_name,data_type from information_schema.columns "+
						"where table_schema ='"+schema+"' "+
					     	"and table_name not in('columns_priv','db','event','events_waits_current','events_waits_history'," +
					     	"'events_waits_summary_by_instance','events_waits_summary_by_thread_by_event_name'," +
					     	"'events_waits_summary_global_by_event_name','events_waits_history_long'," +
					     	"'file_instances','file_summary_by_event_name','file_summary_by_instance'," +
					     	"'func','general_log',"+
					     	" 'help_category','help_keyword','help_relation','help_topic','host','plugin'," +
					     	"'performance_timers','rwlock_instances','setup_consumers','setup_timers'," +
					     	"'setup_instruments','threads','ndb_binlog_index','mutex_instances','cond_instances',"+
					     	"'proc','procs_priv','proxies_priv','servers','slow_log','tables_priv','time_zone',"+
					     	"'time_zone_leap_second','time_zone_name','time_zone_transition',"+
					     	"'time_zone_transition_type','user')"; 
		PreparedStatement stmt = null;
		ResultSet rs = null ;
		List<SqlColumn> list=null ;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		if(rs!=null){
			list = new ArrayList<SqlColumn>();
			try {
				SqlColumn col = null ;
				while(rs.next()){
					col = new SqlColumn();
					col.setColumnName(rs.getString("column_name"));
					col.setTableName(rs.getString("table_name"));
					col.setDataType(rs.getString("data_type"));
					list.add(col);
					
				}
			} catch (SQLException ex) {
				
				ex.printStackTrace();
			}
		}
		
		try {
			if(rs!=null)
				rs.close();
			if(stmt!=null)
				stmt.close();
			if(conn!=null)
				conn.close();
		} catch (SQLException e) {
			
		}
		
		return list;
		
		
		
					 
	}
	
	private List<SqlColumn> getDb2TablesMeta(String schema){
		Connection conn = getCon();
		String sql= "  select tabname,colname,typename,colno from syscat.columns where tabschema= '"+schema+"'" ;
		PreparedStatement stmt = null;
		ResultSet rs = null ;
		List<SqlColumn> list=null ;
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		if(rs!=null){
			list = new ArrayList<SqlColumn>();
			try {
				SqlColumn col = null ;
				while(rs.next()){
					col = new SqlColumn();
					col.setColumnName(rs.getString("colname"));
					col.setTableName(rs.getString("tabname"));
					col.setDataType(rs.getString("typename"));
					list.add(col);
					
				}
			} catch (SQLException ex) {
				
				ex.printStackTrace();
			}
		}
		
		try {
			if(rs!=null)
				rs.close();
			if(stmt!=null)
				stmt.close();
			if(conn!=null)
				conn.close();
		} catch (SQLException e) {
			
		}
		
		return list;
		
		
		
					 
	}
}
