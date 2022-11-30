<%-- 
    Document   : Registro
    Created on : 29 nov. 2022, 12:45:01
    Author     : gohan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%
    String mensaje = "";
    if(request.getSession().getAttribute("errorCode") != null){
        mensaje += "<div class='text-danger'>";
        if(request.getSession().getAttribute("errorCode").equals("1"))
            mensaje += " * Campos vacios. </div>";
        if(request.getSession().getAttribute("errorCode").equals("2"))
            mensaje += " * Error con la base de datos. </div>";
        request.getSession().setAttribute("errorCode", null);
    }
%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <title>Crear cuenta</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
   

    <!-- Favicon -->
    <link href="favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Topbar Start -->
    <div class="container-fluid bg-dark">
        <div class="row py-2 px-lg-5">
            <div class="col-lg-6 text-center text-lg-left mb-2 mb-lg-0">
                <div class="d-inline-flex align-items-center text-white">
                    <small><i class="fa fa-phone-alt mr-2"></i>7713099375</small>
                    <small class="px-3">|</small>
                    <small><i class="fa fa-envelope mr-2"></i>prestatec2022@gmail.com</small>
                </div>
            </div>
            <div class="col-lg-6 text-center text-lg-right">
                <div class="d-inline-flex align-items-center">
                    <a class="text-white px-2" href="">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a class="text-white px-2" href="">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a class="text-white px-2" href="">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a class="text-white px-2" href="">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a class="text-white pl-2" href="">
                        <i class="fab fa-youtube"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Topbar End -->


    <!-- Navbar Start -->
    <div class="container-fluid p-0">
        <nav class="navbar navbar-expand-lg bg-white navbar-light py-3 py-lg-0 px-lg-5">
            <a href="Principal.jsp" class="navbar-brand ml-lg-3">
                <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-book-reader mr-3"></i>PrestaTec</h1>
            </a>
            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-between px-lg-3" id="navbarCollapse">
                <div class="navbar-nav mx-auto py-0">
                    <a href="Principal.jsp" class="nav-item nav-link active">Inicio</a>
                    <a href="about.html" class="nav-item nav-link">Acerca de</a>
                    <a href="contact.html" class="nav-item nav-link">Contacto</a>
                    
                </div>
                
                <a href="Login.jsp" class="btn btn-primary py-2 px-4 d-none d-lg-block">Iniciar Sesion</a>
                <small class="px-2"></small>
                
            </div>
        </nav>
    </div>
    <!-- Navbar End -->



    <!-- Form start -->
    <div class="row justify-content-center bg-white mx-0 mb-5">
        <div class="col-lg-6 py-5">
            <div class="row justify-content-center bg-image p-5 my-5">
                <h1 class="text-center mb-4">Crea una cuenta</h1>
                <form id="frmRegistro" method="POST" action="srvRegistro">
                    <div class="form-row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input name="txtControl" type="text" class="form-control bg-light border-0" placeholder="No. de control" style="padding: 30px 20px;">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input name="txtNombre" type="text" class="form-control bg-light border-0" placeholder="Nombre" style="padding: 30px 20px;">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input name="txtPaterno" type="text" class="form-control bg-light border-0" placeholder="Apellido paterno" style="padding: 30px 20px;">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input name="txtMaterno" type="text" class="form-control bg-light border-0" placeholder="Apellido materno" style="padding: 30px 20px;">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <abbr title="Fecha de nacimiento"><input name="txtFechaN"  type="date" class="form-control bg-light border-0" placeholder="Fecha de nacimiento" style="padding: 30px 20px;"></abbr>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <select name="txtCarrera" class="custom-select bg-light border-0 px-3" style="height: 60px;">
                                    <option selected>Carrera</option>
                                    <option value="Ing. Diseño Industrial">Ing. Diseño Industrial</option>
                                    <option value="Ing. Civil">Ing. Civil</option>
                                    <option value="Ing. Eléctrica">Ing. Eléctrica</option>
                                    <option value="Ing. Industrial">Ing. Industrial</option>
                                    <option value="Ing. Mecánica">Ing. Mecánica</option>
                                    <option value="Ing. Química">Ing. Química</option>
                                    <option value="Ing. Sistemas Computacionales">Ing. Sistemas Computacionales</option>
                                    <option value="Ing. ITIC’s">Ing. ITIC’s</option>
                                    <option value="Ing. Gestión Empresarial">Ing. Gestión Empresarial</option>
                                    <option value="Lic. Arquitectura">Lic. Arquitectura</option>
                                    <option value="Lic. Administración">Lic. Administración</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input name="txtUsuario" type="text" class="form-control bg-light border-0" placeholder="Nombre de usuario" style="padding: 30px 20px;">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <input name="txtContrasena" type="password" class="form-control bg-light border-0" placeholder="Contraseña" style="padding: 30px 20px;">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-sm-6">
                            
                        </div>
                        <div class="container text-center justify-content-center">
                            <button class="btn btn-primary btn-block" type="submit" style="height: 60px;">Registrarse</button>
                        </div>
                        <div id="passwordHelpBlock" class="form-text">
                            ¿Ya tienes cuenta? 
                            <a href="Login.jsp">Inicia sesión</a>
                          </div>
                    </div>
                    <%=mensaje%>
                </form>
            </div>
        </div>
    </div>
    <!-- Form end -->


        <!-- Footer Start -->
        <div class="container-fluid position-relative overlay-top bg-dark text-white-50 py-5" style="margin-top: 90px;">
            <div class="container mt-5 pt-5">
                
                <div class="row">
                    <div class="col-md-4 mb-5">
                        <a href="Principal.jsp" class="navbar-brand">
                            <h1 class="mt-n2 text-uppercase text-white"><i class="fa fa-book-reader mr-3"></i>PrestaTec</h1>
                        </a>
                        <p class="m-0">Una plataforma de estudiantes del Tec para estudiantes del Tec dedicada a la gestión del préstamo de materiales entre la comunidad estudiantil.</p>
               
                    </div>
                    
                    <div class="col-md-4 mb-5">
                        <h3 class="text-white mb-4">Mantente en contacto</h3>
                        <p><i class="fa fa-map-marker-alt mr-2"></i>Blvd. Felipe Ángeles Km. 84.5, Venta Prieta, 42083 Pachuca de Soto, Hgo. </p>
                        <p><i class="fa fa-phone-alt mr-2"></i>7713099375</p>
                        <p><i class="fa fa-envelope mr-2"></i>prestatec2022@gmail.com</p>
                        <div class="d-flex justify-content-start mt-4">
                            <a class="text-white mr-4" href="#"><i class="fab fa-2x fa-twitter"></i></a>
                            <a class="text-white mr-4" href="#"><i class="fab fa-2x fa-facebook-f"></i></a>
                            <a class="text-white mr-4" href="#"><i class="fab fa-2x fa-linkedin-in"></i></a>
                            <a class="text-white" href="#"><i class="fab fa-2x fa-instagram"></i></a>
                        </div>
                    </div>
                    <div class="col-md-4 mb-5">
                        <h3 class="text-white mb-4">Materiales que puedes encontrar</h3>
                        <div class="d-flex flex-column justify-content-start">
                            <p><i class="fa fa-angle-right mr-2"></i>Libros</p>
                            <p><i class="fa fa-angle-right mr-2"></i>Circuitos</p>
                            <p><i class="fa fa-angle-right mr-2"></i>Archivos</p>
                            <p><i class="fa fa-angle-right mr-2"></i>Batas de laboratorio</p>
                            <p><i class="fa fa-angle-right mr-2"></i>Manuales</p>
                            <p><i class="fa fa-angle-right mr-2"></i>Herramientas</p>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        <div class="container-fluid bg-dark text-white-50 border-top py-4" style="border-color: rgba(256, 256, 256, .1) !important;">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 text-center text-md-left mb-3 mb-md-0">
                        <p class="m-0">Copyright &copy; <a class="text-white" href="#">PrestaTec</a>. Todos los derechos reservados.
                        </p>
                    </div>
                    
                </div>
            </div>
        </div>
        <!-- Footer End -->
    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary rounded-0 btn-lg-square back-to-top"><i class="fa fa-angle-double-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>