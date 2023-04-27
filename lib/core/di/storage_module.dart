import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class StorageModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get sharedPreference async => SharedPreferences.getInstance();
}
