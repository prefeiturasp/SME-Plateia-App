import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';
import 'package:sme_plateia/features/voucher/domain/repositories/i_voucher_repository.dart';

@Singleton()
class VoucherUseCase {
  final IVoucherRepository _repository;

  VoucherUseCase(this._repository);

  Future<Either<Failure, Voucher>> getVoucherById(int inscricaoId) async {
    return await _repository.getVoucherById(inscricaoId);
  }

  Future<Either<Failure, Voucher>> getLocalVoucherById(int inscricaoId) async {
    return await _repository.getLocalVoucherById(inscricaoId);
  }

  Future<Either<Failure, void>> openVoucherPDF(String base64PDF) {
    return _repository.openVoucherPDF(base64PDF);
  }
}
