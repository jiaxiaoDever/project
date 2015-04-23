package com.yuhui.core.utils.page;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import org.apache.ibatis.executor.ErrorContext;
import org.apache.ibatis.executor.ExecutorException;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ParameterMode;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.factory.ObjectFactory;
import org.apache.ibatis.reflection.property.PropertyTokenizer;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.reflection.wrapper.ObjectWrapperFactory;
import org.apache.ibatis.scripting.xmltags.ForEachSqlNode;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.TypeHandler;
import org.apache.ibatis.type.TypeHandlerRegistry;

/**
 * 分页拦截器
 * @author zhangy 
 * @author xiexiaozhi 改写分页获取分页参数方式，通过方法传递分页参数
 *
 */
@Intercepts({ @Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class }) })
public class PageInterceptor implements Interceptor {
    private static final Log logger = LogFactory.getLog(PageInterceptor.class);
    private static final ObjectFactory DEFAULT_OBJECT_FACTORY = new DefaultObjectFactory();
    private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY = new DefaultObjectWrapperFactory();
    private static String defaultDialect = "ORACLE"; // 数据库类型(默认为oracle)
    private static String defaultPageSqlId = ".*Page$"; // 需要拦截的ID(正则匹配)
    private static String pageSqlId = ""; // 需要拦截的ID(正则匹配)
    private static Dialect.Type databaseType = null ;
    
    @SuppressWarnings({ "rawtypes", "unused" })
	@Override
    public Object intercept(Invocation invocation) throws Throwable {
        StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
        MetaObject metaStatementHandler = MetaObject.forObject(statementHandler, DEFAULT_OBJECT_FACTORY,
                DEFAULT_OBJECT_WRAPPER_FACTORY);
        // 分离代理对象链(由于目标类可能被多个拦截器拦截，从而形成多次代理，通过下面的两次循环可以分离出最原始的的目标类)
        while (metaStatementHandler.hasGetter("h")) {
            Object object = metaStatementHandler.getValue("h");
            metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY);
        }
        
        // 分离最后一个代理对象的目标类
        while (metaStatementHandler.hasGetter("target")) {
            Object object = metaStatementHandler.getValue("target");
            metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY);
        }
        
        Configuration configuration = (Configuration) metaStatementHandler.getValue("delegate.configuration");
        
        String dialect = configuration.getVariables().getProperty("dialect");
        if (null == dialect || "".equals(dialect)) {
            logger.warn("Property dialect is not setted,use default 'oracle' ");
            dialect = defaultDialect;
        }
        //数据库类型
        databaseType = Dialect.Type.valueOf(dialect.toUpperCase()); 
        
        //分页标识，获取sql id的名称
        pageSqlId = configuration.getVariables().getProperty("pageSqlId");
        if (null == pageSqlId || "".equals(pageSqlId)) {
            logger.warn("Property pageSqlId is not setted,use default '.*Page$' ");
            pageSqlId = defaultPageSqlId;
        }
        
        MappedStatement mappedStatement = (MappedStatement) metaStatementHandler.getValue("delegate.mappedStatement");
        
        // 只重写需要分页的sql语句。通过MappedStatement的ID匹配，默认重写以Page结尾的MappedStatement的sql
        if (mappedStatement.getId().matches(pageSqlId)) {
        	
            BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");
            PageParameter page = null;
            Map paramValus = null ;
            //获取DAO方法传来的参数
            Object parameterObject = boundSql.getParameterObject();
//      
//            DynamicSqlSource sqlSource = (DynamicSqlSource) mappedStatement.getSqlSource();
//            
//            
//            String originalSql = sqlSource.getOriginalSql();
            //sqlSource.getBoundSql(arg0)
            
            //只有分页参数情况
            if(parameterObject instanceof PageParameter){
            	
            	page = (PageParameter) parameterObject;
            }
            //多参数的情况，这时parameterObject 是一个MapperMethod的Map类型
            else {
            	
            	
            	Iterator iter = ((Map) parameterObject).entrySet().iterator();
            	while (iter.hasNext()) {
	            	Map.Entry entry = (Map.Entry) iter.next();
	            	Object key = entry.getKey();
	            	Object val = entry.getValue();
	            	if(val instanceof PageParameter){
	            		page = (PageParameter) val;
	            		
	            	}
	            	if(val instanceof Map || val instanceof HashMap){
	            		paramValus = (HashMap) val;
	            		
	            	}
	            	if(page != null && paramValus !=null){
	            		break;
	            	}
            	}
            
            }
            
            //dao调用根本没传分页参数进来，则不进行分页
            if(page == null){
            	return invocation.proceed();
            }
            
            
            if (parameterObject == null) {
                throw new NullPointerException("parameterObject is null!");
            } else {
               
               
                //处理sql参数
                List<ParameterMapping> parameterMappings = boundSql
        				.getParameterMappings();
                if (parameterMappings != null) {
                	for (int i = 0; i < parameterMappings.size(); i++) {
        				ParameterMapping parameterMapping = parameterMappings.get(i);
        				if (parameterMapping.getMode() != ParameterMode.OUT) {
        					String propertyName = parameterMapping.getProperty();
        					Object value = getParamValue(propertyName,paramValus) ;
        					//Object value2 =value;
        					boundSql.setAdditionalParameter(propertyName, value);
//        					if(value instanceof String){//字串类型
//        						value ="'"+(String)value+"'";
//        					}
//        					
//        					String sqlkey ="\\#\\{"+propertyName+"\\}";
//        					Pattern p = Pattern.compile(sqlkey);
//        					Matcher m = p.matcher(originalSql);
//        					 while (m.find()) {
//        				            //strs.add(m.group());  
//        						 originalSql=m.replaceAll((String)value);
//        				        }
//        					//去掉单引号'desc' 'asc'
//        					 String reg="\\'desc||";
        				}
                	}
                }
                String sql = boundSql.getSql();
                // 重写sql
                String pageSql = buildPageSql(sql, page);
               
                metaStatementHandler.setValue("delegate.boundSql.sql", pageSql);
                // 采用物理分页后，就不需要mybatis的内存分页了，所以重置下面的两个参数
                metaStatementHandler.setValue("delegate.rowBounds.offset", RowBounds.NO_ROW_OFFSET);
                metaStatementHandler.setValue("delegate.rowBounds.limit", RowBounds.NO_ROW_LIMIT);
                Connection connection = (Connection) invocation.getArgs()[0];
                // 重设分页参数里的总页数等
                setPageParameter(sql, connection, mappedStatement, boundSql, page);
            }
        }
        // 将执行权交给下一个拦截器
        return invocation.proceed();
    }

    /**
     * 从数据库里查询总的记录数并计算总页数，回写进分页参数<code>PageParameter</code>,这样调用者就可用通过 分页参数
     * <code>PageParameter</code>获得相关信息。
     * 
     * @param sql
     * @param connection
     * @param mappedStatement
     * @param boundSql
     * @param page
     */
    private void setPageParameter(String sql, Connection connection, MappedStatement mappedStatement,
            BoundSql boundSql, PageParameter page) {
        // 记录总记录数
        String countSql = "select count(1) from (" + sql + ") total";
        PreparedStatement countStmt = null;
        ResultSet rs = null;
        try {
            countStmt = connection.prepareStatement(countSql);
            BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(), countSql,
                    boundSql.getParameterMappings(), boundSql.getParameterObject());
            
            setParameters(countStmt, mappedStatement, countBS, boundSql.getParameterObject());
            rs = countStmt.executeQuery();
            int totalCount = 0;
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
            page.setTotalCount(totalCount);
            int totalPage = totalCount / page.getPageSize() + ((totalCount % page.getPageSize() == 0) ? 0 : 1);
            page.setTotalPage(totalPage);

        } catch (SQLException e) {
            logger.error("Ignore this exception", e);
        } finally {
            try {
                rs.close();
            } catch (SQLException e) {
                logger.error("Ignore this exception", e);
            }
            try {
                countStmt.close();
            } catch (SQLException e) {
                logger.error("Ignore this exception", e);
            }
        }

    }
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	private void setParameters(PreparedStatement ps,
			MappedStatement mappedStatement, BoundSql boundSql,
			Object parameterObject) throws SQLException {
		ErrorContext.instance().activity("setting parameters").object(
				mappedStatement.getParameterMap().getId());
		List<ParameterMapping> parameterMappings = boundSql
				.getParameterMappings();
		if (parameterMappings != null) {
			Configuration configuration = mappedStatement.getConfiguration();
			TypeHandlerRegistry typeHandlerRegistry = configuration
					.getTypeHandlerRegistry();
			MetaObject metaObject = parameterObject == null ? null
					: configuration.newMetaObject(parameterObject);
			
			Map paramValus = null ;
			if(metaObject != null){
				Iterator iter = ((Map) metaObject.getOriginalObject()).entrySet().iterator();
				
	        	while (iter.hasNext()) {
	            	Map.Entry entry = (Map.Entry) iter.next();
	            	Object key = entry.getKey();
	            	Object val = entry.getValue();
	            	if(val instanceof Map || val instanceof HashMap){
	            		paramValus = (HashMap) val;
	            		break;
	            	}
	        	}
			}

        	
			for (int i = 0; i < parameterMappings.size(); i++) {
				ParameterMapping parameterMapping = parameterMappings.get(i);
				if (parameterMapping.getMode() != ParameterMode.OUT) {
					Object value;
					String propertyName = parameterMapping.getProperty();
					PropertyTokenizer prop = new PropertyTokenizer(propertyName);
					if (parameterObject == null) {
						value = null;
					} else if (typeHandlerRegistry
							.hasTypeHandler(parameterObject.getClass())) {
						value = parameterObject;
					} else if (boundSql.hasAdditionalParameter(propertyName)) {
						value = boundSql.getAdditionalParameter(propertyName);
					} else if (propertyName
							.startsWith(ForEachSqlNode.ITEM_PREFIX)
							&& boundSql.hasAdditionalParameter(prop.getName())) {
						value = boundSql.getAdditionalParameter(prop.getName());
						if (value != null) {
							value = configuration.newMetaObject(value)
									.getValue(
											propertyName.substring(prop
													.getName().length()));
						}
					} else {
						
						value = getParamValue(propertyName,paramValus) ;
					}
					TypeHandler typeHandler = parameterMapping.getTypeHandler();
					if (typeHandler == null) {
						throw new ExecutorException(
								"There was no TypeHandler found for parameter "
										+ propertyName + " of statement "
										+ mappedStatement.getId());
					}
					typeHandler.setParameter(ps, i + 1, value, parameterMapping
							.getJdbcType());
				}
			}
		}
	}
	
	@SuppressWarnings("rawtypes")
	private Object getParamValue(String key ,Map paramValus){
		if(paramValus == null){
			return null ;
		}
		return paramValus.get(key) ;
	}

    /**
     * 对SQL参数(?)设值
     * 
     * @param ps
     * @param mappedStatement
     * @param boundSql
     * @param parameterObject
     * @throws SQLException
     */
//    private void setParameters(PreparedStatement ps, MappedStatement mappedStatement, BoundSql boundSql,
//            Object parameterObject) throws SQLException {
//        ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
//        parameterHandler.setParameters(ps);
//    }

    /**
     * 根据数据库类型，生成特定的分页sql
     * 
     * @param sql
     * @param page
     * @return
     */
    private String buildPageSql(String sql, PageParameter page) {
    	
    	Dialect dialect = null;  
        switch(databaseType){  
            case ORACLE:  
                dialect = new OracleDialect();  
                break;  
            case MYSQL:
            	dialect = new MySqlDialect();
                break;
            default:
            	dialect = new OracleDialect();
                  
        }
        
        return dialect.getLimitString(sql, page);
    }


    @Override
    public Object plugin(Object target) {
        // 当目标类是StatementHandler类型时，才包装目标类，否者直接返回目标本身,减少目标被代理的次数
        if (target instanceof StatementHandler) {
            return Plugin.wrap(target, this);
        } else {
            return target;
        }
    }

    @Override
    public void setProperties(Properties properties) {
    }

}
