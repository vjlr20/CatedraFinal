<%-- 
    Document   : login.jsp
    Created on : 05-10-2021, 02:42:27 PM
    Author     : Victor López
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="sv.edu.udb.database.Conexion" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%           
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");

            String mensaje = "", route = "";
            // out.println(usuario);
           if (usuario.equals("") || password.equals("")) {
                mensaje = "Credenciales invalidas";
                route = "../index.jsp";
            } else {
                Conexion conex = new Conexion();

                String sql = "SELECT usuario, contraseña, tipo_usuario, nombres, apellidos, usuario_id FROM usuarios WHERE usuario = '" + usuario + "' AND contraseña = '" + password + "' AND estado = 1";
                // out.println(sql);
                conex.setRs(sql);

                ResultSet resultado = conex.getRs();
                
                resultado.last();

                if (resultado.getRow() > 0) {
                    session.setAttribute("id", resultado.getString(6));
                    session.setAttribute("user", resultado.getString(1));
                    session.setAttribute("nombres", resultado.getString(4));
                    session.setAttribute("apellidos", resultado.getString(5));
                    session.setAttribute("tipo", resultado.getInt(3));

                    mensaje = resultado.getString(4) + " " + resultado.getString(5);
                    // out.println(resultado.getInt(3));
                    switch (resultado.getInt(3)) {
                        case 1:
                            route = "../admin/index.jsp";
                            break;

                        case 2:
                            route = "../jefe/Index.jsp";
                            break;

                        case 3:
                            route = "../empleado/index.jsp";
                            break;

                        case 4:
                            route = "../desarrollo/index.jsp";
                            break;

                        case 5:
                            route = "../programador/index.jsp";
                            break;
                    }
                    
                } else {
                    mensaje = "El usuario no se encuentra registrado";
                    route = "../index.jsp";
                }
            }
        %>
        <jsp:forward page="<%= route %>">
            <jsp:param name="mensaje" value="<%= mensaje %>" />
        </jsp:forward> 
    </body>
</html>
