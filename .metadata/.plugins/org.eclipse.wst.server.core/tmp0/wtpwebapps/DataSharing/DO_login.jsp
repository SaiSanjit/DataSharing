<%-- 
    Document   : DO_login
    Created on : Nov 13, 2019, 1:21:52 PM
    Author     : java1
--%>

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
        ResultSet rs = st.executeQuery("SELECT * FROM dataowner where email='" + mail + "' AND password='" + passEncryption  + "' ");
        if (rs.next()) {
            session.setAttribute("doname", rs.getString("Name"));
            session.setAttribute("domail", rs.getString("Email"));
            session.setAttribute("doid", rs.getString("id"));
            session.setAttribute("grp", rs.getString("grp"));
            
            Random RANDOM = new SecureRandom();
        int PASSWORD_LENGTH = 5;
        String letters = "123456789";
        String otp = "";
        for (int i = 0; i < PASSWORD_LENGTH; i++) {
            int index = (int) (RANDOM.nextDouble() * letters.length());
            otp += letters.substring(index, index + 1);
        }
        String DO_OTP = "" + otp;
         int i = sto.executeUpdate("update dataowner set OTP ='"+DO_OTP+"' where email='" +mail+"' " );
            String msggg = "Your OTP for SSGK: " +DO_OTP ;
            Mail ma = new Mail();
            ma.secretMail(msggg, "OTP", mail);
            response.sendRedirect("otp.jsp");
        } else {
            response.sendRedirect("Data_Owner.jsp?Failed");
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
