<%@ page import = "java.io.PrintWriter" %>
<%
    try {
        Thread.sleep( 1000 );
    } catch( InterruptedException e ) {
        System.out.println( e.toString() );
    }
    String name = request.getParameter("field8");
    PrintWriter pw = response.getWriter();
    if ( name.equals("yhui2") ) {
        pw.write("true");
    } else {
        pw.write("false");
    }
%>