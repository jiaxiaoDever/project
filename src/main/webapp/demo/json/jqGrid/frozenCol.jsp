<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "com.alibaba.fastjson.JSON" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "java.util.HashMap" %>
<%@ page import = "java.util.ArrayList" %>
<%--
    冻结列的组织数据没有什么特别的
--%>
<%
    int rows = Integer.parseInt( request.getParameter("rows") );
    String sortField = request.getParameter("sidx");
    String sortType = request.getParameter("sord");
    int pageNum = Integer.parseInt( request.getParameter("page") );

    int total = 0, totalPage = 0;

    PrintWriter pw = response.getWriter();
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    if ( rows > 0 ) {

        try {
            conn = Mysql.getConnection();
            st = conn.createStatement();

            String getCountSql = "select count(*) from fwzl";
            rs = st.executeQuery( getCountSql );

            if ( rs.next() ) {
                total = rs.getInt(1);
            }

            if ( total > 0 ) {
                totalPage = (int)Math.ceil( total/rows );
            }

            if ( pageNum > totalPage ) {
                pageNum = totalPage;
            }

            st.close();
            rs.close();


            String sql = "{call GetDataByPageEoms(?, ?, ?)}";
            if ( sortField.equals("") ) {
                sortField = "id";
            }

            String selectSql = "";

            selectSql = "SELECT * FROM fwzl ORDER BY " +
                    sortField + " " + sortType;

            CallableStatement clstmt = conn.prepareCall( sql );
            clstmt.setString("@qry", selectSql);
            clstmt.setInt("@startNum", (pageNum - 1) * rows );
            clstmt.setInt("@limit", rows);
            rs = clstmt.executeQuery();

            /*pw.write( jqGrid.getJson( pageNum, totalPage, total, rs ) );*/

            Map ret = new HashMap();
            ArrayList retRows = new ArrayList();

            ret.put( "page", pageNum );
            ret.put( "total", totalPage );
            ret.put( "records", total );

            while( rs.next() ) {
                Map row = new HashMap();
                ArrayList cell = new ArrayList();

                /*cell.add( id );
                cell.add( rs.getString("NAME") );
                cell.add( rs.getString("ORG_TYPE") );
                cell.add( rs.getString("PARENT_ID") );
                cell.add( rs.getString("STATE") );
                cell.add( rs.getString("DESCRIPTION") );*/
                for ( int i = 3; i < 11; i++ ) {
                    cell.add( rs.getString(i) );
                }

                row.put( "id", rs.getString("ID") );
                row.put( "cell", cell );
                retRows.add( row );
            }
            ret.put( "rows", retRows );

            pw.write( JSON.toJSONString(ret) );

            clstmt.close();
            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        Mysql.closeDb( conn );
        pw.close();

    }
%>