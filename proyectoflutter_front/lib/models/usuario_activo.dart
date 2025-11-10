import 'usuario_estado.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Clase que mantiene en memoria los datos del usuario activo.
/// Puede guardar y recuperar la sesión en disco usando SharedPreferences.
class UsuarioActivo {
  static int id = 0;
  static String nombre = '';
  static String correo = '';
  static int nivelActual = 1;
  static double progreso = 0.0;
  static int vidas = 5;
  static List<RamaEstado> ramasEstado = [];

  /// Verifica si hay sesión activa
  static bool get estaLogueado => id > 0;

  /// Carga todos los datos desde el modelo recibido del backend
  static void cargarDesdeEstado(UsuarioEstado estado) {
    id = estado.id;
    nombre = estado.nombre;
    correo = estado.correo;
    nivelActual = estado.nivelActual;
    progreso = estado.progreso;
    vidas = estado.vidas;
    ramasEstado = estado.ramasEstado;
  }

  /// Limpia todos los datos (logout)
  static Future<void> logout() async {
    id = 0;
    nombre = '';
    correo = '';
    nivelActual = 1;
    progreso = 0.0;
    vidas = 5;
    ramasEstado = [];

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Guarda los datos actuales en disco
  static Future<void> guardarEnLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('usuario_id', id);
    await prefs.setString('usuario_nombre', nombre);
    await prefs.setString('usuario_correo', correo);
    await prefs.setInt('usuario_nivel', nivelActual);
    await prefs.setDouble('usuario_progreso', progreso);
    await prefs.setInt('usuario_vidas', vidas);
    // ramasEstado se puede guardar como JSON si lo necesitás
  }

  /// Carga los datos guardados en disco
  static Future<void> cargarDesdeLocal() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('usuario_id') ?? 0;
    nombre = prefs.getString('usuario_nombre') ?? '';
    correo = prefs.getString('usuario_correo') ?? '';
    nivelActual = prefs.getInt('usuario_nivel') ?? 1;
    progreso = prefs.getDouble('usuario_progreso') ?? 0.0;
    vidas = prefs.getInt('usuario_vidas') ?? 5;
    ramasEstado = []; // podés deserializar si guardás las ramas en JSON
  }
}
