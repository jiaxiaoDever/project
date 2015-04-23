<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "java.util.Map" %>
<%
    /*
     *  ���˱���еļ����ֶδ�����֮�⣬������һ��
     *  oper  �������ñ�ʾ��Ӧ�Ĳ���������༭��¼
     *  oper: edit
     *  ��Ȼ������û���õ�
     *  ����ͬһ��ҳ������ͬʱ���� ������ɾ�� �Ȳ�����ʱ������ֶξͺ�������
     *
     *  ��ʵ����һ�� id����ʾ�޸ĵ��е� id
     *  ������������ֶ�����һ�� id �����Ժ϶�Ϊһ��
     *  ���� https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/�༭֮�� ���ڱ༭.md
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