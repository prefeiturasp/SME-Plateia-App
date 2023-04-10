class Voucher {
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

  Voucher({
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

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      inscricaoId: json['inscricao_id'],
      nome: json['nome'],
      rf: json['rf'],
      evento: json['evento'],
      data: json['data'],
      horario: json['horario'],
      local: json['local'],
      endereco: json['endereco'],
      categoria: json['categoria'],
      ingressosPorMembro: json['ingressos_por_membro'],
      qrcode: json['qrcode'],
    );
  }
}
