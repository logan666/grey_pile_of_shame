import 'package:grey_pile_of_shame/database/dao/unit_dao.dart';
import '../../models/unit.dart';

class UnitRepository {
  final UnitDao _unitDao = UnitDao();

  Future<int> insertUnit(Map<String, dynamic> unitMap) async {
    return _unitDao.insertUnit(unitMap);
  }

  Future<List<Unit>> getUnits(int armyId) async {
    return _unitDao.getUnits(armyId);
  }

  Future<int> updateUnit(int id, Map<String, dynamic> unit) async {
    return _unitDao.updateUnit(id, unit);
  }

  Future<int> deleteUnit(int id) async {
    return _unitDao.deleteUnit(id);
  }

  Future<Map<String, int>> getMiniatureStats(int unitId) {
    return _unitDao.getMiniatureStats(unitId);
  }
}
