<%-- 
    Document   : Peticiones
    Created on : 5/10/2021, 09:07:36 PM
    Author     : usuario
--%>

// importar las librerías

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="logica.Cancion"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%    // Iniciando respuesta JSON.
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "actualizarcancion",
        "eliminarcancion",
        "listarcancion",
        "guardarCancion"
    });
    
    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarCancion")) {
            int ident = Integer.parseInt(request.getParameter("idCancion"));
            String titulo = request.getParameter("titulo");
            String artista = request.getParameter("artista");
            String genero = request.getParameter("genero");
            String duracion = request.getParameter("duracion");
            String fechaSubida = request.getParameter("fechaSubida");
            //boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
            //su codigo acá
            Cancion c= new Cancion();
            c.setTitulo(titulo);
            c.setIdCancion(ident);
            c.setArtista(artista);
            c.setGenero(genero);
            c.setDuracion(duracion);
            c.setFechaSubida(fechaSubida);
            
            if (c.guardarCancion()){
                    respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarcancion")) {
            int idCancion = Integer.parseInt(request.getParameter("idCancion"));
            //su codigo acá
            Cancion c= new Cancion();
            if (c.borrarCancion(idCancion)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarcancion")) {
            //su codigo acá
            Cancion c= new Cancion();
            try {
                List<Cancion> lista = c.listarCanciones();
                respuesta += "\"" + proceso + "\": true,\"Canciones\":" + new Gson().toJson(lista);
            } catch (SQLException ex) {
                respuesta += "\"" + proceso + "\": true,\"Canciones\":[]";
                Logger.getLogger(Cancion.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarcancion")) {
            int ident = Integer.parseInt(request.getParameter("idCancion"));
            String titulo = request.getParameter("titulo");
            String artista = request.getParameter("artista");
            String genero = request.getParameter("genero");
            String duracion = request.getParameter("duracion");
            String fechaSubida = request.getParameter("fechaSubida");

            //su codigo acá
            Cancion c= new Cancion(); 
            c.setTitulo(titulo);
            c.setIdCancion(ident);
            c.setArtista(artista);
            c.setGenero(genero);
            c.setDuracion(duracion);
            c.setFechaSubida(fechaSubida);

            if (c.actualizarCancion()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Usuario sin sesión.
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>
