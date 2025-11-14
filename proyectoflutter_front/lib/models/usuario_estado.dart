import 'rama_estado.dart';
import 'mascota.dart';

class UsuarioEstado {
  final int id;
  final String nombre;
  final String correo;
  final bool activo;
  final int vidas; // 👈 cantidad de vidas actuales
  final int nivelActual;
  final double progreso;
  final List<RamaEstado> ramasEstado;
  final Mascota? mascotaActiva;

  UsuarioEstado({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.activo,
    required this.vidas,
    required this.nivelActual,
    required this.progreso,
    required this.ramasEstado,
    required this.mascotaActiva,
  });

  /// 🔹 Construcción desde JSON (respuesta del backend)
  factory UsuarioEstado.fromJson(Map<String, dynamic> json) {
    return UsuarioEstado(
      id: json['usuario_id'] ?? json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      activo: json['activo'] ?? true,
      vidas: json['vidas'] ?? 5, // 👈 si no viene, por defecto 5
      nivelActual: json['nivel_actual'] ?? 1,
      progreso: (json['progreso'] ?? 0.0).toDouble(),
      ramasEstado: (json['ramas_estado'] as List? ?? [])
          .map((r) => RamaEstado.fromJson(r))
          .toList(),
      mascotaActiva: json['mascota_activa'] != null
          ? Mascota.fromJson(json['mascota_activa'])
          : null,
    );
  }

  /// 🔹 Conversión a JSON (para enviar al backend si hace falta)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'activo': activo,
      'vidas': vidas,
      'nivel_actual': nivelActual,
      'progreso': progreso,
      'ramas_estado': ramasEstado.map((r) => r.toJson()).toList(),
      'mascota_activa': mascotaActiva?.toJson(),
    };
  }

  /// 🔹 Copia con cambios (ej. actualizar vidas)
  UsuarioEstado copyWith({
    int? vidas,
    int? nivelActual,
    double? progreso,
    List<RamaEstado>? ramasEstado,
    Mascota? mascotaActiva,
  }) {
    return UsuarioEstado(
      id: id,
      nombre: nombre,
      correo: correo,
      activo: activo,
      vidas: vidas ?? this.vidas,
      nivelActual: nivelActual ?? this.nivelActual,
      progreso: progreso ?? this.progreso,
      ramasEstado: ramasEstado ?? this.ramasEstado,
      mascotaActiva: mascotaActiva ?? this.mascotaActiva,
    );
  }

  /// 🔹 Helper para asegurar que las vidas estén en rango válido (0–5)
  int get vidasSeguras => vidas.clamp(0, 5);

  /// 🔹 Resumen rápido (para debug o mostrar en UI)
  String resumen() {
    return "Usuario: $nombre | Vidas: $vidasSeguras | Nivel: $nivelActual | Mascota: ${mascotaActiva?.nombre ?? 'Ninguna'}";
  }
}

/// 🔹 Extension helper para verificar si el usuario está sin vidas
extension UsuarioEstadoHelper on UsuarioEstado {
  bool get sinVidas => vidasSeguras == 0;
}
