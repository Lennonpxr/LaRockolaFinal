package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import persistencia.ConexionBD;

public class Cancion {
    private int idCancion;
    private String titulo;
    private String artista;
    private String genero;
    private String duracion;
    private String fechaSubida;
    
    //inicializar variables
    
    public Cancion(){
    }
    
    public Cancion getCancion(int idCancion) throws SQLException {
        this.idCancion = idCancion;
        return this.getCancion();
    }
    
        //constructores

    public int getIdCancion() {
        return idCancion;
    }

    public void setIdCancion(int idCancion) {
        this.idCancion = idCancion;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String Titulo) {
        this.titulo = Titulo;
    }

    public String getArtista() {
        return artista;
    }

    public void setArtista(String Artista) {
        this.artista = Artista;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String Genero) {
        this.genero = Genero;
    }

    public String getDuracion() {
        return duracion;
    }

    public void setDuracion(String Duracion) {
        this.duracion = Duracion;
    }

    public String getFechaSubida() {
        return fechaSubida;
    }

    public void setFechaSubida(String fechaSubida) {
        this.fechaSubida = fechaSubida;
    }

//
    public boolean guardarCancion() {
        ConexionBD conexion = new ConexionBD();
      
        String sentencia = "INSERT INTO canciones(idcancion, titulo, artista, genero, duracion, fechaSubida) "
                + " VALUES ( '" + this.idCancion + "','" + this.titulo + "',"
                + "'" + this.artista + "','" + this.genero + "','" + this.duracion + "',"
                + "'" + this.fechaSubida + "');  ";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public boolean borrarCancion(int idcancion) {
        String Sentencia = "DELETE FROM `canciones` WHERE `idcancion`='" + idcancion + "'";
        ConexionBD conexion = new ConexionBD();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(Sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public boolean actualizarCancion() {
        ConexionBD conexion = new ConexionBD();
        String Sentencia = "UPDATE `canciones` SET titulo='" + this.titulo + "',artista='" + this.artista + "',genero='" + this.genero
                + "',duracion='" + this.duracion + "',fechaSubida='" + this.fechaSubida + ";";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(Sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public List<Cancion> listarCanciones() throws SQLException {
        ConexionBD conexion = new ConexionBD();
        List<Cancion> listaCanciones = new ArrayList<>();
        String sql = "select * from canciones order by idCancion asc";
        ResultSet rs = conexion.consultarBD(sql);
        Cancion c;
        while (rs.next()) {
            c = new Cancion();
            c.setIdCancion(rs.getInt("idCancion"));
            c.setTitulo(rs.getString("titulo"));
            c.setArtista(rs.getString("artista"));
            c.setGenero(rs.getString("genero"));
            c.setDuracion(rs.getString("duracion"));
            c.setFechaSubida(rs.getString("fechaSubida"));
            listaCanciones.add(c);

        }
        conexion.cerrarConexion();
        return listaCanciones;
    }

    public Cancion getCancion() throws SQLException {
        ConexionBD conexion = new ConexionBD();
        String sql = "select * from canciones where idCancion='" + this.idCancion + "'";
        ResultSet rs = conexion.consultarBD(sql);
        if (rs.next()) {
            this.idCancion = rs.getInt("idCancion");
            this.titulo = rs.getString("titulo");
            this.artista = rs.getString("artista");
            this.genero = rs.getString("genero");
            this.duracion = rs.getString("duracion");
            this.fechaSubida = rs.getString("fechaSubida");
            conexion.cerrarConexion();
            return this;

        } else {
            conexion.cerrarConexion();
            return null;
        }

    }

    @Override
    public String toString() {
        return "Cancion{" + "idCancion=" + idCancion + ", titulo=" + titulo + ", artista=" + artista + ", genero=" + genero + ", duracion=" + duracion + ", fechaSubida=" + fechaSubida + '}';
    }
}