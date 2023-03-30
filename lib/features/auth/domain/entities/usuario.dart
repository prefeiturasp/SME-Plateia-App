import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String nome;
  final String rf;

  Usuario({
    required this.nome,
    required this.rf,
  });

  @override
  List<Object?> get props => [nome, rf];
}
