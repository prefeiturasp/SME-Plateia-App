import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String accessToken);
  Future<bool> deleteAccessToken();

  Future<String?> getRefreshToken();
  Future<void> saveRefreshToken(String refreshToken);
  Future<bool> deleteRefreshToken();

  Future<void> removeTokens();
}

@Singleton(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  const LocalStorageImpl(this._storage);
  final SharedPreferences _storage;
  static const _apiAccessToken = 'accessToken';
  static const _apiRefreshToken = 'refreshToken';

  @override
  Future<String?> getAccessToken() {
    return Future.value(
      _storage.getString(_apiAccessToken),
    );
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    await Future.value(
      _storage.setString(_apiAccessToken, accessToken),
    );
  }

  @override
  Future<String?> getRefreshToken() {
    return Future.value(
      _storage.getString(_apiRefreshToken),
    );
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await Future.value(
      _storage.setString(_apiRefreshToken, refreshToken),
    );
  }

  @override
  Future<bool> deleteAccessToken() async {
    return await _storage.remove(_apiAccessToken);
  }

  @override
  Future<bool> deleteRefreshToken() async {
    return await _storage.remove(_apiRefreshToken);
  }

  @override
  Future<void> removeTokens() async {
    await deleteAccessToken();
    await deleteRefreshToken();
  }
}
