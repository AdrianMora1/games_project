// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:games_project/features/menu/data/menu_service.dart';
import 'package:games_project/features/menu/data/models/game_model.dart';
import 'package:intl/intl.dart';

import '../data/models/categories.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuService menuService;

  MenuBloc({required this.menuService}) : super(const MenuState()) {
    on<GetGamesCatalogEvent>(_getGamesCatalogEvent);
    on<AddGameEvent>(_addGameEvent);
    on<DeleteGameEvent>(_deleteGameEvent);
    add(GetGamesCatalogEvent());
  }

  Future<void> _getGamesCatalogEvent(
      GetGamesCatalogEvent event, Emitter<MenuState> emit) async {
    await menuService
        .getGamesCatalog(category: event.category, name: event.name)
        .then(
            (result) => emit(state.copyWith(
                game: result, status: MenuStatus.getGamesCatalogSuccesfully)),
            onError: (e) => print(e));
  }

  Future<void> _addGameEvent(
      AddGameEvent event, Emitter<MenuState> emit) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(event.date);
    await menuService
        .addGame(
            game: GameModel(
                fecha: formattedDate,
                nombre: event.name,
                plataforma: event.category,
                imagen: ''))
        .then((result) {
      emit(state.copyWith(status: MenuStatus.addGameSuccessfully));
      add(GetGamesCatalogEvent());
    }, onError: (e) => print(e));
  }

  Future<void> _deleteGameEvent(
      DeleteGameEvent event, Emitter<MenuState> emit) async {
    await menuService.deleteGame(gameId: event.gameId).then((result) {
      emit(state.copyWith(status: MenuStatus.deleteGameSuccessfully));
      add(GetGamesCatalogEvent());
    }, onError: (e) => print(e));
  }
}
