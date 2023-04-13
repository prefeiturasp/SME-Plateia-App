import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher_file.dart';

part 'voucher_file.model.g.dart';

@JsonSerializable(explicitToJson: true)
class VoucherFileModel {
  const VoucherFileModel(
      {required this.voucher, this.voucher_id = 'default_value'});

  factory VoucherFileModel.fromJson(Map<String, dynamic> json) =>
      _$VoucherFileModelFromJson(json);

  final String voucher;
  final String voucher_id;

  VoucherFile toDomain() =>
      VoucherFile(voucher: voucher, voucher_id: voucher_id);
}
