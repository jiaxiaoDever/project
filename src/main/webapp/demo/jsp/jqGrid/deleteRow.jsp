<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%
    /*
     *  ���Ի�ȡһ�� id ������ɾ���е� id ֵ
     *  ���һ��ɾ�����У���ô id �����Զ��Ÿ�����ֵ
     *  ����һ�� oper ������������ɾ������������ֵΪ del
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