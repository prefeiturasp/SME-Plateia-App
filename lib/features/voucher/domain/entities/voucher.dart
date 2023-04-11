class Voucher {
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

  Voucher({
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

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      inscricao_id: json['inscricao_id'],
      nome: json['nome'],
      rf: json['rf'],
      evento: json['evento'],
      data: json['data'],
      horario: json['horario'],
      local: json['local'],
      endereco: json['endereco'],
      categoria: json['categoria'],
      ingressos_por_membro: json['ingressos_por_membro'],
      qrcode: json['qrcode'],
    );
  }
}
