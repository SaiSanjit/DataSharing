/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SSGK;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author java1
 */
public class Download extends HttpServlet {

    private static Connection getConnection() {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {

            String id = request.getParameter("fid");
            String dkey = request.getParameter("dkey");
            System.out.println("Fileid===" + id);
            HttpSession user = request.getSession();
            String mid = user.getAttribute("mid").toString();
            String mname = user.getAttribute("mname").toString();
            String mmail = user.getAttribute("mmail").toString();



            Connection con = SQLconnection.getconnection();
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            ResultSet rs1 = st2.executeQuery(" Select * from request where mid ='"+mid+"' AND statuss='Approved' AND dkey='"+dkey+"'");
            if (rs1.next()) {

                ResultSet rt = st.executeQuery("select * from dofiles where id = '" + id + "' ");
                if (rt.next()) {
                    String doid = rt.getString("DO_Id");
                    String filename = rt.getString("File_Name");
                    String doname = rt.getString("DO_Name");
                    String fid = rt.getString("id");
                    String file = rt.getString("con");
                    System.out.println("download uid uname fid== " + file + fid);
                    String is = file;


                    response.setHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
                    out.write(is.toString());
                    out.close();
                    int i = st1.executeUpdate("insert into download (mid, mname, filename, time , fid , doname ,doid)values('" + mid + "','" + mname + "','" + filename + "',now(),'" + fid + "','" + doname + "','" + doid + "')");

                    if (i != 0) {
                        response.sendRedirect("requested.jsp?file_Downloaded");
                    } 
                    else 
                    {
                        System.out.println("error  while updating information...");
                    }
                } 
                else 
                {
                    System.out.println("file not found...");
                }
            } 
            else
            {
                response.sendRedirect("Requested.jsp?failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}                 