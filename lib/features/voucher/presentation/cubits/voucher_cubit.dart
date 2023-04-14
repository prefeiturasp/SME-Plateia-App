import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/usecases/download_and_save_file_usecase.dart';
import 'package:sme_plateia/core/utils/base64.dart';
import 'package:sme_plateia/features/voucher/domain/usecases/voucher_usecase.dart';
import 'package:sme_plateia/features/voucher/presentation/cubits/voucher_state.dart';

@singleton
class VoucherCubit extends Cubit<VoucherState> {
  final VoucherUseCase voucherUseCase;
  final DownloadAndSaveFileUseCase downloadAndSaveFileUseCase;
  final Base64Utils base64Utils;

  VoucherCubit(this.voucherUseCase, this.base64Utils, this.downloadAndSaveFileUseCase) : super(VoucherInitial());

  Future<void> getVoucher(String id) async {
    emit(VoucherLoading());
    final result = await voucherUseCase.getVoucherById(id);
    result.fold(
      (failure) => emit(VoucherError('Erro ao buscar voucher')),
      (voucher) => emit(VoucherLoaded(voucher)),
    );
  }

  Future<void> getVoucherFile(String id) async {
    emit(VoucherLoading());
    final result = await voucherUseCase.getVoucherFileById(id);
    result.fold(
      (failure) => emit(VoucherError('Erro ao buscar voucher file')),
      (voucherFile) => emit(VoucherFileLoaded(voucherFile)),
    );
  }

  Future<void> openVoucherFile(String id) async {
    emit(VoucherLoading());
    final result = await voucherUseCase.getVoucherFileById(id);
    result.fold(
      (failure) => emit(VoucherError('Erro ao buscar voucher file')),
      (voucherFile) async {
        String base64Formatted = base64Utils.removeBase64Header('data:application/pdf;base64,', voucherFile.voucher);
        Uint8List bytesFile = base64Utils.getBinaryDataFromBase64(base64Formatted);
        final resultBinaryData = await downloadAndSaveFileUseCase.writeFile('voucher.pdf', bytesFile);
        resultBinaryData.fold((failure) => null, (file) async {
          downloadAndSaveFileUseCase.openFile(file);
        });
      },
    );
  }

  Uint8List getBase64QrcodeImage(String base64) {
    final normalized = base64Utils.removeBase64Header('data:image\\/\\w+;base64,', base64);
    return base64Utils.getBinaryDataFromBase64(normalized);
  }
}
