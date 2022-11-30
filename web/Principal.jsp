<%-- 
    Document   : Principal
    Created on : 23 nov. 2022, 19:46:19
    Author     : gohan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%
    String mensaje = "";
    String tablaDatos = "";
    String BotonUsuario = "";
    ResultSet vistaFiltro;
    if(request.getSession().getAttribute("rsFiltro") != null){
        vistaFiltro = (ResultSet)request.getSession().getAttribute("rsFiltro");
        tablaDatos = "<table class='table table-borded table-responsive table-striped'>";
        tablaDatos += "<thead class='table-primary'><tr>";
        tablaDatos += "<th>ID</th>";
        tablaDatos += "<th>Descripción</th>";
        tablaDatos += "<th>Tipo</th>";
        tablaDatos += "<th>Estado</th>";
        tablaDatos += "<th>Categoria</th>";
        tablaDatos += "<th>Dueño</th>";
        tablaDatos += "<th>Reservar</th>";
        tablaDatos += "</tr></thead>";
        while(vistaFiltro.next()){
            tablaDatos += "<tbody><tr>";
            tablaDatos += "<td>"+vistaFiltro.getString(1)+"</td>";
            tablaDatos += "<td>"+vistaFiltro.getString(2)+"</td>";
            tablaDatos += "<td>"+vistaFiltro.getString(3)+"</td>";
            tablaDatos += "<td>"+vistaFiltro.getString(4)+"</td>";
            tablaDatos += "<td>"+vistaFiltro.getString(5)+"</td>";
            tablaDatos += "<td>"+vistaFiltro.getString(7)+"</td>";
            tablaDatos += "<td><button name='btnFiltro' onclick='enviar("+vistaFiltro.getString(1)+", "+vistaFiltro.getString(6)+")' class='btn btn-light py-1 px-2 d-none d-lg-block'>Reservar</button></td>";
            tablaDatos += "</tr></tbody>";
        }
        tablaDatos += "</table>";
        request.getSession().setAttribute("rsFiltro", null);
    }/*else{
        mensaje += "<script language='javascript'>";
        mensaje += "alert('Filtro es nulo');";
        mensaje += "</script>";
    }*/
    if(request.getSession().getAttribute("usuUsuario") != null){
        BotonUsuario += "<a href='Item.jsp' class='btn btn-light py-2 px-4 d-none d-lg-block'>Registro item</a> <small class='px-2'></small>";
        BotonUsuario += "<div class='nav-item dropdown'>";
        BotonUsuario += "<a href='#' class='nav-link dropdown-toggle' data-toggle='dropdown'>"+request.getSession().getAttribute("usuUsuario")+"</a>";
        BotonUsuario += "<div class='dropdown-menu m-0'>";
        BotonUsuario += "<a href='srvPrestamos' class='dropdown-item'>Panel</a>";
        BotonUsuario += "<a href='srvCerrarSesion' class='dropdown-item'>Cerrar sesión</a>";
        BotonUsuario += "</div> </div>";
               
    }else{
        BotonUsuario += "<a href='Registro.jsp' class='btn btn-primary py-2 px-4 d-none d-lg-block'>Crear cuenta</a> <small class='px-2'></small>";
        BotonUsuario += "<a href='Login.jsp' class='btn btn-primary py-2 px-4 d-none d-lg-block'>Inicio de sesión</a>";
                
    }
    %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <title>PrestaTec index</title>
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

<%=mensaje%>

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
                <%=BotonUsuario%>
            </div>
        </nav>
    </div>
    <!-- Navbar End -->


    <!-- Header Start -->
    <div class="jumbotron jumbotron-fluid position-relative overlay-bottom" style="margin-bottom: 90px;">
        <div class="container text-center my-5 py-5">
            <h1 class="text-white mt-4 mb-4">Busca   materiales de alumnos del tec que te puedan ayudar</h1>
            <h1 class="text-white display-1 mb-5">Todo lo que necesitas</h1>
            <form id="frmPrincipal" method="POST" action="srvPrincipal">
            <div class="mx-auto mb-5" style="width: 100%; max-width: 600px;">
                <div class="input-group">
                    <div class="input-group-prepend">
                        
                    </div>
                    
                        <input name="txtFiltro" id="txtFiltro" type="text" class="form-control border-light" style="padding: 30px 25px;" placeholder="libros, archivos, batas, componentes,...">
                    <div class="input-group-append">
                        <button name="btnFiltro" id="btnFiltro" class="btn btn-secondary px-4 px-lg-5">Buscar</button>
                    </div>                    
                </div>
            </div>
            </form>

        </div>
    </div>
    <!-- Header End -->


    

    <!-- Feature Start -->
    <div class="container-fluid bg-image" style="margin: 90px 0;">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 my-5 pt-5 pb-lg-5">
                    <div class="section-title position-relative mb-4">
                        <h2 class="d-inline-block position-relative text-secondary text-uppercase pb-2">Resultados</h2>
                        <form id="srvReservar" method="POST" action="srvReservar">
                            <input id="txtId" type="hidden" value="" name="txtId">
                            <input id="txtDueno" type="hidden" value="" name="txtDueno">
                        </form>
                        <%=tablaDatos%>
                    </div>
                </div>    
            </div>
        </div>
    </div>
    <!-- Feature Start -->


    

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

<script language="javascript">
    
    function enviar(id, dueno){
        document.getElementById("txtId").setAttribute('value',id);
        document.getElementById("txtDueno").setAttribute('value',dueno);
        document.getElementById("srvReservar").submit();
    }
    
</script>
