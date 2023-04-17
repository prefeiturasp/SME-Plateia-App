import 'package:dartz/dartz.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

abstract class IVoucherRepository {
  Future<Either<Failure, Voucher>> getVoucherById(int id);
  Future<void> openVoucherPDF(String base64PDF);
}
