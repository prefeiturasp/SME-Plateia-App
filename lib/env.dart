// ignore_for_file: constant_identifier_names

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'URL_API')
  static const URL_API = _Env.URL_API;

  @EnviedField(varName: 'URL_RECUPERAR_SENHA')
  static const URL_RECUPERAR_SENHA = _Env.URL_RECUPERAR_SENHA;
}
