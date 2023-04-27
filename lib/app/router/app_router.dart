import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@Singleton()
@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/voucher',
      page: VoucherRoute.page,
    ),

    // Listagem de eventos
    AutoRoute(
      path: '/eventos',
      page: EventosRoute.page,
    ),
    // Evento
    AutoRoute(path: '/evento/:id/detalhes/', page: EventoDetalhesRoute.page),
    AutoRoute(path: '/evento/:id/endereco/', page: EventoEnderecoRoute.page),

    // Auth
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: EsqueceuSenhaRoute.page, path: '/esqueceu-senha'),
    AutoRoute(page: LandingRoute.page, path: '/'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
