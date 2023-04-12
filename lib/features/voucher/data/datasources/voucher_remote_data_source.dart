import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/app/network/dio_client.dart';
import 'package:sme_plateia/features/voucher/data/models/voucher.model.dart';
import 'package:sme_plateia/features/voucher/data/models/voucher_file.model.dart';

import 'voucher_remote_service.dart';

abstract class IVoucherRemoteDataSource {
  Future<VoucherModel> getVoucherById({required String id});
  Future<VoucherFileModel> getVoucheFilerById({required String id});
}

@Injectable(as: IVoucherRemoteDataSource)
class VoucherRemoteDataSource implements IVoucherRemoteDataSource {
  VoucherRemoteService voucherRemoteService;

  VoucherRemoteDataSource(this.voucherRemoteService);

  @override
  Future<VoucherModel> getVoucherById({
    required String id,
  }) async {
    try {
      final response = await voucherRemoteService.getVoucherById(id);

      return response.data;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }

  @override
  Future<VoucherModel> getVoucheFilerById({
    required String id,
  }) async {
    try {
      final response = await voucherRemoteService.getVoucherFileById(id);

      return response.data;
    } on DioError catch (e) {
      throw handleNertorkError(e);
    }
  }
}
