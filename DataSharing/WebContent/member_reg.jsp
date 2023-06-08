<%-- 
    Document   : DO_signup
    Created on : Nov 13, 2019, 12:40:57 PM
    Author     : java1
--%>

<%@page import="SSGK.TDES"%>
<%@page import="SSGK.SQLconnection"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.util.Random"%>
<%@page import="javax.el.ELException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String name = request.getParameter("name");
    String mail = request.getParameter("email");
    String Group = request.getParameter("group");
    String pass = request.getParameter("password");

    TDES tdes = new TDES();
    String passEncryption = tdes.encrypt(pass);
    System.out.println("passEncryption------------>>            :" + passEncryption);
    DateFormat dateFormat = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss");
    Date date = new Date(); 
    String time = dateFormat.format(date);
    System.out.println("Date and Time : " + time);
    System.out.println("name : " + name);
    Connection conn = SQLconnection.getconnection();
    Statement st = conn.createStatement();
    try {
    int i = st.executeUpdate("insert into member( Name, Email, Password, grp, Time,Statuss )values('" + name + "','" + mail + "','" + passEncryption + "','" + Group + "','" + time + "','Not Active') ");
        if (i != 0) {
            System.out.println("success");
            response.sendRedirect("Member_Home.jsp?success");
        } else {
            System.out.println("Group_Member.jsp?failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>

