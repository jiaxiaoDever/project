<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "YHUI.jqGrid" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.sql.Statement" %>
<%
    /*
     *  表格联动
     *
     *
     *
     */

    PrintWriter pw = response.getWriter();
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    Boolean isSubgrid;
    String supId = "";
    try {
        isSubgrid = request.getParameter( "subgrid" ).equals( "yes" ) ? true : false;
        supId = request.getParameter( "supId");
    } catch (Exception e) {
        isSubgrid = false;
    }


    try {
        conn = Mysql.getConnection();
        st = conn.createStatement();
        String sql = "";


        if ( isSubgrid ) {
            sql = "SELECT * FROM fwzl WHERE parent_id='" + supId + "'";
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