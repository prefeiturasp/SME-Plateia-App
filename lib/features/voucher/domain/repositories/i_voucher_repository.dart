import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher_file.dart';

abstract class IVoucherRepository {
  Future<Either<Failure, Voucher>> getVoucherById(String id);
  Future<Either<Failure, VoucherFile>> getVoucherFileById(String id);
}
