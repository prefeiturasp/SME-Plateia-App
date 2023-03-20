import 'package:equatable/equatable.dart';

class Autenticacao extends Equatable {
  final String token;

  Autenticacao({
    required this.token,
  });

  @override
  List<Object?> get props => [token];
}
