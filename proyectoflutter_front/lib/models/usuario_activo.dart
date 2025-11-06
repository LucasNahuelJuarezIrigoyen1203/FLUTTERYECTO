import 'usuario_estado.dart';

class UsuarioActivo {
  static int id = 0;
  static String nombre = '';
  static String correo = '';
  static int nivelActual = 1;
  static double progreso = 0.0;
  static int vidas = 5;
  static List<RamaEstado> ramasEstado = [];

  static void cargarDesdeEstado(UsuarioEstado estado) {
    id = estado.id;
    nombre = estado.nombre;
    correo = estado.correo;
    nivelActual = estado.nivelActual;
    progreso = estado.progreso;
    vidas = estado.vidas;
    ramasEstado = estado.ramasEstado;
  }
}
