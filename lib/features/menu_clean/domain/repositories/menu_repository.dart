import 'package:dartz/dartz.dart';

import '../../../../core/network/failure.dart';
import '../entities/game_clean.dart';

abstract class MenuRepository {
  Future<Either<Failure, List<GameClean>>> getGamesCatalog();
}
