import 'package:dartz/dartz.dart';

import 'package:marvelapp/app/core/domain/repositories/i_characters_repository.dart';
import 'package:marvelapp/app/core/error/failures.dart';
import 'package:marvelapp/app/core/usecases/i_usecase.dart';

import '../domain/entities/char_entity.dart';

class DeleteHeroesFromLocalUsecase implements UseCase<List<Char>, NoParams> {
  final ICharactersRepository _repository;
  DeleteHeroesFromLocalUsecase({
    required ICharactersRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<IFailure, List<Char>>> call(params) async {
    return await _repository.getHeroesFromLocal();
  }
}
