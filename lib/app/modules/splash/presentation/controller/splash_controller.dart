import 'package:marvelapp/app/core/domain/entities/char_entity.dart';
import 'package:marvelapp/app/core/domain/enums/control_state.dart';
import 'package:marvelapp/app/core/stores/characters_store.dart';
import 'package:marvelapp/app/core/usecases/get_heroes_from_local_usecase.dart';
import 'package:marvelapp/app/core/usecases/get_heroes_from_server_usecase.dart';
import 'package:marvelapp/app/core/usecases/i_usecase.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

class SplashController = SplashControllerBase with _$SplashController;

abstract class SplashControllerBase with Store {
  final CharactersStore _store;
  final GetHeroesFromServerUsecase _getHeroesFromServerUsecase;
  final GetHeroesFromLocalUsecase _getHeroesFromLocalUsecase;

  SplashControllerBase({
    required GetHeroesFromLocalUsecase getHeroesFromLocalUsecase,
    required GetHeroesFromServerUsecase getHeroesFromServerUsecase,
    required CharactersStore store,
  })  : _store = store,
        _getHeroesFromServerUsecase = getHeroesFromServerUsecase,
        _getHeroesFromLocalUsecase = getHeroesFromLocalUsecase;

  @observable
  ControlState state = StartState();

  @action
  void setState(ControlState nextState) => state = nextState;

  @action
  void pipeline() async {
    List<Char> heroes = [];
    setState(LoadingState());

    final localResult = await _getHeroesFromLocalUsecase(const NoParams());
    localResult.fold(
      (l) => [],
      (heroes) {
        heroes = heroes;
      },
    );
    if (heroes.isEmpty) {
      final result =
          await _getHeroesFromServerUsecase(ParamsGetHeroesFromServerUsecase());
      result.fold(
        (failure) {
          state = ErrorState();
        },
        (heroes) async {
          _store.setCharacters(heroes);
          await Future.delayed(const Duration(seconds: 1));
          setState(SuccessState());
        },
      );
    } else {
      _store.setCharacters(heroes);
      await Future.delayed(const Duration(seconds: 2));
      setState(SuccessState());
    }
  }
}
