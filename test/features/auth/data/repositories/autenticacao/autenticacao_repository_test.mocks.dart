// Mocks generated by Mockito 5.4.0 from annotations
// in sme_plateia/test/features/auth/data/repositories/autenticacao/autenticacao_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:sme_plateia/app/network/network_info.dart' as _i9;
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_local_datasource.dart'
    as _i8;
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_remote_data_source.dart'
    as _i6;
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_remote_service.dart'
    as _i2;
import 'package:sme_plateia/features/auth/data/models/autenticacao.model.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAutenticacaoRemoteService_0 extends _i1.SmartFake
    implements _i2.AutenticacaoRemoteService {
  _FakeAutenticacaoRemoteService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAutenticacaoModel_1 extends _i1.SmartFake
    implements _i3.AutenticacaoModel {
  _FakeAutenticacaoModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSharedPreferences_2 extends _i1.SmartFake
    implements _i4.SharedPreferences {
  _FakeSharedPreferences_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeInternetConnectionCheckerPlus_3 extends _i1.SmartFake
    implements _i5.InternetConnectionCheckerPlus {
  _FakeInternetConnectionCheckerPlus_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AutenticacaoRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAutenticacaoRemoteDataSource extends _i1.Mock
    implements _i6.AutenticacaoRemoteDataSource {
  MockAutenticacaoRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AutenticacaoRemoteService get autenticacaoRemoteService =>
      (super.noSuchMethod(
        Invocation.getter(#autenticacaoRemoteService),
        returnValue: _FakeAutenticacaoRemoteService_0(
          this,
          Invocation.getter(#autenticacaoRemoteService),
        ),
      ) as _i2.AutenticacaoRemoteService);
  @override
  set autenticacaoRemoteService(
          _i2.AutenticacaoRemoteService? _autenticacaoRemoteService) =>
      super.noSuchMethod(
        Invocation.setter(
          #autenticacaoRemoteService,
          _autenticacaoRemoteService,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<_i3.AutenticacaoModel> autenticar({
    required String? login,
    required String? senha,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #autenticar,
          [],
          {
            #login: login,
            #senha: senha,
          },
        ),
        returnValue:
            _i7.Future<_i3.AutenticacaoModel>.value(_FakeAutenticacaoModel_1(
          this,
          Invocation.method(
            #autenticar,
            [],
            {
              #login: login,
              #senha: senha,
            },
          ),
        )),
      ) as _i7.Future<_i3.AutenticacaoModel>);
  @override
  _i7.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [AutenticacaoLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAutenticacaoLocalDataSource extends _i1.Mock
    implements _i8.AutenticacaoLocalDataSource {
  MockAutenticacaoLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.SharedPreferences get sharedPreferences => (super.noSuchMethod(
        Invocation.getter(#sharedPreferences),
        returnValue: _FakeSharedPreferences_2(
          this,
          Invocation.getter(#sharedPreferences),
        ),
      ) as _i4.SharedPreferences);
  @override
  _i7.Future<void> cacheToken(_i3.AutenticacaoModel? loginModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheToken,
          [loginModel],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i3.AutenticacaoModel?> getLastToken() => (super.noSuchMethod(
        Invocation.method(
          #getLastToken,
          [],
        ),
        returnValue: _i7.Future<_i3.AutenticacaoModel?>.value(),
      ) as _i7.Future<_i3.AutenticacaoModel?>);
  @override
  _i7.Future<bool> apagarToken() => (super.noSuchMethod(
        Invocation.method(
          #apagarToken,
          [],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i9.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.InternetConnectionCheckerPlus get internetConnectionCheckerPlus =>
      (super.noSuchMethod(
        Invocation.getter(#internetConnectionCheckerPlus),
        returnValue: _FakeInternetConnectionCheckerPlus_3(
          this,
          Invocation.getter(#internetConnectionCheckerPlus),
        ),
      ) as _i5.InternetConnectionCheckerPlus);
  @override
  set internetConnectionCheckerPlus(
          _i5.InternetConnectionCheckerPlus? _internetConnectionCheckerPlus) =>
      super.noSuchMethod(
        Invocation.setter(
          #internetConnectionCheckerPlus,
          _internetConnectionCheckerPlus,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
}
