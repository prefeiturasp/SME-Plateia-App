import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_plateia/core/domain/failures/failure.codegen.dart';
import 'package:sme_plateia/core/utils/constants.dart';
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:sme_plateia/features/auth/data/models/autenticacao.model.dart';
import 'package:sme_plateia/features/auth/data/models/usuario.model.dart';

import '../../../../../../fixtures/fixture_reader.dart';
import 'autenticacao_local_datasource_test.mocks.dart';

@GenerateMocks([
  SharedPreferences,
])
void main() {
  String featurePath = 'test/fixtures/autenticacao';

  late MockSharedPreferences mockSharedPreferences;
  late AutenticacaoLocalDataSource dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = AutenticacaoLocalDataSource(sharedPreferences: mockSharedPreferences);
  });

  group('getLastToken', () {
    final AutenticacaoModel tAutenticacaoModel =
        AutenticacaoModel.fromJson(jsonDecode(fixture(featurePath, 'autenticacao.json')));

    test('deve retornar o ultimo token guardado (cacheado)', () async {
      //arrange
      when(mockSharedPreferences.getString(CACHED_TOKEN)).thenReturn(fixture(featurePath, 'autenticacao.json'));

      //act
      final result = await dataSourceImpl.getLastToken();

      //assert
      verify(mockSharedPreferences.getString(CACHED_TOKEN));
      expect(result, tAutenticacaoModel);
    });

    test('deve retornar CacheException quando não existe nenhum token salvo', () async {
      //arrange
      when(mockSharedPreferences.getString(CACHED_TOKEN))
          .thenThrow(Failure.localFailure(message: 'Erro ao obter cache'));

      //act
      final call = dataSourceImpl.getLastToken;

      //assert
      expect(() => call(), throwsA(isA<Failure>()));
    });
  });

  group('cacheToken', () {
    final AutenticacaoModel tAutenticacaoModel = AutenticacaoModel(
      token: '123456',
      refreshToken: 'refresh',
      usuario: UsuarioModel(
        nome: 'Nome',
        rf: '12345678',
      ),
    );

    test('deve salvar o token', () async {
      //arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

      //act
      dataSourceImpl.cacheToken(tAutenticacaoModel);

      //assert
      verify(mockSharedPreferences.setString(CACHED_TOKEN, jsonEncode(tAutenticacaoModel)));
    });
  });
}
