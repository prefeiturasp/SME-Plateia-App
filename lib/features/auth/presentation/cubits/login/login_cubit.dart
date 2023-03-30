import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:template/features/auth/domain/entities/rf.dart';
import 'package:template/features/auth/domain/entities/senha.dart';
import 'package:template/features/auth/domain/usecases/autenticar_usecase.dart';
import 'package:template/features/auth/presentation/cubits/auth/auth_cubit.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthCubit authCubit;
  final AutenticarUseCase autenticarUseCase;

  LoginCubit(
    this.authCubit,
    this.autenticarUseCase,
  ) : super(const LoginState.initial());

  /// RF alterado
  void rfChanged(String value) {
    final rf = RF.dirty(value);
    emit(state.copyWith(
      rf: rf,
      formStatus: Formz.validate([rf, state.senha]) ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure,
      pageStatus: PageStatus.inicial,
    ));
  }

  /// Senha alterada
  void senhaChanged(String value) {
    final senha = Senha.dirty(value);
    emit(state.copyWith(
      senha: senha,
      formStatus: Formz.validate([state.rf, senha]) ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure,
      pageStatus: PageStatus.inicial,
    ));
  }

  /// Fazer login
  void login() async {
    emit(state.copyWith(
      formStatus: FormzSubmissionStatus.inProgress,
      pageStatus: PageStatus.inicial,
    ));

    if (state.rf.value.isEmpty) {
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.failure,
        pageStatus: PageStatus.emptyRf,
        exceptionError: "Preencha o campo RF",
      ));
      return;
    }

    if (state.senha.value.isEmpty) {
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.failure,
        pageStatus: PageStatus.emptySenha,
        exceptionError: "Preencha o campo Senha",
      ));
      return;
    }

    emit(state.copyWith(
      formStatus:
          Formz.validate([state.rf, state.senha]) ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure,
    ));

    try {
      if (state.formStatus == FormzSubmissionStatus.failure) {
        emit(state.copyWith(
          exceptionError: "Formulario invalido",
        ));
      } else {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

        var params = Params(
          login: state.rf.value,
          senha: state.senha.value,
        );

        var result = await autenticarUseCase(params);

        result.fold(
          (l) => emit(state.copyWith(
            formStatus: FormzSubmissionStatus.failure,
            pageStatus: PageStatus.errorSenhaOrLogin,
            exceptionError: l.message,
          )),
          (r) {
            emit(state.copyWith(
              formStatus: FormzSubmissionStatus.success,
              pageStatus: PageStatus.sucesso,
            ));
          },
        );
      }
    } on Exception catch (error) {
      emit(state.copyWith(
        exceptionError: "Erro: $error",
        formStatus: FormzSubmissionStatus.failure,
      ));
    }
  }
}
