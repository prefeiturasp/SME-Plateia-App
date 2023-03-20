import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sme_plateia/core/errors/exceptions.dart';
import 'package:sme_plateia/core/utils/constants.dart';
import 'package:sme_plateia/data/datasources/local/autenticacao/autenticacao_local_datasource.dart';
import 'package:sme_plateia/data/dtos/autenticao_dto.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'autenticacao_local_datasource_test.mocks.dart';

@GenerateMocks([
  SharedPreferences,
])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AutenticacaoLocalDataSource dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = AutenticacaoLocalDataSource(sharedPreferences: mockSharedPreferences);
  });

  group('getLastToken', () {
    final AutenticacaoDto tAutenticacaoDto =
        AutenticacaoDto.fromJson(jsonDecode(fixture('autenticacao/autenticacao.json')));

    test('deve retornar o ultimo token guardado (cacheado)', () async {
      //arrange
      when(mockSharedPreferences.getString(CACHED_TOKEN)).thenReturn(fixture('autenticacao/autenticacao.json'));

      //act
      final result = await dataSourceImpl.getLastToken();

      //assert
      verify(mockSharedPreferences.getString(CACHED_TOKEN));
      expect(result, tAutenticacaoDto);
    });

    test('deve retornar CacheException quando não existe nenhum token salvo', () async {
      //arrange
      when(mockSharedPreferences.getString(CACHED_TOKEN)).thenThrow(CacheException());

      //act
      final call = dataSourceImpl.getLastToken;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheToken', () {
    final AutenticacaoDto tAutenticacaoDto = AutenticacaoDto(token: '123456');

    test('deve salvar o token', () async {
      //arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);

      //act
      dataSourceImpl.cacheToken(tAutenticacaoDto);

      //assert
      verify(mockSharedPreferences.setString(CACHED_TOKEN, jsonEncode(tAutenticacaoDto)));
    });
  });
}
