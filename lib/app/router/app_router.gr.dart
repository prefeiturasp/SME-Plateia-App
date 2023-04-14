// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:sme_plateia/features/auth/presentation/pages/esqueceu_senha_page.dart' as _i3;
import 'package:sme_plateia/features/auth/presentation/pages/landing_page.dart' as _i2;
import 'package:sme_plateia/features/auth/presentation/pages/login_page.dart' as _i1;
import 'package:sme_plateia/features/counter/presentation/pages/counter_page.dart' as _i6;
import 'package:sme_plateia/features/eventos/presentation/pages/eventos_page.dart' as _i5;
import 'package:sme_plateia/features/voucher/presentation/pages/voucher_page.dart' as _i4;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LandingPage(),
      );
    },
    EsqueceuSenhaRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EsqueceuSenhaPage(),
      );
    },
    VoucherRoute.name: (routeData) {
      final args = routeData.argsAs<VoucherRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.VoucherPage(
          key: args.key,
          voucherId: args.voucherId,
        ),
      );
    },
    EventosRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EventosPage(),
      );
    },
    CounterRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CounterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LandingPage]
class LandingRoute extends _i7.PageRouteInfo<void> {
  const LandingRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EsqueceuSenhaPage]
class EsqueceuSenhaRoute extends _i7.PageRouteInfo<void> {
  const EsqueceuSenhaRoute({List<_i7.PageRouteInfo>? children})
      : super(
          EsqueceuSenhaRoute.name,
          initialChildren: children,
        );

  static const String name = 'EsqueceuSenhaRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.VoucherPage]
class VoucherRoute extends _i7.PageRouteInfo<VoucherRouteArgs> {
  VoucherRoute({
    _i8.Key? key,
    required String voucherId,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          VoucherRoute.name,
          args: VoucherRouteArgs(
            key: key,
            voucherId: voucherId,
          ),
          initialChildren: children,
        );

  static const String name = 'VoucherRoute';

  static const _i7.PageInfo<VoucherRouteArgs> page = _i7.PageInfo<VoucherRouteArgs>(name);
}

class VoucherRouteArgs {
  const VoucherRouteArgs({
    this.key,
    required this.voucherId,
  });

  final _i8.Key? key;

  final String voucherId;

  @override
  String toString() {
    return 'VoucherRouteArgs{key: $key, voucherId: $voucherId}';
  }
}

/// generated route for
/// [_i5.EventosPage]
class EventosRoute extends _i7.PageRouteInfo<void> {
  const EventosRoute({List<_i7.PageRouteInfo>? children})
      : super(
          EventosRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventosRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CounterPage]
class CounterRoute extends _i7.PageRouteInfo<void> {
  const CounterRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CounterRoute.name,
          initialChildren: children,
        );

  static const String name = 'CounterRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
