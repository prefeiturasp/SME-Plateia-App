import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:sme_plateia/core/firebase/app_firebase.dart';

import 'core/di/dependency_injection_conf.dart';
import 'core/routes/routes.dart';

var logger = Logger('Main');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureFirebase();
  await configureDependencies();

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
