part of 'menu_clean_bloc.dart';

enum MenuCleanStatus {
  none,
  menuError,
  getGamesCatalogSuccesfully,
}

class MenuCleanState extends Equatable {
  final List<GameClean> game;
  final MenuCleanStatus menuCleanStatus;
  final Failure failure;

  const MenuCleanState(
      {this.game = const [],
      this.menuCleanStatus = MenuCleanStatus.none,
      this.failure = const Failure()});

  MenuCleanState copyWith(
      {List<GameClean>? game,
      MenuCleanStatus? menuCleanStatus,
      Failure? failure}) {
    return MenuCleanState(
        game: game ?? this.game,
        menuCleanStatus: menuCleanStatus ?? this.menuCleanStatus,
        failure: failure ?? this.failure);
  }

  MenuCleanState reset() {
    return copyWith(
        game: const [],
        menuCleanStatus: MenuCleanStatus.none,
        failure: const Failure());
  }

  @override
  List<Object?> get props => [game, menuCleanStatus, failure];
}
