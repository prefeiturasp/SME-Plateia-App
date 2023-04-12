import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sme_plateia/app/router/app_router.gr.dart';
import 'package:sme_plateia/features/auth/data/datasources/autenticacao_local_datasource.dart';
import 'package:sme_plateia/gen/assets.gen.dart';
import 'package:sme_plateia/injector.dart';

class Cabecalho extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 8 * 5);

  const Cabecalho({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 24 for default icon size
      toolbarHeight: kToolbarHeight + 8 * 5,
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
                Text(
                  "Paloma Souza",
                  style: TextStyle(fontSize: 14),
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
                Text(
                  "Meus Eventos",
                  style: TextStyle(fontSize: 24),
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
                        style: TextStyle(fontSize: 14),
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
}