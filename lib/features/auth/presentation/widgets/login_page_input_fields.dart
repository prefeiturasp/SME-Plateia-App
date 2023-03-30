import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/features/auth/presentation/cubits/login/login_cubit.dart';

import 'auth_text_field.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({Key? key, required this.state}) : super(key: key);
  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      labelText: 'RF',
      keyboardType: TextInputType.number,
      autofillHints: [AutofillHints.nickname],
      hasError: state.pageStatus == PageStatus.emptyRf || state.pageStatus == PageStatus.errorSenhaOrLogin,
      onChanged: (rf) => context.read<LoginCubit>().rfChanged(rf),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({Key? key, required this.state, required this.onEditingComplete}) : super(key: key);
  final LoginState state;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      labelText: 'Senha',
      isPasswordField: true,
      keyboardType: TextInputType.text,
      autofillHints: [AutofillHints.password],
      hasError: state.pageStatus == PageStatus.emptySenha || state.pageStatus == PageStatus.errorSenhaOrLogin,
      onChanged: (password) => context.read<LoginCubit>().senhaChanged(password),
      onEditingComplete: onEditingComplete,
    );
  }
}
