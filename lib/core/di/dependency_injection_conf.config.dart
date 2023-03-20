// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chopper/chopper.dart' as _i5;
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i8;
import 'package:shared_preferences/shared_preferences.dart' as _i9;
import 'package:sme_plateia/core/network/chopper_client.dart' as _i6;
import 'package:sme_plateia/core/network/network_info.dart' as _i13;
import 'package:sme_plateia/core/routes/routes.dart' as _i3;
import 'package:sme_plateia/core/services/authentication_service.dart' as _i4;
import 'package:sme_plateia/data/datasources/local/autenticacao/autenticacao_local_datasource.dart'
    as _i11;
import 'package:sme_plateia/data/datasources/remote/autenticacao/autenticacao_remote_data_source.dart'
    as _i12;
import 'package:sme_plateia/data/datasources/remote/autenticacao/autenticacao_remote_service.dart'
    as _i10;
import 'package:sme_plateia/data/repositories/autenticacao/autenticacao_repository.dart'
    as _i15;
import 'package:sme_plateia/domain/repositories/autenticacao/i_authentication_repository.dart'
    as _i14;
import 'package:sme_plateia/domain/usecases/autenticacao/autenticar_usecase.dart'
    as _i16;
import 'package:sme_plateia/presentation/pages/login/stores/login_store.dart'
    as _i17;

import 'dependendy_module.dart' as _i18; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.singleton<_i3.AppRouter>(_i3.AppRouter());
    gh.singleton<_i4.AuthenticationService>(_i4.AuthenticationService());
    gh.factory<_i5.ChopperClient>(() => _i6.RestClient());
    await gh.factoryAsync<_i7.Dio>(
      () => injectionModule.dioClient,
      preResolve: true,
    );
    gh.factory<_i8.InternetConnectionCheckerPlus>(
        () => injectionModule.internetConnectionCheckerPlus);
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i10.AutenticacaoRemoteService>(_i10.AutenticacaoRemoteService(
      gh<_i7.Dio>(),
      baseUrl: gh<String>(),
    ));
    gh.factory<_i11.IAutenticacaoLocalDataSource>(() =>
        _i11.AutenticacaoLocalDataSource(
            sharedPreferences: gh<_i9.SharedPreferences>()));
    gh.factory<_i12.IAutenticacaoRemoteDataSource>(() =>
        _i12.AutenticacaoRemoteDataSource(
            gh<_i10.AutenticacaoRemoteService>()));
    gh.factory<_i13.INetworkInfo>(
        () => _i13.NetworkInfo(gh<_i8.InternetConnectionCheckerPlus>()));
    gh.factory<_i14.IAutenticacaoRepository>(() => _i15.AutenticacaoRepository(
          gh<_i12.IAutenticacaoRemoteDataSource>(),
          gh<_i11.IAutenticacaoLocalDataSource>(),
          gh<_i13.INetworkInfo>(),
        ));
    gh.factory<_i16.AutenticarUseCase>(
        () => _i16.AutenticarUseCase(gh<_i14.IAutenticacaoRepository>()));
    gh.factory<_i17.AutenticarStore>(
        () => _i17.AutenticarStore(gh<_i16.AutenticarUseCase>()));
    return this;
  }
}

class _$InjectionModule extends _i18.InjectionModule {}
