import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sme_plateia/core/database/app_database.dart';
import 'package:sme_plateia/core/utils/constants.dart';

@module
abstract class AppModule {
  @lazySingleton
  InternetConnectionCheckerPlus get internetConnectionCheckerPlus => InternetConnectionCheckerPlus();

  @preResolve
  Future<AppDatabase> get appDatabase => $FloorAppDatabase.databaseBuilder(DATABASE_NAME).build();
}
