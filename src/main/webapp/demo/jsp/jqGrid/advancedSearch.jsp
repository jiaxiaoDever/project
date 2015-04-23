<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "YHUI.jqGrid" %>
<%
    /*
     *  高阶查询
     *
     *  详情：https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/查询之五 高阶查询.md
     *
     */


    int rows = Integer.parseInt(request.getParameter("rows"));
    String sortField = request.getParameter("sidx");
    String sortType = request.getParameter("sord");
    int pageNum = Integer.parseInt( request.getParameter("page") );
    String filters = request.getParameter("filters");




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

            String condition = jqGrid.advancedSearch( filters );
            String selectSql = "SELECT ID, NAME, ORG_TYPE, PARENT_ID, STATE, DESCRIPTION FROM fwzl " +
                    "WHERE" + condition + "ORDER BY " +
                    sortField + " " + sortType;

            selectSql = new String( selectSql.getBytes("ISO-8859-1"), "utf8" );

            CallableStatement clstmt = conn.prepareCall( sql );
            clstmt.setString("@qry", selectSql);
            clstmt.setInt("@startNum", (pageNum - 1) * rows );
            clstmt.setInt("@limit", rows);
            rs = clstmt.executeQuery();

            pw.write( jqGrid.getJson(pageNum, totalPage, total, rs) );

            clstmt.close();
            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        Mysql.closeDb( conn );
        pw.close();
    }
%>