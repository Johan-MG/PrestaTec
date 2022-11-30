/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.clsUsuario;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;

/**
 *
 * @author gohan
 */
public class srvPrestamo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String prestamista=validarString(request.getParameter("txtIdPrestamista"));
        String item=validarString(request.getParameter("txtIdProducto"));
        String solicitante=validarString(request.getParameter("txtIdSolicitante"));
        String inicio=validarString(request.getParameter("txtFecha"));
        String lugar=validarString(request.getParameter("txtLugar"));
        String hora=validarString(request.getParameter("txtHora"));
        
        if(!prestamista.equals("") &&
               !item.equals("") &&
               !solicitante.equals("") &&
               !inicio.equals("") &&
               !lugar.equals("") &&
               !hora.equals("")){
            try{
                clsUsuario obj = new clsUsuario();
                Connection cnn = obj.conexion();
                ResultSet rs = obj.Prestamo(prestamista, item, solicitante, inicio, lugar, hora);
                rs.next();
                switch(rs.getString(1)){
                    case "0":
                        request.getRequestDispatcher("srvPrestamos").forward(request, response);
                        break;
                    case "1":
                        request.getSession().setAttribute("errorCode", "1");
                        request.getRequestDispatcher("Loan.jsp").forward(request, response);
                        break;
                    case "2":
                        request.getSession().setAttribute("errorCode", "2");
                        request.getRequestDispatcher("Loan.jsp").forward(request, response);
                        break;
                    case "3":
                        request.getSession().setAttribute("errorCode", "3");
                        request.getRequestDispatcher("Loan.jsp").forward(request, response);
                        break;
                    case "4":
                        request.getSession().setAttribute("errorCode", "4");
                        request.getRequestDispatcher("Loan.jsp").forward(request, response);
                        break;
                        
                }
            }catch(SQLException ex){
                request.getSession().setAttribute("errorCode", "5");
                request.getRequestDispatcher("Loan.jsp").forward(request, response);
            }
        }else{
            request.getSession().setAttribute("errorCode", "6");
            request.getRequestDispatcher("Loan.jsp").forward(request, response);
        }
    }

    private String validarString(String cad){
        if(cad != null){
            return cad;
        }else{
            return "";
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
     * Handles the HTTP <code>POST</code> method.
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
