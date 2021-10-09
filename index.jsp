<%-- 
    Document   : index
    Created on : 4/10/2021, 08:50:09 PM
    Author     : usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        Bootstrap core CSS
        <link rel="stylesheets" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        Angular
        <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>
        <style>
        </style>
    </head>
    <style type="text/css">
        .mesages {
            color: #FA787E;
        }
        form.ng-submitted input.ng-invalid {
            border-color: #FA787E;
        }
        form input.ng-invalid.ng-touched {
            border-color: #FA787E;
        }
    </style>
    <body>
        <div class="container-fluid" ng-app="LaRockola4" ng-controller="cancionesController as cn">
            <form name="userForm" novalidate>
                <div class="row">
                    <div class="col-12">
                        <center><h1>Formulario canciones</h1></center>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <h3>seccion 1</h3>
                        <div class="row">
                            <div class="col-6">
                                <label>IdCanciones</label>
                                <input name="IdCanciones" class="form-control" type="number" ng-model="" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            <div class="col-6">
                                <label>Titulo</label>
                                <input name="Titulo" class="form-control" type="text" ng-model="" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label>Artista</label>
                                <input name="Artista" class="form-control" type="text" ng-model="" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            <div class="col-6">
                                <label>Genero</label>
                                <input name="Genero" class="form-control" type="text" ng-model="" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label>Duracion</label>
                                <input name="Duracion" class="form-control" type="number" min="0" ng-model="" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                            <div class="col-6">
                                <label>FechaSubida</label>
                                <input name="FechaSubida" class="form-control" type="text" ng-model="" ng-model-options="{updateOn: 'blur'}" required>
                            </div>
                        </div>
                            <div><br></div>
                            <h3>Seccion 2</h3>
                            <div class="row">
                                <div class="col-3">
                                    <input class="btn btn-success" type="submit" ng-click="" value="Guardar" ng-disabled="" />
                                </div>
                                <div class="col-3">
                                    <button class="btn btn-primary" ng-click="">Listar canciones</button>
                                </div>
                                <div class="col-3">
                                    <button class="btn btn-danger" ng-click="">Eliminar cancion</button>
                                </div>
                                <div class="col-3">
                                    <button class="btn btn-warning" ng-click="">Actualizar canciones</button>
                                </div>
                                <div><br></div>
                                <div class="row">
                                    <div class="col-12 table-responsive-xl">
                                        <h3>Seccion 3</h3>
                                        <table class="table table-striped table-hover">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th>IdCanciones</th>
                                                    <th>Titulo</th>
                                                    <th>Artista</th>
                                                    <th>Genero</th>
                                                    <th>Duracion</th>
                                                    <th>FechaSubida</th>
                                                </tr>
                                            </thead>
                                            <tr ng-repeat = "">
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
    <script>
        var app = angular.module('demoCiclo3', []);
        app.controller('cancionesController', ['$http', controladorCanciones]);
        function controladorCanciones($http) {
            var cn = this;
            cn.listarCanciones = function () {
                var url = "Peticiones.jsp";
                var params = {
                    proceso: "listarcanciones"
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: params
                }).then(function (res) {
                    cn.canciones = res.data.Canciones;
                });
            };
            cn.guardarCancion = function () {
                var cancion = {
                    proceso: "guardarCancion",
                    identificacion: cn.identificacion,
                    nombre: cn.nombre,
                    apellido: cn.apellido,
                    genero: cn.genero,
                    tipoIdentificacion: cn.tipoIdentificacion,
                    telefono: cn.telefono,
                    direccion: cn.direccion,
                    correo: cn.correo
                };
                console.log(cancion);
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: cancion
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[cancion.proceso] === true) {
                            alert("Guardado con éxito");
                           cn.listarCanciones();
                        } else {
                            alert("No se guardo Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });

            };
            cn.eliminarCancion = function () {
                var cancion = {
                    proceso: "eliminarcancion",
                    identificacion: cn.identificacion
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: cancion
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[cancion.proceso] === true) {
                            alert("Eliminado con éxito");
                            //                                cn.listarCanciones();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });

            };
            cn.actualizarCancion = function () {

                var cancion = {
                    proceso: "actualizarcancion",
                    identificacion: cn.identificacion,
                    nombre: cn.nombre,
                    apellido: cn.apellido,
                    genero: cn.genero,
                    tipoIdentificacion: cn.tipoIdentificacion,
                    telefono: cn.telefono,
                    direccion: cn.direccion,
                    correo: cn.correo
                };
                $http({
                    method: 'POST',
                    url: 'Peticiones.jsp',
                    params: cancion
                }).then(function (res) {
                    if (res.data.ok === true) {
                        if (res.data[cancion.proceso] === true) {
                            alert("actualizarcancion con éxito");
                            //                                cn.listarCanciones();
                        } else {
                            alert("Por favor vefifique sus datos");
                        }
                    } else {
                        alert(res.data.errorMsg);
                    }
                });

            };
           
        }
    </script>
</html>
