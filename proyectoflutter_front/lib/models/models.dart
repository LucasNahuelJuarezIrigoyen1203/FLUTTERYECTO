class Pregunta {
  final int id;
  final String texto;
  final List<Opcion> opciones;

  Pregunta({required this.id, required this.texto, required this.opciones});

  factory Pregunta.fromJson(Map<String, dynamic> json) {
    return Pregunta(
      id: json['id'],
      texto: json['texto'],
      opciones: (json['opciones'] as List)
          .map((o) => Opcion.fromJson(o))
          .toList(),
    );
  }
}

class Opcion {
  final int id;
  final String texto;

  Opcion({required this.id, required this.texto});

  factory Opcion.fromJson(Map<String, dynamic> json) {
    return Opcion(id: json['id'], texto: json['texto']);
  }
}

class RespuestaOutput {
  final bool correcta;
  final int nivelActual;
  final double progreso;
  final int? vidasRestantes;

  RespuestaOutput({
    required this.correcta,
    required this.nivelActual,
    required this.progreso,
    this.vidasRestantes,
  });

  factory RespuestaOutput.fromJson(Map<String, dynamic> json) {
    return RespuestaOutput(
      correcta: json['correcta'],
      nivelActual: json['nivel_actual'],
      progreso: json['progreso'],
      vidasRestantes: json['vidas_restantes'],
    );
  }
}

class Nivel {
  final int id;
  final String nombre;

  Nivel({required this.id, required this.nombre});

  factory Nivel.fromJson(Map<String, dynamic> json) {
    return Nivel(id: json['id'], nombre: json['nombre']);
  }
}

class NivelDetalle {
  final int id;
  final String nombre;
  final String rama;
  final String dificultad;
  final double multiplicador;

  NivelDetalle({
    required this.id,
    required this.nombre,
    required this.rama,
    required this.dificultad,
    required this.multiplicador,
  });

  factory NivelDetalle.fromJson(Map<String, dynamic> json) {
    return NivelDetalle(
      id: json['id'],
      nombre: json['nombre'],
      rama: json['rama'],
      dificultad: json['dificultad'],
      multiplicador: json['multiplicador'],
    );
  }
}

class Rama {
  final int id;
  final String nombre;

  Rama({required this.id, required this.nombre});

  factory Rama.fromJson(Map<String, dynamic> json) {
    return Rama(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
}
