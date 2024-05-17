import 'package:dio/dio.dart';
import 'package:games_project/features/menu/data/models/game_model.dart';

class MenuService {
  final Dio _dio = Dio();

  Future<List<GameModel>> getGamesCatalog() async {
    final response = await _dio.get('http://127.0.0.1:8000/games');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((game) => GameModel.fromJson(game)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
