/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author gohan
 */

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class clsUsuario {
    
    private String usuario;
    private String contrasena;
    private String nombre;
    private String apellidoMaterno;
    private String apellidoPaterno;
    private String fechaNacimiento;
    private String carrera;
    private String Ncontrol;

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
    public void setNcontrol(String Ncontrol) {
        this.Ncontrol = Ncontrol;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getUsuario() {
        return usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellidoMaterno() {
        return apellidoMaterno;
    }

    public String getApellidoPaterno() {
        return apellidoPaterno;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public String getCarrera() {
        return carrera;
    }
    
    public String getNcontrol() {
        return Ncontrol;
    }
    
    public clsUsuario(){
    }
    
    public clsUsuario(String usuario, String contrasena){
        this.usuario=usuario;
        this.contrasena=contrasena;
    }
    
    //Definición de objetos de datos
    private Connection cnn;
    private Statement st;
    private String consultaSQL="";
    private ResultSet rs;
    //Métodos de conexión a Mysql
    public Connection conexion(){
        try{
            //Para driver 5.1.
            //Class.forName("com.mysql.jdbc.Driver");
            //cnn = (Connection) DriverManager.
            //     getConnection("jdbc:mysql://localhost/control_acceso","root","12345");
            //System.out.println("Conexion a BD exitosa!");
            //PAra driver 8.0.x
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.cnn=(Connection) DriverManager.
                   getConnection ("jdbc:mysql://localhost:3306/das_proyecto?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8&useSSL=false","root","123456789");
            
            System.out.println("Conexion a BD exitosa!");
        }
        catch(ClassNotFoundException | SQLException ex){
            System.out.println("Error: " + ex.getMessage());
        }
        return cnn;
    }

    // CREAR EL METODO PARA MONITOREO DEL STATEMENT
    Statement createStatement(){
        throw new UnsupportedOperationException
                                ("No se soporte una conexión BD");
    }
        //método para validación del acceso a usuarios
        public ResultSet validarAcceso()throws SQLException{
            consultaSQL="call spValidarIngreso('"+
                    this.usuario+"','"+
                    this.contrasena+ "');";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
        /*
        // Metodo para ejecución de vista vw_rptusuario
        public ResultSet vw_rptUsuario()throws SQLException{
            consultaSQL="select* from vw_rptusuario;";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }*/
    public ResultSet Tabla(String Categoria)throws SQLException{
            consultaSQL="select * from vw_ItemsDisponibles WHERE LOCATE('"+Categoria+"', Categoria)>0;";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    //método para validación del acceso a usuarios
    public ResultSet RegistrarUsuario(String Ncontrol, String nombre, String paterno, String materno, String fecha, String usuario, String contrasena, String carrera)throws SQLException{
            consultaSQL="call spInsUsuario('"+Ncontrol+"', '"+nombre+"', '"+paterno+"', '"+materno+"', '"+fecha+"', '"+usuario+"', '"+contrasena+"', '"+carrera+"');";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    public ResultSet RegistrarItem(String descripcion, String tipo, String estado, String categoria, String Ncontrol)throws SQLException{
            consultaSQL="call spInsItem('"+descripcion+"', '"+tipo+"', '"+estado+"', '"+categoria+"', '"+Ncontrol+"');";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    public ResultSet getNombreC(String id)throws SQLException{
            consultaSQL="select concat(usu_nombre,' ', usu_ape_paterno,' ', usu_ape_materno) as nombre from usuario where usu_cve_usuario = '"+id+"';";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    public ResultSet getNombteItem(String id)throws SQLException{
            consultaSQL="select Descripcion from vw_ItemsDisponibles where Clave = "+id+";";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    public ResultSet Prestamo(String prestamista, String item, String solicitante, String inicio, String lugar, String hora)throws SQLException{
            consultaSQL="call spInsprestamo ('"+prestamista+"','"+item+"', '"+solicitante+"', '"+inicio+"', null, '"+lugar+"', '"+hora+"','En prestamo'); ";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    public ResultSet ListaItems(String id)throws SQLException{
            consultaSQL="call das_proyecto.listItemsPropios("+id+");";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    public ResultSet ListaPrestamos(String id)throws SQLException{
            consultaSQL="call das_proyecto.listItemsPrestados("+id+");";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
    public ResultSet Devolver(String id)throws SQLException{
            consultaSQL="call spDevolucion ('"+id+"');";
            
            //Construir la sentencia de ejecución (Statement)
            st=(Statement)cnn.createStatement();
            rs=st.executeQuery(consultaSQL);
            return rs;
        }
}
