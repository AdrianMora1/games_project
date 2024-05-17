part of 'menu_bloc.dart';

enum MenuStatus {
  none,
  menuError,
  getGamesCatalogSuccesfully,
  addGameSuccessfully,
  deleteGameSuccessfully
}

class MenuState extends Equatable {
  final List<GameModel> game;
  final List<Categories> categories;
  final MenuStatus status;

  const MenuState(
      {this.game = const [],
      this.categories = const [
        Categories(icono: Icons.category, nombre: 'Todo'),
        Categories(icono: Icons.window, nombre: 'PC', filterName: 'PC'),
        Categories(
            icono: Icons.catching_pokemon,
            nombre: 'Nintendo 64',
            filterName: 'Nintendo 64'),
        Categories(
            icono: Icons.catching_pokemon,
            nombre: 'Nintendo GameCube',
            filterName: 'Nintendo GameCube'),
        Categories(
            icono: Icons.catching_pokemon,
            nombre: 'Nintendo Game Boy',
            filterName: 'Nintendo Game Boy'),
        Categories(
            icono: Icons.catching_pokemon,
            nombre: 'Nintendo Game Boy Advance',
            filterName: 'Nintendo Game Boy Advance'),
        Categories(
            icono: Icons.catching_pokemon,
            nombre: 'Super Nintendo (SNES)',
            filterName: 'Super Nintendo (SNES)'),
        Categories(
            icono: Icons.catching_pokemon,
            nombre: 'Nintendo Entertainment System (NES)',
            filterName: 'Nintendo Entertainment System (NES)'),
        Categories(
            icono: Icons.catching_pokemon,
            nombre: 'Nintendo DS',
            filterName: 'Nintendo DS'),
        Categories(
            icono: Icons.gamepad,
            nombre: 'Sony Playstation',
            filterName: 'Sony Playstation'),
      ],
      this.status = MenuStatus.none});

  MenuState copyWith(
      {List<GameModel>? game,
      List<Categories>? categories,
      MenuStatus? status}) {
    return MenuState(
        game: game ?? this.game,
        categories: categories ?? this.categories,
        status: status ?? this.status);
  }

  MenuState reset() {
    return copyWith(game: const [], status: MenuStatus.none);
  }

  @override
  List<Object?> get props => [game, categories, status];
}
