import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/app/network/dio_client.dart';

import 'local_evento_remote_service.dart';

abstract class ILocalEventoRemoteDataSource {
  Future<List<String>> obterLocais({
    required String termo,
  });
}

@LazySingleton(as: ILocalEventoRemoteDataSource)
class LocalEventoRemoteDataSource implements ILocalEventoRemoteDataSource {
  final LocalEventoRemoteService localEventoRemoteService;

  LocalEventoRemoteDataSource(this.localEventoRemoteService);

  @override
  Future<List<String>> obterLocais({required String termo}) async {
    try {
      final response = await localEventoRemoteService.obterLocais(
        termo: termo,
      );

      return response.data;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }
}
