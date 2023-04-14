import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class VoucherFile extends Equatable {
  @primaryKey
  final String voucherId;
  final String voucher;

  VoucherFile({
    required this.voucherId,
    required this.voucher,
  });

  @override
  List<Object?> get props => [voucherId, voucher];
}
