package com.yuhui.core.entity.util;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

@MappedJdbcTypes({ JdbcType.CHAR })
@MappedTypes({ Boolean.class })
public class StringBooleanTypeHandle extends BaseTypeHandler<Boolean> implements TypeHandler<Boolean> {

	@Override
	public Boolean getNullableResult(ResultSet resultset, String s) throws SQLException {
		return Boolean.parseBoolean(resultset.getString(s));
	}

	@Override
	public Boolean getNullableResult(ResultSet resultset, int i) throws SQLException {
		return Boolean.parseBoolean(resultset.getString(i));
	}

	@Override
	public Boolean getNullableResult(CallableStatement callablestatement, int i) throws SQLException {
		return Boolean.parseBoolean(callablestatement.getString(i));
	}

	@Override
	public void setNonNullParameter(PreparedStatement arg0, int arg1, Boolean arg2, JdbcType arg3) throws SQLException {

	}

	public static void main(String[] args) {
		System.out.println(Boolean.parseBoolean("true"));
	}
}
