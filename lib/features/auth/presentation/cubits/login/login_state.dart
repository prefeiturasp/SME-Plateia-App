part of 'login_cubit.dart';

enum PageStatus {
  inicial,
  emptyRf,
  emptySenha,
  errorSenhaOrLogin,
  errorServer,
  sucesso,
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default(RF.pure()) RF rf,
    @Default(Senha.pure()) Senha senha,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus formStatus,
    @Default(PageStatus.inicial) PageStatus pageStatus,
    @Default('') String exceptionError,
  }) = _Initial;
}
