import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

part 'voucher.model.freezed.dart';
part 'voucher.model.g.dart';

@freezed
class VoucherModel with _$VoucherModel {
  const VoucherModel._();

  factory VoucherModel({
    @JsonKey(name: "inscricao_id") required String inscricaoId,
    required String nome,
    required String rf,
    required String evento,
    required String data,
    required String horario,
    required String local,
    required String endereco,
    required String categoria,
    @JsonKey(name: "ingressos_por_membro") required String ingressosPorMembro,
    required String qrcode,
  }) = _VoucherModel;
  factory VoucherModel.fromJson(Map<String, dynamic> json) => _$VoucherModelFromJson(json);

  Voucher toDomain() => Voucher(
        inscricaoId: inscricaoId,
        nome: nome,
        rf: rf,
        evento: evento,
        data: data,
        horario: horario,
        local: local,
        endereco: endereco,
        categoria: categoria,
        ingressosPorMembro: ingressosPorMembro,
        qrcode: qrcode,
      );
}
