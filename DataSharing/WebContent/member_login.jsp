

<%@page import="SSGK.TDES"%>
<%@page import="SSGK.Mail"%>
<%@page import="SSGK.SQLconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String mail = request.getParameter("email");
    String pass = request.getParameter("pass");
    
    TDES tdes = new TDES();
    String passEncryption = tdes.encrypt(pass);
 
    System.out.println("Check User name And Password : " + mail + pass);
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
    Statement sto = con.createStatement();
    try {
        ResultSet rs1 = st.executeQuery("SELECT * FROM member where Email='" + mail + "' AND Password='" + passEncryption+ "'");
        if (rs1.next()) {
            
            String idd = rs1.getString("id");
            ResultSet rs = st.executeQuery("SELECT * FROM member where Email='" + mail + "' AND Password='" + passEncryption+ "' AND Statuss='Active' ");
            if (rs.next()) {
                session.setAttribute("mname", rs.getString("Name"));
                session.setAttribute("mmail", rs.getString("Email"));
                session.setAttribute("mid", rs.getString("id"));
                session.setAttribute("mgrp", rs.getString("grp"));

                response.sendRedirect("Member_Home.jsp");
            } else {
                response.sendRedirect("Group_Member.jsp?not");

            }
        }
        else {
            response.sendRedirect("Group_Member.jsp?failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
