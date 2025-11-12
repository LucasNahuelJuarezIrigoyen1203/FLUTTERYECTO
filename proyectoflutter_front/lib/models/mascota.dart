class Mascota {
  final int id;
  final String nombre;
  final String imagen;

  Mascota({
    required this.id,
    required this.nombre,
    required this.imagen,
  });

  factory Mascota.fromJson(Map<String, dynamic> json) {
    return Mascota(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'imagen': imagen,
    };
  }
}
