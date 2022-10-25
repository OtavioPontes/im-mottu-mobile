import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:marvelapp/app/core/data/datasources/i_local_datasouce.dart';
import 'package:marvelapp/app/core/data/models/char_model.dart';
import 'package:marvelapp/app/core/error/exceptions.dart';

class LocalDatasource implements ILocalDatasource {
  final Box _hiveBox;

  LocalDatasource({
    required Box hiveBox,
  }) : _hiveBox = hiveBox;

  @override
  Future<List<CharModel>> getHeroes() async {
    try {
      final heroes = jsonDecode(await _hiveBox.get('heroes'));
      return List.generate(
        heroes.length,
        (i) => CharModel.fromJson(
          heroes[i],
        ),
      );
    } catch (e) {
      throw InternalException(
        message: 'Error on Recover Heroes Locally',
      );
    }
  }

  @override
  Future<void> putHeroes({required List<CharModel> heroes}) async {
    try {
      await _hiveBox.put(
        'heroes',
        jsonEncode(
          heroes.map((e) => e.toJson()).toList(),
        ),
      );
    } on HiveError {
      throw InternalException(
        message: 'Error on Saving Heroes Locally',
      );
    }
  }

  @override
  Future<void> deleteHeroes() async {
    try {
      await _hiveBox.delete('heroes');
    } on HiveError {
      throw InternalException(
        message: 'Error on Deleting Heroes Locally',
      );
    }
  }
}
