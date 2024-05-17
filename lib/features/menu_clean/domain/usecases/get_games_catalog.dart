import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/game_clean.dart';
import '../repositories/menu_repository.dart';

class GetGamesCatalog implements UseCase<List<GameClean>, GetGamesParams> {
  final MenuRepository repository;

  GetGamesCatalog({required this.repository});

  @override
  Future<Either<Failure, List<GameClean>>> call(GetGamesParams params) async {
    return await repository.getGamesCatalog();
  }
}

class GetGamesParams extends Equatable {
  const GetGamesParams();

  @override
  List<Object> get props => [];
}
