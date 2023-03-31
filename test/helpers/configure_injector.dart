import 'package:sme_plateia/core/utils/constants.dart';
import 'package:sme_plateia/injector.dart';

Future<void> configureInjector() async {
  await configureDependencies(environment: Environment.test);
}
