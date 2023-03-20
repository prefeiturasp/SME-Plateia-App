import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_plateia/core/errors/exceptions.dart';
import 'package:sme_plateia/core/utils/constants.dart';
import 'package:sme_plateia/data/dtos/autenticacao/autenticacao_dto.dart';

abstract class IAutenticacaoLocalDataSource {
  Future<void> cacheToken(AutenticacaoDto loginModel);
  Future<AutenticacaoDto> getLastToken();
}

@Injectable(as: IAutenticacaoLocalDataSource)
class AutenticacaoLocalDataSource implements IAutenticacaoLocalDataSource {
  final SharedPreferences sharedPreferences;

  AutenticacaoLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheToken(AutenticacaoDto loginModel) {
    return sharedPreferences.setString(CACHED_TOKEN, jsonEncode(loginModel));
  }

  @override
  Future<AutenticacaoDto> getLastToken() async {
    String? jsonStr = sharedPreferences.getString(CACHED_TOKEN);
    if (jsonStr == null) {
      throw CacheException();
    }
    return AutenticacaoDto.fromJson(jsonDecode(jsonStr));
  }
}
