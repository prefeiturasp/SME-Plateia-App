import 'package:injectable/injectable.dart';
import 'package:sme_plateia/core/database/app_database.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

abstract class IVoucherLocalDataSource {
  Future<Voucher?> findById(int inscricaoId);
  Future<void> insertOrUpdateEntity(Voucher domain);
}

@Injectable(as: IVoucherLocalDataSource)
class VoucherLocalDataSource implements IVoucherLocalDataSource {
  final AppDatabase appDatabase;

  VoucherLocalDataSource(this.appDatabase);

  @override
  Future<Voucher?> findById(int inscricaoId) {
    return appDatabase.voucherDao.findById(inscricaoId);
  }

  @override
  Future<void> insertOrUpdateEntity(Voucher voucher) {
    return appDatabase.voucherDao.insertOrUpdateEntity(voucher);
  }
}
