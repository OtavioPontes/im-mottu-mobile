import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:marvelapp/app/core/data/datasources/local_datasource.dart';
import 'package:marvelapp/app/core/data/datasources/remote_datasource.dart';
import 'package:marvelapp/app/core/data/repositories/characters_repository.dart';
import 'package:marvelapp/app/core/network/api_config.dart';
import 'package:marvelapp/app/core/stores/characters_store.dart';
import 'package:marvelapp/app/core/usecases/delete_heroes_from_local_usecase.dart';
import 'package:marvelapp/app/core/usecases/get_heroes_from_local_usecase.dart';
import 'package:marvelapp/app/core/usecases/get_heroes_from_server_usecase.dart';
import 'package:marvelapp/app/core/usecases/put_heroes_to_local_usecase.dart';
import 'package:marvelapp/app/modules/home/home_module.dart';
import 'package:marvelapp/app/modules/splash/splash_module.dart';

import 'app_controller.dart';
import 'modules/details/details_module.dart';

class AppModule extends Module {
  static const String routeName = SplashModule.routeName;
  @override
  List<Bind> get binds => [
        // Controllers
        Bind((i) => AppController(deleteHeroesFromLocalUsecase: i())),
        // Services
        Bind((i) => Dio()),
        Bind((i) => Hive.box('marvel')),
        Bind((i) => ApiConfig()),
        // Stores
        Bind(
          (i) => CharactersStore(
            getHeroesFromServerUsecase: i(),
            getHeroesFromLocalUsecase: i(),
            putHeroesToServerUsecase: i(),
          ),
        ),
        // Usecases
        Bind((i) => GetHeroesFromServerUsecase(repository: i())),
        Bind((i) => GetHeroesFromLocalUsecase(repository: i())),
        Bind((i) => PutHeroesToServerUsecase(repository: i())),
        Bind((i) => DeleteHeroesFromLocalUsecase(repository: i())),
        // Repositories
        Bind(
          (i) => CharactersRepository(
            remoteDatasource: i(),
            localDatasource: i(),
          ),
        ),
        // Datasources
        Bind((i) => RemoteDatasource(dio: i(), apiConfig: i())),
        Bind((i) => LocalDatasource(hiveBox: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(SplashModule.routeName, module: SplashModule()),
        ModuleRoute(HomeModule.routeName, module: HomeModule()),
        ModuleRoute(DetailsModule.routeName, module: DetailsModule())
      ];
}
