import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

part 'voucher.model.freezed.dart';
part 'voucher.model.g.dart';

@freezed
class VoucherModel with _$VoucherModel {
  const VoucherModel._();

  factory VoucherModel({
    @JsonKey(name: "inscricao_id") required int inscricaoId,
    required String qrcode,
    required String voucher,
  }) = _VoucherModel;
  factory VoucherModel.fromJson(Map<String, dynamic> json) => _$VoucherModelFromJson(json);

  Voucher toDomain() => Voucher(
        inscricaoId: inscricaoId,
        qrcode: qrcode,
        voucher: voucher,
      );
}
