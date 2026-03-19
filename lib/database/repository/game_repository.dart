import 'package:grey_pile_of_shame/database/dao/game_dao.dart';
import '../../models/game.dart';

class GameRepository {
  final GameDao _gameDao = GameDao();

  Future<List<Game>> getGames() async {
    return _gameDao.getGames();
  }

  Future<int> insertGame(Map<String, dynamic> gameMap) async {
    return _gameDao.insertGame(gameMap);
  }

  Future<int> deleteGame(int id) async {
    return _gameDao.deleteGame(id);
  }
}
