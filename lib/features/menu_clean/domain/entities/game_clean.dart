import 'package:equatable/equatable.dart';

class GameClean extends Equatable {
  final int? id;
  final String? nombre;
  final String? fecha;
  final String? plataforma;
  final String? imagen;

  const GameClean(
      {this.id, this.fecha, this.imagen, this.nombre, this.plataforma});

  @override
  List<Object?> get props => [id, fecha, imagen, nombre, plataforma];
}
