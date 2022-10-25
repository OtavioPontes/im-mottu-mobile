import 'package:flutter_modular/flutter_modular.dart';
import 'package:marvelapp/app/core/usecases/i_usecase.dart';

import 'core/usecases/delete_heroes_from_local_usecase.dart';

class AppController implements Disposable {
  final DeleteHeroesFromLocalUsecase _deleteHeroesFromLocalUsecase;

  AppController({
    required DeleteHeroesFromLocalUsecase deleteHeroesFromLocalUsecase,
  }) : _deleteHeroesFromLocalUsecase = deleteHeroesFromLocalUsecase;

  @override
  void dispose() async {
    await _deleteHeroesFromLocalUsecase(const NoParams());
  }
}
