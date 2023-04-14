import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher_file.dart';

part 'voucher_file.model.g.dart';

@JsonSerializable(explicitToJson: true)
class VoucherFileModel {
  const VoucherFileModel({
    required this.voucher,
    this.voucherId = 'default_value',
  });

  factory VoucherFileModel.fromJson(Map<String, dynamic> json) => _$VoucherFileModelFromJson(json);

  final String voucher;
  final String voucherId;

  VoucherFile toDomain() {
    return VoucherFile(
      voucher: voucher,
      voucher_id: voucherId,
    );
  }
}
