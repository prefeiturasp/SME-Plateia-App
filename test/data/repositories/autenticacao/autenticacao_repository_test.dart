import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sme_plateia/core/errors/exceptions.dart';
import 'package:sme_plateia/core/errors/failures.dart';

import 'package:sme_plateia/core/network/network_info.dart';
import 'package:sme_plateia/data/datasources/local/autenticacao/autenticacao_local_datasource.dart';
import 'package:sme_plateia/data/datasources/remote/autenticacao/autenticacao_remote_data_source.dart';
import 'package:sme_plateia/data/dtos/autenticao_dto.dart';
import 'package:sme_plateia/data/repositories/autenticacao/autenticacao_repository.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';

import 'autenticacao_repository_test.mocks.dart';

@GenerateMocks([
  AutenticacaoRemoteDataSource,
  AutenticacaoLocalDataSource,
  NetworkInfo,
])
void main() {
  late AutenticacaoRepository repository;
  late MockAutenticacaoRemoteDataSource mockRemoteDataSource;
  late MockAutenticacaoLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockAutenticacaoRemoteDataSource();
    mockLocalDataSource = MockAutenticacaoLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = AutenticacaoRepository(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockNetworkInfo,
    );
  });

  String tLogin = 'login';
  String tSenha = 'tenha';
  AutenticacaoDto tAutenticacaoDto = AutenticacaoDto(token: "token");
  Autenticacao tAutenticacao = tAutenticacaoDto;

  group('autenticar', () {
    test('deve verificar se o dispositivo esta online', () async {
      //Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(mockRemoteDataSource.autenticar(login: tLogin, senha: tSenha)).thenAnswer((_) async => tAutenticacao);
      //Act
      repository.autenticar(tLogin, tSenha);
      //Assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('dispositivo esta online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => true);
    });

    test('deve retornar o token quando o dispositivo esta online', () async {
      //Arrange
      when(mockRemoteDataSource.autenticar(login: tLogin, senha: tSenha)).thenAnswer((_) async => tAutenticacaoDto);

      //Act
      final result = await repository.autenticar(tLogin, tSenha);

      //Assert
      verify(mockRemoteDataSource.autenticar(login: tLogin, senha: tSenha));
      expect(result, equals(Right(tAutenticacao)));
    });

    test('deve salvar em cache o token quando a chamada remota tiver sucesso', () async {
      //Arrange
      when(mockRemoteDataSource.autenticar(login: tLogin, senha: tSenha)).thenAnswer((_) async => tAutenticacaoDto);

      //Act
      await repository.autenticar(tLogin, tSenha);

      //Assert
      verify(mockRemoteDataSource.autenticar(login: tLogin, senha: tSenha));
      verify(mockLocalDataSource.cacheToken(tAutenticacaoDto));
    });

    test('deve retornar uma falha quando a chama remota nao tiver sucesso', () async {
      //arrange
      when(mockRemoteDataSource.autenticar(login: tLogin, senha: tSenha)).thenThrow(ServerException());

      //act
      final result = await repository.autenticar(tLogin, tSenha);

      //assert
      verify(mockRemoteDataSource.autenticar(login: tLogin, senha: tSenha));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('dispositivo esta offlne', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((realInvocation) async => false);
    });

    test('deve retornar um NoConnectionFailure se o dispositivo esta offline', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(false));

      //act
      final result = await repository.autenticar(tLogin, tSenha);

      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(NoConnectionFailure())));
    });
  });
}
