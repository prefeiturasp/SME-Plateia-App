import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_remote_data_source.dart';

import 'package:sme_plateia/features/auth/data/datasources/autenticacao_remote_service.dart';
import 'package:sme_plateia/features/auth/data/models/autenticacao.model.dart';
import 'package:sme_plateia/features/auth/data/models/usuario.model.dart';

import '../../../../../../fixtures/fixture_reader.dart';
import 'autenticacao_remote_data_source_test.mocks.dart';

@GenerateMocks([
  AutenticacaoRemoteService,
])
void main() {
  String featurePath = 'test/fixtures/autenticacao';

  late AutenticacaoRemoteDataSource dataSourceImpl;
  late MockAutenticacaoRemoteService mockAutenticacaoRemoteService;

  setUp(() {
    mockAutenticacaoRemoteService = MockAutenticacaoRemoteService();

    dataSourceImpl = AutenticacaoRemoteDataSource(mockAutenticacaoRemoteService);
  });

  group('autenticar', () {
    const String tRf = 'rf';
    const String tSenha = 'senha';
    final AutenticacaoModel tAutenticacaoModel = AutenticacaoModel(
      token: '123456',
      refreshToken: 'refresh',
      usuario: UsuarioModel(
        nome: 'Nome',
        rf: '12345678',
      ),
    );

    test('deve retornar o objeto do token do usuario se a requisição for bem sucedida', () async {
      //arrange
      when(mockAutenticacaoRemoteService.autenticar(rf: tRf, senha: tSenha)).thenAnswer(
        (_) async => HttpResponse(
          AutenticacaoModel.fromJson(jsonDecode(fixture(featurePath, 'autenticacao.json'))),
          Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );
      //act
      final result = await dataSourceImpl.autenticar(login: tRf, senha: tSenha);

      //assert

      expect(result, equals(tAutenticacaoModel));
    });

    test('should throw an exception if the status code is not 200', () async {
      //arrange

      when(mockAutenticacaoRemoteService.autenticar(rf: tRf, senha: tSenha)).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );

      //act
      final call = dataSourceImpl.autenticar;

      //assert
      expect(() => call(login: tRf, senha: tSenha), throwsA(isA<Failure>()));
    });
  });
}
