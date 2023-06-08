<%-- 
    Document   : key_approve
    Created on : Nov 20, 2019, 12:07:57 PM
    Author     : java1
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="SSGK.Mail"%>
<%@page import="SSGK.SQLconnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String fid=request.getParameter("fid");
String time=request.getParameter("time");
String mail=request.getParameter("mail");

Connection con = null;
    Statement st = null;
    Statement st1 = null;
    Connection conn = SQLconnection.getconnection();
    Statement sto = conn.createStatement();
    st = conn.createStatement();
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String atime = dateFormat.format(date);
            System.out.println("Date and Time : " + time);
            
    
    try {                       
            int i = sto.executeUpdate("update request set statuss='Approved' where fid='" + fid + "' AND time='"+time+"'" );
           System.out.println("test print==" +fid);
            if (i != 0) {
                ResultSet rs = st.executeQuery(" SELECT * from dofiles where id = '"+fid+"' ");
               if(rs.next()){
                    String dkey = rs.getString("dkey");
                    String fname = rs.getString("File_Name");
                    String msggg="File Name "+fname+" \nDecryption Key: "+dkey+" \n";                   
                 Mail ma= new Mail();
            ma.secretMail(msggg,"Downloadkey",mail);          
            String msg= "File Download Key:"+msggg;                         
                System.out.println("success");
                System.out.println("success");
                response.sendRedirect("Key_Request.jsp?Granted");
            } else {
               
                System.out.println("failed");
                response.sendRedirect("Key_Request.jsp?Failed");
                 }
                       }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>