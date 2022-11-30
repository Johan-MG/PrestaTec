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
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author gohan
 */
public class srvLogin extends HttpServlet {

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
        try{
            //Recepción de parámetros de la vista Acceso
            String usuario=request.getParameter("txtUsuario");
            String contrasena=request.getParameter("txtContrasena");
            //Validación general de null + cadena vacia
            if(usuario!=null && !usuario.equals("") && contrasena !=null && !contrasena.equals("")){
                //Creacion del objeto clsUSuario
                clsUsuario objeto=new clsUsuario(usuario, contrasena);
                //Conexion a Mysql
                Connection cnnSrv= objeto.conexion();
                //Ejecutar el metodo del acceso
                ResultSet rsSrv= objeto.validarAcceso();
                //Validacion de los datos recibidos
               String bandera="";
               while(rsSrv.next()){
                   bandera=rsSrv.getString(1);
                   //Obtencion de los demas datos
                   if(bandera.equals("0")){
                       objeto.setNcontrol(rsSrv.getString(2));
                       objeto.setNombre(rsSrv.getString(3));
                       objeto.setApellidoPaterno(rsSrv.getString(4));
                       objeto.setApellidoMaterno(rsSrv.getString(5));
                       objeto.setUsuario(rsSrv.getString(6));
                       
                   }
                      
               }
               rsSrv.close();
               if(bandera.equals("0")){
                   //Generación de las variables de sesion del usuario
                   request.getSession().setAttribute("usuApellidoPaterno", objeto.getApellidoPaterno());
                   request.getSession().setAttribute("usuApellidoMaterno", objeto.getApellidoMaterno());
                   request.getSession().setAttribute("usuNombre", objeto.getNombre());
                   request.getSession().setAttribute("usuUsuario", objeto.getUsuario());
                   request.getSession().setAttribute("usuNcontrol", objeto.getNcontrol());
                   
                   
                   
                   //request.getSession().setAttribute("objUsuario", objeto);
                   request.getRequestDispatcher("Principal.jsp").forward(request, response);
               }
               else{
                   //Eliminar las variables de sesión
                   request.getSession().setAttribute("usuApellidoPaterno", null);
                   request.getSession().setAttribute("usuApellidoMaterno", null);
                   request.getSession().setAttribute("usuNombre", null);
                   request.getSession().setAttribute("usuUsuario", null);
                   request.getSession().setAttribute("usuNcontrol", null);
                   
                   request.getSession().setAttribute("errorCode", "1");
                   request.getRequestDispatcher("Login.jsp").forward(request, response);
               }

            }
            else{
                   request.getSession().setAttribute("errorCode", "2");
                   request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        }
        catch(SQLException ex){
                   request.getSession().setAttribute("errorCode", "3");
                   request.getRequestDispatcher("Login.jsp").forward(request, response);
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
