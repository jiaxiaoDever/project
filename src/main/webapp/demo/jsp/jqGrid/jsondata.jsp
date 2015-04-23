<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import="YHUI.jqGrid" %>
<%@ page import = "java.util.Map" %>
<%--
    区别于本地数据，json 数据有其固定的格式。
    {
        "total": "xxx",
        "page": "yyy",
        "records": "zzz",
        "rows" : [
            {"id" :"1", "cell" :["cell11", "cell12", "cell13"]},
            {"id" :"2", "cell":["cell21", "cell22", "cell23"]},
            ...
        ]
    }
    详细 https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/组织数据.md 。
--%>
<%
    int rows = Integer.parseInt( request.getParameter("rows") );
    String sortField = request.getParameter("sidx");
    String sortType = request.getParameter("sord");
    int pageNum = Integer.parseInt( request.getParameter("page") );
    Boolean isSearch = request.getParameter("_search").equals("true") ? true : false;

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

            /*
             * isSearch 是判断是否为查询
             * 本页包含对 filterToolbar 的处理
             */

            if ( isSearch ) {
                Map param = request.getParameterMap();
                String[] paramFields = { "id", "name", "org_type", "parent_id", "state" };
                String Sql = "";

                for ( int i = 0; i < paramFields.length; i++ ) {
                    if ( param.get(paramFields[i]) != null ) {
                        String field = ( (String[]) param.get(paramFields[i]) )[0];
                        if ( !field.equals("") ) {
                            Sql = Sql + paramFields[i] + " LIKE '%" + field + "%' " + "AND ";
                        }
                    }
                }

                if ( !Sql.equals("") ) {
                    Sql = Sql.substring( 0, Sql.length() - 4 );
                    Sql = new String( Sql.getBytes("ISO-8859-1"), "utf8" );
                    selectSql = "SELECT ID, NAME, ORG_TYPE, PARENT_ID, STATE, DESCRIPTION FROM fwzl WHERE "
                        + Sql
                        + "ORDER BY " + sortField + " " + sortType;
                } else {
                    selectSql = "SELECT ID, NAME, ORG_TYPE, PARENT_ID, STATE, DESCRIPTION FROM fwzl ORDER BY " +
                            sortField + " " + sortType;
                }
            } else {
                selectSql = "SELECT ID, NAME, ORG_TYPE, PARENT_ID, STATE, DESCRIPTION FROM fwzl ORDER BY " +
                        sortField + " " + sortType;
            }

            CallableStatement clstmt = conn.prepareCall( sql );
            clstmt.setString("@qry", selectSql);
            clstmt.setInt("@startNum", (pageNum - 1) * rows );
            clstmt.setInt("@limit", rows);
            rs = clstmt.executeQuery();

            pw.write( jqGrid.getJson( pageNum, totalPage, total, rs ) );

            clstmt.close();
            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        Mysql.closeDb( conn );
        pw.close();

    }
%>