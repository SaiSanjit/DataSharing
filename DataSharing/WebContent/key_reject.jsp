<%-- 
    Document   : key_reject
    Created on : Nov 20, 2019, 5:52:24 PM
    Author     : java1
--%>

<%@page import="java.sql.Connection"%>
<%@page import="SSGK.Mail"%>
<%@page import="SSGK.SQLconnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String mid=request.getParameter("mid");
String mail=request.getParameter("email");
String time=request.getParameter("time");

Connection con = null;
    Statement st = null;
    Statement st1 = null;
    Connection conn = SQLconnection.getconnection();
    Statement sto = conn.createStatement();
    st = conn.createStatement();
    
    try {                       
            int i = sto.executeUpdate("update request set statuss='Rejected' where mid='" + mid + "' AND time='"+time+"'" );
           System.out.println("test print==" +mid);
            if (i != 0) {
                ResultSet rs = st.executeQuery(" SELECT * from member where id = '"+mid+"' ");
               if(rs.next()){
                   String name=rs.getString("Name");
                    String msggg= "Hi "+name+" Your Key Request has been Rejected ";                   
                 Mail ma= new Mail();
            ma.secretMail(msggg,"SSGK",mail);          
            String msg= "Sharing Scheme:"+ msggg;                         
                System.out.println("success");
                System.out.println("success");
                response.sendRedirect("Key_Request.jsp?Rejected");
            } else {
               
                System.out.println("failed");
                response.sendRedirect("Key_Request.jsp?Failed");
                 }
                       }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>