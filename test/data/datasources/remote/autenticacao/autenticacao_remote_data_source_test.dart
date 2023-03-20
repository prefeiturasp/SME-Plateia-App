import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sme_plateia/core/errors/exceptions.dart';

import 'package:sme_plateia/data/datasources/remote/autenticacao/autenticacao_remote_data_source.dart';
import 'package:sme_plateia/data/datasources/remote/autenticacao/autenticacao_remote_service.dart';
import 'package:sme_plateia/data/dtos/autenticao_dto.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'autenticacao_remote_data_source_test.mocks.dart';

@GenerateMocks([
  AutenticacaoRemoteService,
])
void main() {
  late AutenticacaoRemoteDataSource dataSourceImpl;
  late MockAutenticacaoRemoteService mockAutenticacaoRemoteService;

  setUp(() {
    mockAutenticacaoRemoteService = MockAutenticacaoRemoteService();

    dataSourceImpl = AutenticacaoRemoteDataSource(mockAutenticacaoRemoteService);
  });

  group('autenticar', () {
    const String tLogin = 'login';
    const String tSenha = 'senha';
    final AutenticacaoDto tAutenticacaoDto = AutenticacaoDto(token: 'token');

    test('deve retornar o objeto do token do usuario se a requisição for bem sucedida', () async {
      //arrange
      when(mockAutenticacaoRemoteService.autenticar(login: tLogin, senha: tSenha)).thenAnswer(
        (_) async => HttpResponse(
          AutenticacaoDto.fromJson(jsonDecode(fixture('autenticacao/autenticacao.json'))),
          Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );
      //act
      final result = await dataSourceImpl.autenticar(login: tLogin, senha: tSenha);

      //assert

      expect(result, equals(tAutenticacaoDto));
    });

    test('should throw an exception if the status code is not 200', () async {
      //arrange

      when(mockAutenticacaoRemoteService.autenticar(login: tLogin, senha: tSenha)).thenThrow(
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
      expect(() => call(login: tLogin, senha: tSenha), throwsA(isA<ServerException>()));
    });
  });
}
