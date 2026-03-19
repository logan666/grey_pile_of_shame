import 'package:grey_pile_of_shame/database/dao/miniature_dao.dart';
import '../../models/miniature.dart';

class MiniatureRepository {
  final MiniatureDao _dao = MiniatureDao();

  Future<List<Miniature>> getMiniatures(int unitId) {
    return _dao.getMiniatures(unitId);
  }

  Future<int> insertMiniature(Miniature mini) {
    return _dao.insertMiniature(mini);
  }

  Future<int> updateMiniature(Miniature mini) {
    return _dao.updateMiniature(mini);
  }

  Future<int> deleteMiniature(int id) {
    return _dao.deleteMiniature(id);
  }

  Future<int> updateAllStatuses(int unitId, int status) {
    return _dao.updateAllStatuses(unitId, status);
  }
}
