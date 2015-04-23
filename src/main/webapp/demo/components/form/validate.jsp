<%@ page import = "java.io.PrintWriter" %>
<%
    try {
        Thread.sleep( 500 );
    } catch( InterruptedException e ) {
        System.out.println( e.toString() );
    }
    String name = request.getParameter("field7");
    PrintWriter pw = response.getWriter();
    if ( name.equals("yhui") ) {
        pw.write("true");
    } else {
        pw.write("false");
    }
%>