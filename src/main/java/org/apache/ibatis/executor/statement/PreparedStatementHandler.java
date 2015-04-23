/*
 *    Copyright 2009-2012 The MyBatis Team
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package org.apache.ibatis.executor.statement;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;


import org.apache.commons.lang3.time.StopWatch;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.keygen.Jdbc3KeyGenerator;
import org.apache.ibatis.executor.keygen.KeyGenerator;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 * 
* @ClassName: PreparedStatementHandler 
* @Description:  重写mybatis的执行sql类，以便进行日志记录
* @author xiexiaozhi 
* @date 2013-10-16 上午10:55:30 
*
 */
public class PreparedStatementHandler extends BaseStatementHandler {

	private static Logger log = LoggerFactory.getLogger(PreparedStatementHandler.class);
	private static final String hostIp = getIpAddress();
	
  public PreparedStatementHandler(Executor executor, MappedStatement mappedStatement, Object parameter, RowBounds rowBounds, ResultHandler resultHandler, BoundSql boundSql) {
    super(executor, mappedStatement, parameter, rowBounds, resultHandler, boundSql);
  }

  public int update(Statement statement) throws SQLException {
	  StopWatch clock = new StopWatch();  
      clock.start(); //计时开始  
      String sql = boundSql.getSql() ;
      sql=sql.replace("\n", "");
    PreparedStatement ps = (PreparedStatement) statement;
    
    ps.execute();
    int rows = ps.getUpdateCount();
    Object parameterObject = boundSql.getParameterObject();
    KeyGenerator keyGenerator = mappedStatement.getKeyGenerator();
    keyGenerator.processAfter(executor, mappedStatement, ps, parameterObject);
    clock.stop();  //计时结束  
    StringBuffer sb = new StringBuffer();
    //System.out.println("~~~~~~~~~~~"+Thread.currentThread().getName());
	sb.append("{");
	sb.append("HOST:").append(hostIp).append(",");
	sb.append("THREAD_ID:").append(Thread.currentThread().getName()).append(",");
	sb.append("CLASS:").append(PreparedStatementHandler.class.getName()).append(",");
	sb.append("METHOD:").append("update").append(",");
	sb.append("ARGS:").append("").append(",");
	sb.append("TAKES:").append(clock.getTime()).append("ms").append(",");
	sb.append("DESC:").append(sql);
	sb.append("}");
	log.info(sb.toString());
    
    return rows;
  }

  public void batch(Statement statement) throws SQLException {
	  StopWatch clock = new StopWatch();  
      clock.start(); //计时开始  
      String sql = boundSql.getSql() ;
      sql=sql.replace("\n", "");
    PreparedStatement ps = (PreparedStatement) statement;
    ps.addBatch();
    clock.stop();  //计时结束  
    StringBuffer sb = new StringBuffer();
	sb.append("{");
	sb.append("HOST:").append(hostIp).append(",");
	sb.append("THREAD_ID:").append(Thread.currentThread().getName()).append(",");
	sb.append("CLASS:").append(PreparedStatementHandler.class.getName()).append(",");
	sb.append("METHOD:").append("batch").append(",");
	sb.append("ARGS:").append("").append(",");
	sb.append("TAKES:").append(clock.getTime()).append("ms").append(",");
	sb.append("DESC:").append(sql);
	sb.append("}");
	log.info(sb.toString());
  }

  public <E> List<E> query(Statement statement, ResultHandler resultHandler) throws SQLException {
	  StopWatch clock = new StopWatch();  
      clock.start(); //计时开始  
      String sql = boundSql.getSql() ;
      sql=sql.replace("\n", "");
    PreparedStatement ps = (PreparedStatement) statement;
    ps.execute();
    clock.stop();  //计时结束  
    StringBuffer sb = new StringBuffer();
	sb.append("{");
	sb.append("HOST:").append(hostIp).append(",");
	sb.append("THREAD_ID:").append(Thread.currentThread().getName()).append(",");
	sb.append("CLASS:").append(PreparedStatementHandler.class.getName()).append(",");
	sb.append("METHOD:").append("query").append(",");
	sb.append("ARGS:").append("").append(",");
	sb.append("TAKES:").append(clock.getTime()).append("ms").append(",");
	sb.append("DESC:").append(sql);
	sb.append("}");
	log.info(sb.toString());
    return resultSetHandler.<E> handleResultSets(ps);
  }

  protected Statement instantiateStatement(Connection connection) throws SQLException {
    String sql = boundSql.getSql();
    if (mappedStatement.getKeyGenerator() instanceof Jdbc3KeyGenerator) {
      String[] keyColumnNames = mappedStatement.getKeyColumns();
      if (keyColumnNames == null) {
        return connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
      } else {
        return connection.prepareStatement(sql, keyColumnNames);
      }
    } else if (mappedStatement.getResultSetType() != null) {
      return connection.prepareStatement(sql, mappedStatement.getResultSetType().getValue(), ResultSet.CONCUR_READ_ONLY);
    } else {
      return connection.prepareStatement(sql);
    }
  }

  public void parameterize(Statement statement) throws SQLException {
    parameterHandler.setParameters((PreparedStatement) statement);
  }
  
  private static String getIpAddress()  {  
      InetAddress address;
      String add ="";
		try {
			address = InetAddress.getLocalHost();
			add = address.getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}  

      return add;  
  }
  

}
