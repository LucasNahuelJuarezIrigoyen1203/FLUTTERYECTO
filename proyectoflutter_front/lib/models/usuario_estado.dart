import 'rama_estado.dart';
import 'mascota.dart';

class UsuarioEstado {
  final int id;
  final String nombre;
  final String correo;
  final bool activo;
  final int vidas;
  final int nivelActual;
  final double progreso;
  final List<RamaEstado> ramasEstado;
  final Mascota? mascotaActiva; // 👈 nuevo campo

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

  factory UsuarioEstado.fromJson(Map<String, dynamic> json) {
    return UsuarioEstado(
      id: json['usuario_id'] ?? json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      activo: json['activo'] ?? true,
      vidas: json['vidas'] ?? 5,
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
}
