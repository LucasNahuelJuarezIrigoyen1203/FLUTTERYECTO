class RamaEstado {
  final int ramaId;
  final String ramaNombre;
  final int nivelActual;
  final double progreso;

  RamaEstado({
    required this.ramaId,
    required this.ramaNombre,
    required this.nivelActual,
    required this.progreso,
  });

  factory RamaEstado.fromJson(Map<String, dynamic> json) {
    return RamaEstado(
      ramaId: json['rama_id'] ?? 0,
      ramaNombre: json['rama_nombre'] ?? '',
      nivelActual: json['nivel_actual'] ?? 1,
      progreso: (json['progreso'] ?? 0.0).toDouble(),
    );
  }
}

class UsuarioEstado {
  final int id;
  final String nombre;
  final String correo;
  final bool activo;
  final int vidas;
  final int nivelActual;
  final double progreso;
  final List<RamaEstado> ramasEstado;

  UsuarioEstado({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.activo,
    required this.vidas,
    required this.nivelActual,
    required this.progreso,
    required this.ramasEstado,
  });

  factory UsuarioEstado.fromJson(Map<String, dynamic> json) {
    return UsuarioEstado(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      activo: json['activo'] ?? true,
      vidas: json['vidas'] ?? 5,
      nivelActual: json['nivel_actual'] ?? 1,
      progreso: (json['progreso'] ?? 0.0).toDouble(),
      ramasEstado: (json['ramas_estado'] as List? ?? [])
          .map((r) => RamaEstado.fromJson(r))
          .toList(),
    );
  }

  /// Método copyWith para crear una copia modificada del estado
  UsuarioEstado copyWith({
    int? vidas,
    int? nivelActual,
    double? progreso,
    List<RamaEstado>? ramasEstado,
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
    );
  }
}
