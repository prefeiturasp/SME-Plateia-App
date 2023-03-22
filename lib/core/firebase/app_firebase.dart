import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:sme_plateia/firebase_options.dart';
import 'package:sme_plateia/main.dart';

configureFirebase() async {
  try {
    logger.config('[Firebase] Configurando Firebase');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await configureAnalytics();
    await setupCrashlytics();
  } on Exception catch (e, stack) {
    logger.severe('[Firebase] Falha ao inicializar Firebase');
    await recordError(e, stack);
  }
}

setupCrashlytics() async {
  if (!kIsWeb && !Platform.isWindows) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await setUserIdentifier("codigoEOL");
}

setUserIdentifier(String identifier) async {
  if (!kIsWeb && !Platform.isWindows) {
    await FirebaseCrashlytics.instance.setUserIdentifier(identifier);
  }
}

configureAnalytics() {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
}

recordError(
  dynamic exception,
  StackTrace? stack, {
  dynamic reason,
}) async {
  if (Platform.isAndroid || Platform.isIOS) {
    await FirebaseCrashlytics.instance.recordError(exception, stack);
  } else {
    logger.severe(exception);
    logger.severe(stack);
  }
}
