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

  Future<int> insertArmy(Army army) async {
    return _armyDao.insertArmy(army);
  }

  Future<void> updateArmy(Army army) async {
    return _armyDao.updateArmy(army);
  }

  Future<int> deleteArmy(int id) async {
    return _armyDao.deleteArmy(id);
  }

  Future<bool> hasUnits(int armyId) async {
    return await _armyDao.hasUnits(armyId);
  }

  Future<List<Army>> getVisibleArmiesByGame(int gameId) async {
    return _armyDao.getVisibleArmiesByGame(gameId);
  }

  Future<Army?> getArmyById(int id) async {
    return _armyDao.getArmyById(id);
  }
}
