<%-- 
    Document   : approve
    Created on : Nov 19, 2019, 4:21:13 PM
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

Connection con = null;
    Statement st = null;
    Statement st1 = null;
    Connection conn = SQLconnection.getconnection();
    Statement sto = conn.createStatement();
    st = conn.createStatement();
    
    try {                       
            int i = sto.executeUpdate("update member set statuss='Active' where id='" + mid + "'" );
           System.out.println("test print==" +mid);
            if (i != 0) {
                ResultSet rs = st.executeQuery(" SELECT * from member where id = '"+mid+"' ");
               if(rs.next()){
                   String name=rs.getString("Name");
                    String msggg= "Hi "+name+" Your account has been verified and Group service are activated ";                   
                 Mail ma= new Mail();
            ma.secretMail(msggg,"Downloadkey",mail);          
            String msg= "File Download Key:"+ msggg;                         
                System.out.println("success");
                System.out.println("success");
                response.sendRedirect("sharing_request.jsp?Granted");
            } else {
               
                System.out.println("failed");
                response.sendRedirect("sharing_request.jsp?Failed");
                 }
                       }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>