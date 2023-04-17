import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Voucher extends Equatable {
  @primaryKey
  final int inscricaoId;
  final String qrcode;
  final String voucher;

  Voucher({required this.inscricaoId, required this.qrcode, required this.voucher});

  @override
  List<Object?> get props => [inscricaoId, qrcode, voucher];
}
