import 'package:flutter/material.dart';

import 'core/di/dependency_injection_conf.dart';
import 'core/routes/routes.dart';

void main() {
  configureDependencies();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final AppRouter _appRouter = sl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
