import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'local_evento_remote_service.g.dart';

@RestApi()
@singleton
abstract class LocalEventoRemoteService {
  @factoryMethod
  factory LocalEventoRemoteService(Dio dio) = _LocalEventoRemoteService;

  @GET('/locais_meus_eventos')
  Future<HttpResponse<List<String>>> obterLocais({
    @Query('termo') required String termo,
  });
}
