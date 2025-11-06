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
      ramaId: json['rama_id'],
      ramaNombre: json['rama_nombre'],
      nivelActual: json['nivel_actual'],
      progreso: json['progreso'],
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
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      activo: json['activo'],
      vidas: json['vidas'],
      nivelActual: json['nivel_actual'],
      progreso: json['progreso'],
      ramasEstado: (json['ramas_estado'] as List)
          .map((r) => RamaEstado.fromJson(r))
          .toList(),
    );
  }
}
