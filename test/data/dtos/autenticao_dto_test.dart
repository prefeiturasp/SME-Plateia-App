import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sme_plateia/data/dtos/autenticao_dto.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tAutenticaoModel = AutenticacaoDto(token: "token");

  test('should be a subclass of User entity', () async {
    //assert
    expect(tAutenticaoModel, isA<Autenticacao>());
  });

  group('fromJson', () {
    test('deve retornar um modelo valido do JSON', () async {
      //Arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('autenticacao/autenticacao.json'));

      //Act
      final result = AutenticacaoDto.fromJson(jsonMap);

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
        "token": "token",
      };

      expect(result, expectedMap);
    });
  });
}
