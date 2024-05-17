part of 'menu_clean_bloc.dart';

@immutable
abstract class MenuCleanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetGamesCatalogCleanEvent extends MenuCleanEvent {}
