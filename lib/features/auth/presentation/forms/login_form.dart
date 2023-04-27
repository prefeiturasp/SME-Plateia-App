import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/core/utils/colors.dart';
import 'package:sme_plateia/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:sme_plateia/features/auth/presentation/widgets/login_page_input_fields.dart';
import 'package:sme_plateia/features/auth/presentation/widgets/snackbar/snackbar_widgets.dart';
import 'package:sme_plateia/injector.dart';
import 'package:sme_plateia/shared/presentation/widgets/text_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(sl(), sl()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (p, c) => p.formStatus != c.formStatus,
        listener: (context, state) {
          if (state.formStatus.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
              snackBarFailureText: state.exceptionError,
            ));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmailInputField(state: state),
                SizedBox(height: 24),
                PasswordInputField(
                  state: state,
                  onEditingComplete: () => _fazerLogin(context),
                ),
                SizedBox(height: 8),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state.pageStatus == PageStatus.errorSenhaOrLogin,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Usuário ou senha incorretos",
                            style: TextStyle(
                              color: TemaUtil.vermelhoErro,
                            ),
                          ),
                          Text(
                            "Tente novamente",
                            style: TextStyle(
                              color: TemaUtil.vermelhoErro,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8 * 3),
                state.formStatus.isInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ButtonText(
                        onPressed: () async {
                          _fazerLogin(context);
                        },
                        text: 'Entrar'.toUpperCase(),
                      ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    context.pushRoute(const EsqueceuSenhaRoute());
                  },
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _fazerLogin(BuildContext context) {
    context.read<LoginCubit>().login();
  }
}
