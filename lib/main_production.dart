import 'package:sme_plateia/app/app.dart';
import 'package:sme_plateia/bootstrap.dart';
import 'package:sme_plateia/core/utils/constants.dart';

import 'app/firebase/firebase_options_production.dart';

void main() {
  bootstrap(
    () => const App(),
    environment: Environment.production,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
