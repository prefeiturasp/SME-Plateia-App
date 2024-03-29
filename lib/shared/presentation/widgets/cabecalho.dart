import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:sme_plateia/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:sme_plateia/gen/assets.gen.dart';
import 'package:sme_plateia/injector.dart';

class Cabecalho extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  final height = kToolbarHeight + 8 * 5;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const Cabecalho(this.titulo, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 24 for default icon size
      toolbarHeight: height,
      centerTitle: false,
      leadingWidth: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            color: Color(0xffFBE9AE),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String nome = '';

                    state.mapOrNull(
                      authenticated: (value) {
                        var nomeCompleto = value.usuario.usuario.nome.split(' ');
                        nome = '${nomeCompleto.first} ${nomeCompleto.last}';
                      },
                    );

                    return Text(
                      nome,
                      style: TextStyle(fontSize: 14.spMin),
                    );
                  },
                ),
                Assets.images.logoTransparente.image(
                  height: 17,
                ),
              ],
            ),
          ),
          Container(
            height: kToolbarHeight,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildBackButton(context),
                    Text(
                      titulo,
                      style: TextStyle(fontSize: 24.spMin),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    await sl<IAutenticacaoLocalDataSource>().apagarToken();
                    context.replaceRoute(LoginRoute());
                  },
                  child: Row(
                    children: [
                      Text(
                        'Sair',
                        style: TextStyle(fontSize: 14.spMin),
                      ),
                      SizedBox(width: 8),
                      Assets.icons.sair.svg(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBackButton(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool canPop = parentRoute?.canPop ?? false;

    if ((canPop) || (parentRoute?.impliesAppBarDismissal ?? false)) {
      return IconButton(
        onPressed: () {
          Navigator.maybePop(context);
        },
        icon: Assets.icons.arrowBack.svg(width: 16),
      );
    }

    return SizedBox.shrink();
  }
}
