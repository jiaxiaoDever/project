<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "java.util.Map" %>
<%@ page import = "YHUI.jqGrid" %>
<%
    /*
     *  �Զ����ѯ������Ӧ�����õ�����
     *  ���ݹ����Ĳ������£�
     *  _search  ��ʾ�Ƿ��ǲ�ѯ����ҳר�Ŵ����ѯ������û��
     *  id	�ֶ�ֵ
     *  nd	���������ʱ���
     *  page	ҳ��
     *  rows	һҳ��ʾ�ļ�¼��
     *  sidx    ������ ������ id ��Ϊ������
     *  sord	����ʽ �����ǽ���
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

            // ��ѯʱ���õ��� LIKE ����ȻҲ����ȫ�ȣ��������ν��
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