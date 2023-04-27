import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sme_plateia/features/auth/data/models/autenticacao.model.dart';
import 'package:sme_plateia/features/auth/data/models/usuario.model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  String featurePath = 'test/fixtures/autenticacao';

  final tAutenticaoModel = AutenticacaoModel(
    accessToken: '123456',
    refreshToken: 'refresh',
    usuario: UsuarioModel(
      nome: 'Nome',
      rf: '12345678',
    ),
  );

  // test('should be a subclass of User entity', () async {
  //   //assert
  //   expect(tAutenticaoModel, isA<Autenticacao>());
  // });

  group('fromJson', () {
    test('deve retornar um modelo valido do JSON', () async {
      //Arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture(featurePath, 'autenticacao.json'));

      //Act
      final result = AutenticacaoModel.fromJson(jsonMap);

      //Assert
      expect(result, equals(tAutenticaoModel));
    });
  });

  group('toJson', () {
    test('deve retornar um map do JSON contendo o valor apropriado', () async {
      //Act
      final result = tAutenticaoModel.toJson();

      //Assert
      final expectedMap = {
        'access': '123456',
        'refresh': 'refresh',
        'user': {
          'name': 'Nome',
          'rf': '12345678',
        }
      };

      expect(result, expectedMap);
    });
  });
}
