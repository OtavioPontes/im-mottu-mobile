import 'package:dartz/dartz.dart';
import 'package:marvelapp/app/core/data/datasources/i_local_datasouce.dart';

import 'package:marvelapp/app/core/data/datasources/i_remote_datasource.dart';
import 'package:marvelapp/app/core/domain/entities/char_entity.dart';
import 'package:marvelapp/app/core/domain/repositories/i_characters_repository.dart';
import 'package:marvelapp/app/core/error/exceptions.dart';
import 'package:marvelapp/app/core/error/failures.dart';
import 'package:marvelapp/app/core/usecases/i_usecase.dart';

import '../models/char_model.dart';

class CharactersRepository implements ICharactersRepository {
  final IRemoteDatasource _remoteDatasource;
  final ILocalDatasource _localDatasource;
  CharactersRepository({
    required IRemoteDatasource remoteDatasource,
    required ILocalDatasource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

  @override
  Future<Either<IFailure, List<Char>>> getHeroes({
    final String? nameStartsWith,
    final int? offset,
  }) async {
    try {
      List<CharModel> listHeroes = await _remoteDatasource.getHeroes(
        offset: offset,
        startsWith: nameStartsWith,
      );
      return Right(listHeroes.map((e) => e.toEntity()).toList());
    } on InternetException catch (_) {
      return const Left(
        InternalFailure(
          message: 'Error on assembling heroes from server',
        ),
      );
    }
  }

  @override
  Future<Either<IFailure, List<Char>>> getHeroesFromLocal() async {
    try {
      List<CharModel> listHeroes = await _localDatasource.getHeroes();
      return Right(listHeroes.map((e) => e.toEntity()).toList());
    } on InternetException catch (_) {
      return const Left(
        InternalFailure(
          message: 'Error on assembling heroes from local',
        ),
      );
    }
  }

  @override
  Future<Either<IFailure, void>> putHeroesToLocal(
      {required List<Char> heroes}) async {
    try {
      await _localDatasource.putHeroes(
        heroes: heroes
            .map(
              (e) => CharModel.fromEntity(heroe: e),
            )
            .toList(),
      );
      return Right(voidRight);
    } on InternetException catch (_) {
      return const Left(
        InternalFailure(
          message: 'Error on putting heroes to server',
        ),
      );
    }
  }

  @override
  Future<Either<IFailure, void>> deleteHeroes() async {
    try {
      await _localDatasource.deleteHeroes();
      return Right(voidRight);
    } catch (_) {
      return const Left(
        InternalFailure(
          message: 'Error on putting heroes to server',
        ),
      );
    }
  }
}
