import 'package:marvelapp/app/core/usecases/get_heroes_from_server_usecase.dart';
import 'package:marvelapp/app/core/usecases/put_heroes_to_local_usecase.dart';
import 'package:mobx/mobx.dart';

import '../domain/entities/char_entity.dart';

part 'characters_store.g.dart';

class CharactersStore = CharactersStoreBase with _$CharactersStore;

abstract class CharactersStoreBase with Store {
  final GetHeroesFromServerUsecase _getHeroesFromServerUsecase;

  final PutHeroesToServerUsecase _putHeroesToServerUsecase;

  @observable
  List<Char> characters = [];

  CharactersStoreBase({
    required GetHeroesFromServerUsecase getHeroesFromServerUsecase,
    required PutHeroesToServerUsecase putHeroesToServerUsecase,
  })  : _getHeroesFromServerUsecase = getHeroesFromServerUsecase,
        _putHeroesToServerUsecase = putHeroesToServerUsecase;

  @action
  Future<void> setCharacters(List<Char> heroes) async {
    characters = heroes;
    await _putHeroesToServerUsecase(
      ParamsPutHeroesToServerUsecase(
        heroes: heroes,
      ),
    );
  }

  Future<void> fetchHeroes({
    String? startsWith,
    int? offset,
  }) async {
    final result = await _getHeroesFromServerUsecase(
      ParamsGetHeroesFromServerUsecase(
        nameStartsWith: startsWith,
        offset: offset,
      ),
    );
    result.fold(
      (failure) {},
      (list) async {
        await setCharacters(list);
      },
    );
  }
}
