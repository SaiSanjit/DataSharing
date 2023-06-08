<%-- 
    Document   : otp1
    Created on : Nov 13, 2019, 6:55:55 PM
    Author     : java1
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="SSGK.SQLconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String votp = request.getParameter("votp");
    String domail = (String)session.getAttribute("domail");
    String status = null;
    System.out.println("Check otp : " + votp);
    System.out.println("Check mail : " + domail);
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
    try {
        ResultSet rs = st.executeQuery("SELECT * FROM dataowner where OTP='" + votp + "' AND Email='" + domail + "'");
        if (rs.next()) {

            response.sendRedirect("DO_Home.jsp?success");
        } else {
            response.sendRedirect("otp.jsp?Wrong");
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
