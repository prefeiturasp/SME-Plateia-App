import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sme_plateia/injector.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

configureCacheImage() async {
  String storageLocation = (await getApplicationDocumentsDirectory()).path;

  await FastCachedImageConfig.init(
    subDir: storageLocation,
    clearCacheAfter: const Duration(
      days: 15,
    ),
  );
}

setup({
  required String environment,
  FirebaseOptions? firebaseOptions,
}) async {
  await configureDependencies(environment: environment);
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  //Bloc.observer = AppBlocObserver();

  if (firebaseOptions != null) {
    await Firebase.initializeApp(
      options: firebaseOptions,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  // Dependencies
  await configureCacheImage();
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required String environment,
  FirebaseOptions? firebaseOptions,
}) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await setup(environment: environment, firebaseOptions: firebaseOptions);
      return runApp(await builder());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
