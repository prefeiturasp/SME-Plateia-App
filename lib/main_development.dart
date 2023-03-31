import 'package:sme_plateia/app/app.dart';
import 'package:sme_plateia/bootstrap.dart';
import 'package:sme_plateia/core/utils/constants.dart';

import 'app/firebase/firebase_options_development.dart';

void main() {
  bootstrap(
    () => const App(),
    environment: Environment.development,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
