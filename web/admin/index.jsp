<%-- 
    Document   : index
    Created on : 05-10-2021, 03:29:10 PM
    Author     : Victor López
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="sv.edu.udb.database.Conexion" %>

<!DOCTYPE html>
<html lang="es" dir="ltr">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administrador</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
    </head>
    <body>
        <jsp:include page="../components/navbar_admin.jsp"></jsp:include>
        <section class="py-4">
            <div class="container">
                <% if (request.getParameter("mensaje") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong>Bienvenido</strong> <%= request.getParameter("mensaje") %>!
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <br>
                <% } %>
                <div class="container-fluid">
                    <h3 class="text-center">Áreas funcionales</h3>
                    <div class="py-3">
                        <a href="${pageContext.request.contextPath}/admin/area/nueva.jsp" class="btn btn-info">Nueva área</a>
                    </div>
                    <div class="text-center">
                        <%
                            Conexion conex = new Conexion();

                            String sql = "SELECT departamento.departamento_id, departamento.codigo, departamento.departamento, CONCAT(usuarios.nombres, ' ', usuarios.apellidos) AS encargado, DATE(departamento.fecha_registro) FROM departamento LEFT JOIN usuarios ON usuarios.usuario_id = departamento.jefe";

                            conex.setRs(sql);

                            ResultSet resultado = conex.getRs();

                            resultado.last();
                        %>
                        <table id="myTable" class="table table-dark">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Código</th>
                                    <th scope="col">Departamento</th>
                                    <th scope="col">Jefe</th>
                                    <th scope="col">Fecha de registro</th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (resultado.getRow() < 1) { %>
                                    <tr>
                                        <th scope="row" colspan="6">1</th>
                                    </tr>
                                <% 
                                    } else {
                                        resultado.beforeFirst();

                                        while (resultado.next()) { 
                                %>
                                    <tr>
                                        <th scope="row"><%= resultado.getInt(1) %></th>
                                        <td><%= resultado.getString(2) %></td>
                                        <td><%= resultado.getString(3) %></td>
                                        <td><%= resultado.getString(4) %></td>
                                        <td><%= resultado.getString(5) %></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/area/editar.jsp?area=<%= resultado.getInt(1) %>" class="btn btn-info" data-bs-toggle="tooltip" data-bs-placement="left" title="Editar">
                                                <i class="zmdi zmdi-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/area/eliminar.jsp?area=<%= resultado.getInt(1) %>" class="btn btn-danger" data-bs-toggle="tooltip" data-bs-placement="right" title="Borrar">
                                                <i class="zmdi zmdi-delete"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <%
                                        } 
                                    } 
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/js/table.js"></script>
    </body>
</html>
