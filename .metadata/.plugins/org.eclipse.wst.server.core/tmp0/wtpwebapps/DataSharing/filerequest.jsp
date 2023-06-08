<%-- 
    Document   : filerequest
    Created on : Nov 20, 2019, 11:46:02 AM
    Author     : java1
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="SSGK.SQLconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String fid = request.getParameter("fid");
    String dkey = request.getParameter("open");
    String mid = (String)session.getAttribute("mid");
    String mname = (String)session.getAttribute("mname");
    String mmail = (String)session.getAttribute("mmail");
    System.out.println(" \n Fid :" + fid + "\n uid:" +mid);
    Connection con = SQLconnection.getconnection();
    Statement st = con.createStatement();
    Statement st1 = con.createStatement();
    try {
        ResultSet rs = st.executeQuery("Select * from dofiles where id ='" + fid + "' ");
        if (rs.next()) {
            String fname = rs.getString("File_Name");
            String doid = rs.getString("DO_Id");
            
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Date date = new Date();
            String time = dateFormat.format(date);
            System.out.println("Date and Time : " + time);
            int i = st1.executeUpdate("INSERT into request(filename, time, mid, mname, statuss, fid, doid, mmail,dkey) values('" + fname + "','" + time + "','" + mid + "','" + mname + "','waiting','" + fid + "', '" + doid+ "','" + mmail+ "','"+dkey+"')");
            if (i != 0) {
                response.sendRedirect("searched_files.jsp?requestsent");
            }
        } else {
            response.sendRedirect("searched_files.jsp?failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
