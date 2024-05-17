part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetGamesCatalogEvent extends MenuEvent {
  final String? category;
  final String? name;
  GetGamesCatalogEvent({this.category, this.name});
}

class AddGameEvent extends MenuEvent {
  final String name;
  final String category;
  final DateTime date;
  AddGameEvent(
      {required this.category, required this.date, required this.name});
}

class DeleteGameEvent extends MenuEvent {
  final int gameId;
  DeleteGameEvent({required this.gameId});
}
