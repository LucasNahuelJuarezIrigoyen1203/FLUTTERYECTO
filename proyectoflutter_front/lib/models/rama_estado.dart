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
      progreso: (json['progreso'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rama_id': ramaId,
      'rama_nombre': ramaNombre,
      'nivel_actual': nivelActual,
      'progreso': progreso,
    };
  }
}
