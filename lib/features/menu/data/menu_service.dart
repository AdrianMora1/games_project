import 'package:dio/dio.dart';
import 'package:games_project/features/menu/data/models/game_model.dart';

class MenuService {
  final Dio _dio = Dio();

  Future<List<GameModel>> getGamesCatalog(
      {String? category, String? name}) async {
    final response = await _dio.get(
        'http://127.0.0.1:8000/games/${category != null ? '?plataforma=$category' : ''}${name != null ? '?nombre=$name' : ''}');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      return data.map((game) => GameModel.fromJson(game)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<void> addGame({required GameModel game}) async {
    final response =
        await _dio.post('http://127.0.0.1:8000/games/', data: game.toJson());

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<void> deleteGame({required int gameId}) async {
    final response = await _dio.delete('http://127.0.0.1:8000/games/$gameId');

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
