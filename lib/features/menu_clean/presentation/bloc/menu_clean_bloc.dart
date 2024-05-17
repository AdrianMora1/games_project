import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:games_project/features/menu_clean/domain/entities/game_clean.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../../../core/network/failure.dart';
import '../../domain/usecases/get_games_catalog.dart';

part 'menu_clean_event.dart';
part 'menu_clean_state.dart';

class MenuCleanBloc extends Bloc<MenuCleanEvent, MenuCleanState> {
  final GetGamesCatalog getGamesCatalog;

  MenuCleanBloc({required this.getGamesCatalog})
      : super(const MenuCleanState()) {
    on<GetGamesCatalogCleanEvent>(_getGamesCatalogCleanEvent);
  }

  Future<void> _getGamesCatalogCleanEvent(
      GetGamesCatalogCleanEvent event, Emitter<MenuCleanState> emit) async {
    final result = await getGamesCatalog.call(const GetGamesParams());
    result.fold((failure) {
      emit(state.copyWith(
          menuCleanStatus: MenuCleanStatus.menuError, failure: failure));
    }, (games) {
      emit(state.copyWith(
          game: games,
          menuCleanStatus: MenuCleanStatus.getGamesCatalogSuccesfully));
    });
  }
}
