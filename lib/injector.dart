import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:template/injector.config.dart';

final sl = GetIt.instance;

@InjectableInit(generateForDir: ['lib', 'test'])
Future<void> configureDependencies({required String environment}) async => sl.init(environment: environment);
