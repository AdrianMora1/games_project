import 'package:games_project/features/menu_clean/domain/entities/game_clean.dart';

class GameCleanModel extends GameClean {
  final int? id;
  final String? nombre;
  final String? fecha;
  final String? plataforma;
  final String? imagen;

  const GameCleanModel(
      {this.id, this.nombre, this.fecha, this.plataforma, this.imagen});

  factory GameCleanModel.fromJson(Map<String, dynamic> json) {
    return GameCleanModel(
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
