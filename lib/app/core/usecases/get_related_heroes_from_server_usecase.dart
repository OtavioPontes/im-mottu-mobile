import 'package:dartz/dartz.dart';

import 'package:marvelapp/app/core/domain/repositories/i_characters_repository.dart';
import 'package:marvelapp/app/core/error/failures.dart';
import 'package:marvelapp/app/core/usecases/i_usecase.dart';

import '../domain/entities/char_entity.dart';

class GetRelatedHeroesFromServerUsecase
    implements UseCase<List<Char>, ParamsGeRelatedHeroesFromServerUsecase> {
  final ICharactersRepository _repository;
  GetRelatedHeroesFromServerUsecase({
    required ICharactersRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<IFailure, List<Char>>> call(params) async {
    return await _repository.getRelatedHeroes(id: params.id);
  }
}

class ParamsGeRelatedHeroesFromServerUsecase extends IParams {
  final int id;
  ParamsGeRelatedHeroesFromServerUsecase({
    required this.id,
  });
}
