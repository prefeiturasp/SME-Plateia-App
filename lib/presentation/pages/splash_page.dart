import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sme_plateia/core/di/dependency_injection_conf.dart';
import 'package:sme_plateia/core/routes/routes.gr.dart';
import 'package:sme_plateia/core/services/authentication_service.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    AuthenticationService authService = sl();

    _redirect(authService.isAuthenticated);

    reaction((p0) => authService.isAuthenticated, (isAuthenticated) {
      _redirect(isAuthenticated);
    });
    super.initState();
  }

  _redirect(bool isAuthenticated) {
    if (isAuthenticated) {
      context.router.navigate(EventosRoute());
    } else {
      context.router.navigate(LoginRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Container(),
    );
  }
}
