import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_plateia/core/network/dio_client.dart';

@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  InternetConnectionCheckerPlus get internetConnectionCheckerPlus => InternetConnectionCheckerPlus();

  @preResolve
  Future<Dio> get dioClient async => DioClient.setup();
}
