import 'package:grey_pile_of_shame/database/dao/parametric_dao.dart';

class ParametricRepository {
  final ParametricDao _dao = ParametricDao();

  Future<List<Map<String, dynamic>>> getRoles() async {
    return await _dao.getRoles();
  }

  Future<List<Map<String, dynamic>>> getPaintingStatuses() async {
    return await _dao.getPaintingStatuses();
  }
}
