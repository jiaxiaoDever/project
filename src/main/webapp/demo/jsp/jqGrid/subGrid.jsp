<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "YHUI.jqGrid" %>
<%
    /*
     *  子表
     *
     *  详细 https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/subGrid.md
     *
     */

    PrintWriter pw = response.getWriter();
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    String id = request.getParameter( "id" );
    Boolean isSubgrid;
    try {
        isSubgrid = request.getParameter( "subgrid" ).equals( "yes" ) ? true : false;
    } catch (Exception e) {
        isSubgrid = false;
    }


    try {
        conn = Mysql.getConnection();
        st = conn.createStatement();
        String sql = "";

        // 判断是第一次加载还是加载子表
        if ( isSubgrid ) {
            sql = "SELECT * FROM fwzl WHERE parent_id='" + id + "'";
        } else {
            sql = "SELECT * FROM fwzl WHERE org_type = 'OT0003' AND name LIKE '%公司'";
        }

        rs = st.executeQuery( sql );
        pw.write( jqGrid.getJson(0, 0, 0, rs) );
        st.close();
        rs.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    Mysql.closeDb( conn );
    pw.close();
%>