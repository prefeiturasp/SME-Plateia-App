import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/app/router/app_router.dart';
import 'package:template/app/router/app_router.gr.dart';
import 'package:template/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:template/injector.dart';

@RoutePage()
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    context.read<AuthCubit>().stream.listen((state) {
      if (state is Authenticated) {
        sl<AppRouter>().replaceAll([EventosRoute()]);
      } else {
        sl<AppRouter>().replaceAll([LoginRoute()]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
