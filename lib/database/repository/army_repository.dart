import 'package:grey_pile_of_shame/database/dao/army_dao.dart';
import '../../models/army.dart';

class ArmyRepository {
  final ArmyDao _armyDao = ArmyDao();

  Future<List<Army>> getArmiesByGame(int gameId) async {
    return _armyDao.getArmiesByGame(gameId);
  }

  Future<List<Army>> getAllArmies() async {
    return _armyDao.getAllArmies();
  }

  Future<int> insertArmy(Map<String, dynamic> armyMap) async {
    return _armyDao.insertArmy(armyMap);
  }

  Future<int> updateArmy(int id, Map<String, dynamic> values) async {
    return _armyDao.updateArmy(id, values);
  }

  Future<int> deleteArmy(int id) async {
    return _armyDao.deleteArmy(id);
  }

  Future<bool> hasUnits(int armyId) async {
    return await _armyDao.hasUnits(armyId);
  }
}
