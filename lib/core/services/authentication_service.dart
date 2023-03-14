import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'authentication_service.g.dart';

@singleton
class AuthenticationService = AuthenticationServiceBase with _$AuthenticationService;

abstract class AuthenticationServiceBase with Store {
  @observable
  bool isAuthenticated = false;
}
