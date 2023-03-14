import 'package:chopper/chopper.dart';

part 'login_remote_datasource.chopper.dart';

@ChopperApi(baseUrl: 'v1/login')
abstract class LoginRemoteDataSource extends ChopperService {
  static LoginRemoteDataSource create(ChopperClient client) => _$LoginRemoteDataSource(client);

  @Post()
  Future<void> login(
    @Field() login,
    @Field() senha,
  );
}
