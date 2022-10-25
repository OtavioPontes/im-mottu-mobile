import 'package:dartz/dartz.dart';
import 'package:marvelapp/app/core/error/failures.dart';

import '../entities/char_entity.dart';

abstract class ICharactersRepository {
  Future<Either<IFailure, List<Char>>> getHeroes({
    final String? nameStartsWith,
    final int? offset,
  });
  Future<Either<IFailure, List<Char>>> getHeroesFromLocal();
  Future<Either<IFailure, void>> putHeroesToLocal({
    required List<Char> heroes,
  });
  Future<Either<IFailure, void>> deleteHeroes();
  Future<Either<IFailure, List<Char>>> getRelatedHeroes({required int id});
}
