import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sme_plateia/features/voucher/domain/entities/voucher.dart';

part 'voucher.model.g.dart';

@JsonSerializable(explicitToJson: true)
class VoucherModel {
  const VoucherModel({
    required this.inscricaoId,
    required this.nome,
    required this.rf,
    required this.evento,
    required this.data,
    required this.horario,
    required this.local,
    required this.endereco,
    required this.categoria,
    required this.ingressosPorMembro,
    required this.qrcode,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) =>
      _$VoucherModelFromJson(json);

  final String inscricaoId;
  final String nome;
  final String rf;
  final String evento;
  final String data;
  final String horario;
  final String local;
  final String endereco;
  final String categoria;
  final String ingressosPorMembro;
  final String qrcode;

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
