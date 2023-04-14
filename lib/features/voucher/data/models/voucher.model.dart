import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

part 'voucher.model.g.dart';

@JsonSerializable(explicitToJson: true)
class VoucherModel {
  const VoucherModel({
    required this.inscricao_id,
    required this.nome,
    required this.rf,
    required this.evento,
    required this.data,
    required this.horario,
    required this.local,
    required this.endereco,
    required this.categoria,
    required this.ingressos_por_membro,
    required this.qrcode,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) => _$VoucherModelFromJson(json);

  final String inscricao_id;
  final String nome;
  final String rf;
  final String evento;
  final String data;
  final String horario;
  final String local;
  final String endereco;
  final String categoria;
  final String ingressos_por_membro;
  final String qrcode;

  Voucher toDomain() => Voucher(
        inscricao_id: inscricao_id,
        nome: nome,
        rf: rf,
        evento: evento,
        data: data,
        horario: horario,
        local: local,
        endereco: endereco,
        categoria: categoria,
        ingressos_por_membro: ingressos_por_membro,
        qrcode: qrcode,
      );
}
