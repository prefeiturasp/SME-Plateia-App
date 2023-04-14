import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';

@entity
class VoucherFile extends Equatable {
  @primaryKey
  final String voucher_id;
  final String voucher;

  VoucherFile({
    required this.voucher_id,
    required this.voucher,
  });

  @override
  List<Object?> get props => [voucher_id, voucher];
}
