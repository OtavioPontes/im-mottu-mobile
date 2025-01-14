import 'package:dartz/dartz.dart';

import 'package:marvelapp/app/core/domain/repositories/i_characters_repository.dart';
import 'package:marvelapp/app/core/error/failures.dart';
import 'package:marvelapp/app/core/usecases/i_usecase.dart';

import '../domain/entities/char_entity.dart';

class GetHeroesFromServerUsecase
    implements UseCase<List<Char>, ParamsGetHeroesFromServerUsecase> {
  final ICharactersRepository _repository;
  GetHeroesFromServerUsecase({
    required ICharactersRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<IFailure, List<Char>>> call(params) async {
    return await _repository.getHeroes(
      nameStartsWith: params.nameStartsWith,
      offset: params.offset,
    );
  }
}

class ParamsGetHeroesFromServerUsecase extends IParams {
  final String? nameStartsWith;
  final int? offset;
  ParamsGetHeroesFromServerUsecase({
    this.nameStartsWith,
    this.offset,
  });
}
