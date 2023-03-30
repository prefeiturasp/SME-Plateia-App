import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

@Injectable(as: INetworkInfo)
class NetworkInfo implements INetworkInfo {
  InternetConnectionCheckerPlus internetConnectionCheckerPlus;

  NetworkInfo(this.internetConnectionCheckerPlus);

  @override
  Future<bool> get isConnected => internetConnectionCheckerPlus.hasConnection;
}
