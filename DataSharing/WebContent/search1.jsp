<%-- 
    Document   : search1
    Created on : Nov 20, 2019, 11:38:20 AM
    Author     : java1
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="SSGK.SQLconnection"%>
<%@page import="SSGK.SQLconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
                                        String keyword = request.getParameter("keyword");
                                        String grp = (String) session.getAttribute("mgrp");

                                        System.out.println("keyword --------------------> :" + keyword);
                                        System.out.println("grp --------------------> :" + grp);
                                        Connection con = SQLconnection.getconnection();
                                        Statement st = con.createStatement();
                                        try {

                                            ResultSet rs = st.executeQuery("select * from dofiles where grp='" + grp + "' AND File_Name LIKE '%" + keyword + "%'");
                                            if (rs.next()) {
            response.sendRedirect("searched_files.jsp?" + keyword);
        } else {
            response.sendRedirect("Search.jsp?failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
