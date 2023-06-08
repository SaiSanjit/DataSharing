<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="SSGK.SQLconnection"%>
<%
    String fid = request.getParameter("id");
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
try {
  int i= st.executeUpdate(" DELETE from dofiles where id='"+fid+"' ");
    if(i!=0) {
        response.sendRedirect("Files.jsp?Deleted");
        
    }
       else{
       response.sendRedirect("Files.jsp?Failed");
       }
  
} catch(Exception ex) {
    ex.printStackTrace();
}
%>
