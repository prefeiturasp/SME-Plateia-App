import 'package:floor/floor.dart';
import 'package:sme_plateia/core/interfaces/i_crud.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

@dao
abstract class VoucherDao extends ICrud<Voucher> {
  @Query('SELECT * FROM Voucher WHERE inscricaoId = :inscricaoId')
  Future<Voucher?> findById(int inscricaoId);

  @Query('DELETE FROM Voucher')
  Future<void> deleteAll();
}
