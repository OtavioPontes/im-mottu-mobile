import 'package:marvelapp/app/core/data/models/char_model.dart';

abstract class IRemoteDatasource {
  Future<List<CharModel>> getHeroes({
    String? startsWith,
    int? offset,
  });
  Future<List<CharModel>> getRelatedHeroes({required int id});
}
