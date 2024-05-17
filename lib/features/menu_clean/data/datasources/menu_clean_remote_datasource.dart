import '../models/game_clean_model.dart';
import '../services/menu_clean_service.dart';

// ignore: one_member_abstracts
abstract class MenuRemoteDataSource {
  Future<List<GameCleanModel>> getGamesCatalog();
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final MenuCleanService api;

  MenuRemoteDataSourceImpl({required this.api});

  @override
  Future<List<GameCleanModel>> getGamesCatalog() {
    return api.getGamesCatalog();
  }
}
