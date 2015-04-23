<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "java.util.Map" %>
<%
    /*
     *  除了表格中的几个字段传过来之外，还会有一个
     *  oper  参数，用表示相应的操作，比如编辑记录
     *  oper: edit
     *  当然这里我没有用到
     *  当在同一个页面里面同时处理 新增、删除 等操作的时候，这个字段就很有用了
     *
     *  其实还有一个 id，表示修改的行的 id
     *  但是我这里的字段中有一个 id ，所以合而为一了
     *  详情 https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/编辑之三 行内编辑.md
     */
    Map param = request.getParameterMap();
    PrintWriter o = response.getWriter();
    Connection conn = null;
    PreparedStatement ps;


    String insert = "UPDATE fwzl set name=?, org_type=?, parent_id=?, state=?," +
            " description=? where id=?";
    String id = ((String[]) param.get("id"))[0];
    String name = ((String[])param.get("name"))[0];
    String orgType = ((String[])param.get("org_type"))[0];
    String parentId = ((String[]) param.get("parent_id"))[0];
    String state = ((String[])param.get("state"))[0];
    String description = ((String[])param.get("description"))[0];

    try {
        conn = Mysql.getConnection();
        ps = conn.prepareStatement( insert );
        ps.setString( 6, id );
        ps.setString( 1, name );
        ps.setString( 2, orgType );
        ps.setString( 3, parentId );
        ps.setString( 4, state );
        ps.setString( 5, description );

        if ( ps.executeUpdate() > 0 ) {
            o.print( "success" );
        } else {
            o.print( "error" );
        }
        ps.close();
        conn.close();
    } catch ( SQLException e ) {
        o.print( "error2" );
        e.printStackTrace();
    }

    o.close();
%>