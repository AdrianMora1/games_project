part of 'menu_bloc.dart';

enum MenuStatus {
  none,
  menuError,
  getGamesCatalogSuccesfully,
}

class MenuState extends Equatable {
  final List<GameModel> game;

  const MenuState({this.game = const []});

  MenuState copyWith({
    List<GameModel>? game,
  }) {
    return MenuState(game: game ?? this.game);
  }

  MenuState reset() {
    return copyWith(game: const []);
  }

  @override
  List<Object?> get props => [game];
}
