import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/features/voucher/data/models/voucher.model.dart';

part 'voucher_remote_service.g.dart';

@RestApi()
@singleton
abstract class VoucherRemoteService {
  @factoryMethod
  factory VoucherRemoteService(Dio dio) = _VoucherRemoteService;

  @GET('/api/v1/inscricao/{id}/voucher')
  Future<HttpResponse<VoucherModel>> getVoucherById(@Path('id') String id);
}
