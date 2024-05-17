part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetGamesCatalogEvent extends MenuEvent {}
