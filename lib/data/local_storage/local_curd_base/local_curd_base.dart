abstract class LocalCurdBase {
  Future saveData({
    required String tableName,
    required String key,
    required data,
  });
  Future getData({required String tableName});
  Future updateData({required String key, required Map<String, dynamic> data});
  Future deleteData({required String tableName});
}
