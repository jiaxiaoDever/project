<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "com.alibaba.fastjson.JSON" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.HashMap" %>
<%
    int rows = Integer.parseInt(request.getParameter("rowNum"));
    PrintWriter pw = response.getWriter();
    ArrayList res = new ArrayList();


    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    if ( rows > 0 ) {
        String sql = "set rowcount " + rows + " select * from fwzl";
        try {
            conn = Mysql.getConnection();
            st = conn.createStatement();
            rs = st.executeQuery( sql );
            while( rs.next() ) {
                Map row = new HashMap();
                row.put( "id", rs.getString("id") );
                row.put( "name", rs.getString("name") );
                row.put( "date", rs.getString("state_date") );
                row.put( "path", rs.getString("path") );
                res.add( row );
            }
            pw.write( JSON.toJSONString(res) );

        } catch (SQLException e) {
            e.printStackTrace();
        }

        Mysql.closeRs( rs );
        Mysql.closeDb( conn );
        pw.close();
    }
%>