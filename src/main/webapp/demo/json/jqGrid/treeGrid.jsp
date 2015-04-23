<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "YHUI.Mysql" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.alibaba.fastjson.JSON" %>
<%
    /*
     *  树形表格
     *  接收参数：
     *  nodeid      其实就是展开行的 id
     *  parentid    展开行的父 id
     *  n_level     层级
     *
     *  详细 https://github.com/jiangyuan/playjs/blob/master/docOfjqGrid/treeGrid.md
     *
     */
    ArrayList<String> leaves;
    if ( session.getAttribute( "leaves" ) == null ) {
        leaves = null;
    } else {
        leaves = (ArrayList<String>) session.getAttribute( "leaves" );
    }

    PrintWriter pw = response.getWriter();
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        conn = Mysql.getConnection();
        st = conn.createStatement();

        // 拿到叶子节点的列表
        if ( leaves == null ) {
            String getLeaves = "SELECT t1.id FROM fwzl AS t1 LEFT JOIN fwzl" +
                    " as t2 ON t1.id = t2.parent_id WHERE t2.id IS NULL";
            leaves = new ArrayList<String>();
            rs = st.executeQuery( getLeaves );
            while( rs.next() ) {
                leaves.add( rs.getString("id") );
            }
            session.setAttribute("leaves", leaves); // 绑定到 session scope 避免频繁查询数据库
            rs.close();
        }

        String nodeId = request.getParameter( "nodeid" );
        String parendId = request.getParameter( "parentid" );
        String l = request.getParameter( "n_level" );

        int level = 0;
        if ( l != null ) {
            level =+ 1;
        }

        String sql = "SELECT * FROM fwzl WHERE org_type = 'OT0003' AND name LIKE '%公司'";
        if ( parendId != null ) {
            sql = " SELECT * FROM fwzl WHERE parent_id='" + nodeId + "'";
        }

        rs = st.executeQuery( sql );

        Map ret = new HashMap();
        ArrayList rows = new ArrayList();

        ret.put( "page", 1 );
        ret.put( "recodes", 1 );
        ret.put( "total", 1 );

        while ( rs.next() ) {
            Map row = new HashMap();
            ArrayList cell = new ArrayList();
            String iD = rs.getString( "ID" );
            String pId = rs.getString("PARENT_ID");
            cell.add( iD );
            cell.add( rs.getString("NAME") );
            cell.add( rs.getString("ORG_TYPE") );
            cell.add( pId );
            cell.add( rs.getString("STATE") );
            cell.add( rs.getString("DESCRIPTION") );

            Boolean isLeaf = false;
            if ( iD != null ) {
                for ( int i = 0; i < leaves.size(); i++ ) {
                    if ( iD.equals(leaves.get(i)) ) {
                        isLeaf = true;
                        break;
                    }
                }
            }
            cell.add( level );      // level
            cell.add( pId );        // parent id
            cell.add( isLeaf );     // isLeaf ?
            cell.add( false );     // expand ??


            row.put( "id", iD );
            row.put( "cell", cell );
            rows.add( row );
        }

        ret.put( "rows", rows );

        pw.write( JSON.toJSONString(ret) );
        st.close();
        rs.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    Mysql.closeDb( conn );
    pw.close();
%>