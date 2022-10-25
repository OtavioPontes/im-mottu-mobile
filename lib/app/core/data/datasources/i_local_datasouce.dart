import '../models/char_model.dart';

abstract class ILocalDatasource {
  Future<List<CharModel>> getHeroes();
  Future<void> putHeroes({required List<CharModel> heroes});
  Future<void> deleteHeroes();
}
