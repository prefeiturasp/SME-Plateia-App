import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_plateia/core/errors/exceptions.dart';
import 'package:sme_plateia/core/utils/constants.dart';
import 'package:sme_plateia/data/models/autenticao_model.dart';

abstract class IAutenticacaoLocalDataSource {
  Future<void> cacheToken(AutenticacaoModel loginModel);
  Future<AutenticacaoModel> getLastToken();
}

@Injectable(as: IAutenticacaoLocalDataSource)
class AutenticacaoLocalDataSource implements IAutenticacaoLocalDataSource {
  final SharedPreferences sharedPreferences;

  AutenticacaoLocalDataSource({
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheToken(AutenticacaoModel loginModel) {
    return sharedPreferences.setString(CACHED_TOKEN, jsonEncode(loginModel));
  }

  @override
  Future<AutenticacaoModel> getLastToken() async {
    String? jsonStr = sharedPreferences.getString(CACHED_TOKEN);
    if (jsonStr == null) {
      throw CacheException();
    }
    return AutenticacaoModel.fromJson(jsonDecode(jsonStr));
  }
}
