import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'routes.gr.dart';

@singleton
@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/eventos',
      page: EventosRoute.page,
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SplashRoute.page, path: '/'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
