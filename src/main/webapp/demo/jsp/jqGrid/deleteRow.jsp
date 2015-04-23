<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%
    /*
     *  可以获取一个 id ，就是删除行的 id 值
     *  如果一次删除多行，那么 id 就是以逗号隔开的值
     *  还有一个 oper 参数，这里是删除操作，所以值为 del
     */

    PrintWriter o = response.getWriter();
    String id = request.getParameter( "id" );
    Connection conn = null;
    PreparedStatement ps;
    String delete;



    if ( id.indexOf("'") < 0 ) {
        delete = "DELETE FROM fwzl WHERE id='" + id + "'";
    } else {
        delete = "DELETE FROM fwzl WHERE id in (" + id + ")";
    }


    try {
        conn = Mysql.getConnection();
        ps = conn.prepareStatement( delete );

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