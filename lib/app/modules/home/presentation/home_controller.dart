import 'package:marvelapp/app/core/domain/entities/char_entity.dart';
import 'package:marvelapp/app/core/network/api_config.dart';
import 'package:mobx/mobx.dart';

import 'package:marvelapp/app/core/domain/enums/control_state.dart';
import 'package:marvelapp/app/core/stores/characters_store.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final CharactersStore _store;
  final ApiConfig apiConfig;
  HomeControllerBase({
    required this.apiConfig,
    required CharactersStore store,
  }) : _store = store {
    pipeline();
  }

  @observable
  bool isAscending = false;

  @action
  void setIsAscending(bool isDescending) {
    state = LoadingState();
    isAscending = isDescending;
    state = SuccessState();
  }

  void pipeline() {
    if (heroes.isNotEmpty) {
      setState(SuccessState());
    } else {
      setState(EmptyState());
    }
  }

  @observable
  ControlState state = StartState();

  @action
  void setState(ControlState nextState) => state = nextState;

  @computed
  List<Char> get heroes {
    List<Char> heroes = _store.characters;
    isAscending
        ? heroes.sort((a, b) {
            if (a.name.compareTo(b.name) < 0) return 1;
            if (a.name.compareTo(b.name) > 0) return -1;
            if (a.name.compareTo(b.name) == 0) return 0;
            return 0;
          })
        : heroes.sort((a, b) {
            if (a.name.compareTo(b.name) < 0) return -1;
            if (a.name.compareTo(b.name) > 0) return 1;
            if (a.name.compareTo(b.name) == 0) return 0;
            return 0;
          });
    return heroes;
  }

  @action
  Future<void> fetchHeroes({
    String? startsWith,
    int? offset,
  }) async {
    setState(LoadingState());
    await _store.fetchHeroes(
      offset: offset,
      startsWith: startsWith,
    );
    if (heroes.isEmpty) {
      setState(EmptyState());
    } else {
      setState(SuccessState());
    }
  }
}
