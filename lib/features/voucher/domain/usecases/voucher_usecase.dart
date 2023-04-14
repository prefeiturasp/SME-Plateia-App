import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher_file.dart';
import 'package:sme_plateia/features/voucher/domain/repositories/i_voucher_repository.dart';

@Singleton()
class VoucherUseCase {
  final IVoucherRepository _repository;

  VoucherUseCase(this._repository);

  Future<Either<Failure, Voucher>> getVoucherById(String id) async {
    return await _repository.getVoucherById(id);
  }

  Future<Either<Failure, VoucherFile>> getVoucherFileById(String id) async {
    return await _repository.getVoucherFileById(id);
  }
}
