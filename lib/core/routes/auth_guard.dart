import 'package:auto_route/auto_route.dart';
import 'package:sme_plateia/core/routes/routes.gr.dart';

// mock auth state
var isAuthenticated = false;

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!isAuthenticated) {
      // ignore: unawaited_futures
      router.push(
        LoginRoute(onLoginResult: (_) {
          isAuthenticated = true;
          // we can't pop the bottom page in the navigator's stack
          // so we just remove it from our local stack
          router.markUrlStateForReplace();
          router.removeLast();
          resolver.next();
        }),
      );
    } else {
      resolver.next(true);
    }
  }
}
