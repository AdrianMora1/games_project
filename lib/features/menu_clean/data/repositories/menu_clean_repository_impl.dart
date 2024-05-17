import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/game_clean.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_clean_remote_datasource.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDataSource remoteDataSource;

  MenuRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<GameClean>>> getGamesCatalog() async {
    try {
      final List<GameClean> result = await remoteDataSource.getGamesCatalog();
      return Right(result);
    } on Exception catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
