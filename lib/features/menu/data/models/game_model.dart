import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final int? id;
  final String? nombre;
  final String? fecha;
  final String? plataforma;
  final String? imagen;

  const GameModel(
      {this.id, this.nombre, this.fecha, this.plataforma, this.imagen});

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
        id: json['id'],
        nombre: json['nombre'],
        fecha: json['fecha'],
        plataforma: json['plataforma'],
        imagen: json['imagen']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fecha': fecha,
      'plataforma': plataforma,
      'imagen': imagen
    };
  }

  @override
  List<Object?> get props => [id, nombre, fecha, plataforma, imagen];
}
