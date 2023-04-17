import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/utils/base64.dart';
import 'package:sme_plateia/features/voucher/domain/usecases/voucher_usecase.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_state.dart';
import 'package:sme_plateia/shared/openfile/domain/usecases/download_and_save_file_usecase.dart';

@singleton
class VoucherCubit extends Cubit<VoucherState> {
  final VoucherUseCase voucherUseCase;
  final DownloadAndSaveFileUseCase downloadAndSaveFileUseCase;
  final Base64Utils base64Utils;

  VoucherCubit(this.voucherUseCase, this.base64Utils, this.downloadAndSaveFileUseCase) : super(VoucherInitial());

  Future<void> getVoucher(int inscricaoId) async {
    emit(VoucherLoading());
    final result = await voucherUseCase.getVoucherById(inscricaoId);
    result.fold(
      (failure) => emit(VoucherError('Erro ao buscar voucher')),
      (voucher) => emit(VoucherLoaded(voucher)),
    );
  }

  Future<void> openVoucherPDF(String base64PDF) async {
    await voucherUseCase.openVoucherPDF(base64PDF);
  }

  Uint8List getBase64QrcodeImage(String base64) {
    final normalized = base64Utils.removeBase64Header('data:image\\/\\w+;base64,', base64);
    return base64Utils.getBinaryDataFromBase64(normalized);
  }
}
