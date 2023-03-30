import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:template/core/utils/colors.dart';
import 'package:template/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:template/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:template/features/auth/presentation/forms/login_form.dart';
import 'package:template/gen/assets.gen.dart';
import 'package:template/injector.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TemaUtil.corDeFundo,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 44),
            Center(child: Assets.images.logo.image()),
            SizedBox(height: 66),
            Expanded(
              child: BlocProvider(
                create: (_) => LoginCubit(
                  context.read<AuthCubit>(),
                  sl(),
                ),
                child: LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
