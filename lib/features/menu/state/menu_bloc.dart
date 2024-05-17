// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:games_project/features/menu/data/models/game_model.dart';
import 'package:games_project/features/menu/data/menu_service.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuService menuService;

  MenuBloc({required this.menuService}) : super(const MenuState()) {
    on<GetGamesCatalogEvent>(_getGamesCatalogEvent);

    add(GetGamesCatalogEvent());
  }

  Future<void> _getGamesCatalogEvent(
      GetGamesCatalogEvent event, Emitter<MenuState> emit) async {
    await menuService.getGamesCatalog().then(
        (result) => emit(state.copyWith(game: result)),
        onError: (e) => print(e));
  }
}
