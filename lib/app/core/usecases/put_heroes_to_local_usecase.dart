import 'package:dartz/dartz.dart';

import 'package:marvelapp/app/core/domain/repositories/i_characters_repository.dart';
import 'package:marvelapp/app/core/error/failures.dart';
import 'package:marvelapp/app/core/usecases/i_usecase.dart';

import '../domain/entities/char_entity.dart';

class PutHeroesToServerUsecase
    implements UseCase<void, ParamsPutHeroesToServerUsecase> {
  final ICharactersRepository _repository;
  PutHeroesToServerUsecase({
    required ICharactersRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<IFailure, void>> call(params) async {
    return await _repository.putHeroesToLocal(
      heroes: params.heroes,
    );
  }
}

class ParamsPutHeroesToServerUsecase extends IParams {
  final List<Char> heroes;
  ParamsPutHeroesToServerUsecase({
    required this.heroes,
  });
}
