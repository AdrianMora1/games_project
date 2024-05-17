import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Categories extends Equatable {
  final String nombre;
  final IconData icono;
  final String? filterName;

  const Categories(
      {required this.icono, required this.nombre, this.filterName});

  @override
  List<Object?> get props => [icono, nombre, filterName];
}
