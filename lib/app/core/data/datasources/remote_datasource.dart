import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';

import 'package:marvelapp/app/core/data/datasources/i_remote_datasource.dart';
import 'package:marvelapp/app/core/data/models/char_model.dart';
import 'package:marvelapp/app/core/error/exceptions.dart';
import 'package:marvelapp/app/core/network/api_config.dart';
import 'package:marvelapp/app/core/network/keys.dart';
import 'package:marvelapp/app/core/network/uri.dart';

class RemoteDatasource implements IRemoteDatasource {
  final Dio _dio;
  final ApiConfig _apiConfig;
  RemoteDatasource({
    required Dio dio,
    required ApiConfig apiConfig,
  })  : _dio = dio,
        _apiConfig = apiConfig;

  @override
  Future<List<CharModel>> getHeroes({
    String? startsWith,
    int? offset,
  }) async {
    try {
      final date = DateTime.now().millisecondsSinceEpoch.toString();
      final bytes = utf8.encode(
        date + ApiKey.privateKey + ApiKey.publicKey,
      );
      final result = await _dio.get(
        URI.characters,
        queryParameters: {
          'apikey': ApiKey.publicKey,
          'ts': date,
          'hash': crypto.md5.convert(bytes),
          if (startsWith != null) 'nameStartsWith': startsWith,
          'offset': _apiConfig.offset,
        },
      );
      final data = result.data['data']['results'];
      return List<CharModel>.generate(
        data.length,
        (index) {
          return CharModel.fromMap(data[index]);
        },
      );
    } catch (_) {
      throw InternetException(
        message: 'Server Error',
      );
    }
  }
}
