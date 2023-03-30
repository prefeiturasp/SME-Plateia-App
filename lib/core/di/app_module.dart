import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:template/app/network/dio_client.dart';

@module
abstract class AppModule {
  @lazySingleton
  InternetConnectionCheckerPlus get internetConnectionCheckerPlus => InternetConnectionCheckerPlus();

  @lazySingleton
  @preResolve
  Future<Dio> get dioClient async => DioClient.setup();
}
