import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sme_plateia/domain/entities/autenticacao/autenticacao.dart';
import 'package:sme_plateia/domain/repositories/autenticacao/i_authentication_repository.dart';
import 'package:sme_plateia/domain/usecases/autenticacao/autenticar_usecase.dart';

import 'autenticar_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([
  IAutenticacaoRepository,
])
void main() {
  late AutenticarUseCase useCase;
  late MockIAutenticacaoRepository mockIAutenticacaoRepository;

  setUp(() {
    mockIAutenticacaoRepository = MockIAutenticacaoRepository();
    useCase = AutenticarUseCase(mockIAutenticacaoRepository);
  });

  String tLogin = "login_rf";
  String tSenha = "senha";
  Autenticacao tAutenticacao = Autenticacao(token: "token");

  test(
    'deve retornar o token ao realizar o login',
    () async {
      // arrange
      when(mockIAutenticacaoRepository.autenticar(tLogin, tSenha)).thenAnswer((_) async => Right(tAutenticacao));

      // act
      final result = await useCase(Params(login: tLogin, senha: tSenha));

      //assert
      expect(result, Right(tAutenticacao));
      verify(mockIAutenticacaoRepository.autenticar(tLogin, tSenha));
      verifyNoMoreInteractions(mockIAutenticacaoRepository);
    },
  );
}
