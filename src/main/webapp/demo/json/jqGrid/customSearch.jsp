<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "YHUI.jqGrid" %>
<%
    /*
     *  自定义查询，相信应该是用的最多的
     *  传递过来的参数如下：
     *  _search  表示是否是查询，此页专门处理查询，所以没用
     *  id	字段值
     *  nd	发起请求的时间戳
     *  page	页码
     *  rows	一页显示的记录数
     *  sidx    排序列 这里以 id 做为排序列
     *  sord	排序方式 升序还是降序
     */


    int rows = Integer.parseInt(request.getParameter("rows"));
    String sortField = request.getParameter("sidx");
    String sortType = request.getParameter("sord");
    int pageNum = Integer.parseInt( request.getParameter("page") );
    String id = request.getParameter("id");

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

            // 查询时我用到了 LIKE ，当然也可以全等，这个无所谓。
            String selectSql = "SELECT ID, NAME, ORG_TYPE, PARENT_ID, STATE, DESCRIPTION FROM fwzl " +
                            "WHERE id LIKE'%" + id +"%' ORDER BY " +
                            sortField + " " + sortType;


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