import 'package:dio/dio.dart';
import 'package:games_project/features/menu_clean/data/models/game_clean_model.dart';

class MenuCleanService {
  final Dio _dio = Dio();

  Future<List<GameCleanModel>> getGamesCatalog() async {
    final response = await _dio.get('http://127.0.0.1:8000/games');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((game) => GameCleanModel.fromJson(game)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
