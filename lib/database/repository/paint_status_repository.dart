import 'package:grey_pile_of_shame/database/dao/paint_status_dao.dart';
import 'package:grey_pile_of_shame/models/paint_status.dart';

class PaintingStatusRepository {
  final PaintingStatusDao _dao = PaintingStatusDao();

  Future<List<PaintingStatus>> getAll() {
    return _dao.getAll();
  }

  Future<void> insert(PaintingStatus status) {
    return _dao.insert(status);
  }

  Future<void> update(PaintingStatus status) {
    return _dao.update(status);
  }

  Future<void> delete(int id) {
    return _dao.delete(id);
  }
}
