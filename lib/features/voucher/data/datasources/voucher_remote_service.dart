import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/features/voucher/data/models/voucher.model.dart';
import 'package:sme_plateia/features/voucher/data/models/voucher_file.model.dart';

part 'voucher_remote_service.g.dart';

@RestApi()
@singleton
abstract class VoucherRemoteService {
  @factoryMethod
  factory VoucherRemoteService(Dio dio) = _VoucherRemoteService;

  @GET('/inscricao/{id}/voucher')
  Future<HttpResponse<VoucherModel>> getVoucherById(@Path('id') String id);

  @GET('/inscricao/{id}/voucher/pdf')
  Future<HttpResponse<VoucherFileModel>> getVoucherFileById(
      @Path('id') String id);
}
